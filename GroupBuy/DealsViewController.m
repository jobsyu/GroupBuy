//
//  DealsViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DealsViewController.h"
#import "DPAPI.h"
#import "MJRefresh.h"
#import "Deal.h"
#import "MJExtension.h"
#import "DealCell.h"
#import "MBProgressHUD+MJ.h"
#import "DetailViewController.h"
//#import "NavigationController.h"

@interface DealsViewController() <DPRequestDelegate>
/** 所有的团购数据 */
@property (nonatomic,strong) NSMutableArray *deals;
@property (nonatomic,weak) UIImageView *noDataView;

/** 记录当前页码 */
@property (nonatomic,assign) int currentPage;
/** 总数 */
@property (nonatomic,assign) int totalCount;
/** 最后一个请求 */
@property (nonatomic,assign) DPRequest *lastRequest;
@end

@implementation DealsViewController
static NSString * const reuseIdentifier = @"deal";

-(NSMutableArray *)deals
{
    if (!_deals) {
        self.deals = [[NSMutableArray alloc] init];
    }
    return _deals;
}

-(UIImageView *)noDataView
{
    if (!_noDataView) {
        //添加一个“没有数据”的提醒
        UIImageView *noDataView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_deals_empty"]];
        [self.view addSubview:noDataView];
        [noDataView autoCenterInSuperview];
        self.noDataView =noDataView;
    }
    return _noDataView;
}

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell的大小
    layout.itemSize = CGSizeMake(305, 305);
    return [self initWithCollectionViewLayout:layout];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //设置背景色
    self.collectionView.backgroundColor = GBGlobalBg;
    
    //Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"DealCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.alwaysBounceVertical =YES;
    
    [self.collectionView addFooterWithTarget:self action:@selector(loadMoreDeals)];
    [self.collectionView addHeaderWithTarget:self action:@selector(loadNewDeals)];
}

/**
 当屏幕旋转,控制器view的尺寸发生改变调用
 */
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // 根据屏幕宽度决定列数
    int cols = (size.width == 1024) ? 3 : 2;
    
    // 根据列数计算内边距
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    CGFloat inset = (size.width - cols * layout.itemSize.width) / (cols + 1);
    layout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // 设置每一行之间的间距
    layout.minimumLineSpacing = inset;
}

#pragma mark －跟服务器交互
-(void)loadDeals
{
    DPAPI *api = [[DPAPI alloc] init];
    NSMutableDictionary *params =[NSMutableDictionary dictionary];
    //调用子类实现的方法
    [self setupParams:params];
    //每页的条数
    params[@"limit"] =@30;
        //页码
    params[@"page"] = @(self.currentPage);
    self.lastRequest = [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

-(void)loadMoreDeals
{
    self.currentPage++;
    
    [self loadDeals];
}

-(void)loadNewDeals
{
    self.currentPage = 1;
    
    [self loadDeals];
}

-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    if(request != self.lastRequest) return;
    self.totalCount = [result[@"total_count"] intValue];
    //1.取出团购的字典数组
    NSArray *newDeals = [Deal objectArrayWithKeyValuesArray:result[@"deals"]];
    if(self.currentPage == 1){//清除之前的旧数据
        [self.deals removeAllObjects];
    }
    [self.deals addObjectsFromArray:newDeals];
    //2.刷新表格
    [self.collectionView reloadData];
    
    //3.结束上拉加载
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    if (request != self.lastRequest) return;
    
    //1.提醒失败
    [MBProgressHUD showError:@"网络繁忙,请稍候再试" toView:self.view];
    
    [self.collectionView headerEndRefreshing];
    [self.collectionView footerEndRefreshing];
    
    //3.如果是上拉加载失败了
    if (self.currentPage >1) {
        self.currentPage--;
    }
    GBLog(@"请求失败--%@",error);
}

#pragma mark UICollectionView 数据源
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //计算一遍内边距
    [self viewWillTransitionToSize:CGSizeMake(collectionView.width, 0) withTransitionCoordinator:nil];
    
    //控制尾部刷新控件的显示和隐藏
    self.collectionView.footerHidden = (self.deals.count == self.totalCount);
    self.noDataView.hidden = (self.deals.count != 0);
    return self.deals.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

#pragma mark UICollectionViewDelegate 方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVc = [[DetailViewController alloc] init];
    detailVc.deal = self.deals[indexPath.item];
    //NavigationController *nav = [[NavigationController alloc] initWithRootViewController:detailVc];
    [self presentViewController:detailVc animated:YES completion:nil];
}
@end
