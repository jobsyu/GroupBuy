//
//  CityViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//
#define duration 0.5

#import "CityViewController.h"
#import "MJExtension.h"
#import "CityGroup.h"
#import "Masonry.h"
#import "CitySearchResultViewController.h"

@interface CityViewController()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong) NSArray *cityGroups;
@property (weak, nonatomic) IBOutlet UIButton *cover;
- (IBAction)coverClick;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak,nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) CitySearchResultViewController *citySearchResult;
@end

@implementation CityViewController

-(CitySearchResultViewController *)citySearchResult
{
    if (!_citySearchResult) {
        CitySearchResultViewController *citySearchResult = [[CitySearchResultViewController alloc] init];
        [self addChildViewController:citySearchResult];
        self.citySearchResult = citySearchResult;
        
        [self.view addSubview:self.citySearchResult.view];
        [self.citySearchResult.view autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.citySearchResult.view autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:15];
    }
    return _citySearchResult;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"城市切换";
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(close) image:@"btn_navigation_close" selectedImage:@"btn_navigation_close_hl"];
    
    self.tableView.sectionIndexColor = [UIColor blackColor];
    
    self.cityGroups = [CityGroup objectArrayWithFilename:@"cityGroups.plist"];
    
    self.searchBar.tintColor = GBColor(32, 191, 179);
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 搜索框代理方法
/**
 *  键盘弹出，文本框开始编辑
 */
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //1.隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //2.修改搜索框背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield_hl"];
    
    //3.显示取消按钮
    searchBar.showsCancelButton = YES;
    
    //4.显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.5;
    }];
//    //添加遮盖
//    UIButton *cover = [[UIButton alloc] init];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.5;
//    cover.tag = groupTag;
//    [cover addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:searchBar action:@selector(resignFirstResponder)]];
//    [self.view addSubview:cover];
//    [cover mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView.mas_left);
//        make.right.equalTo(self.tableView.mas_right);
//        make.top.equalTo(self.tableView.mas_top);
//        make.bottom.equalTo(self.tableView.mas_bottom);
//    }];
    self.citySearchResult.view.hidden = YES;
    self.searchBar.text = nil;
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //1.显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    //2.修改搜索框背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"bg_login_textfield"];
    
    //3.隐藏取消按钮
    searchBar.showsCancelButton = NO;
    
    //4.隐藏遮盖
    [UIView animateWithDuration:duration animations:^{
        self.cover.alpha = 0;
    }];
    //[[self.view viewWithTag:groupTag] removeFromSuperview];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length) {
        self.citySearchResult.searchText =searchText;
        self.citySearchResult.view.hidden = NO;
    } else{
        self.citySearchResult.view.hidden = YES;
    }
}

-(IBAction)coverClick
{
    [self.searchBar resignFirstResponder];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CityGroup *group = self.cityGroups[section];
    return group.cities.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    
    CityGroup *group = self.cityGroups[indexPath.section];
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CityGroup *group = self.cityGroups[section];
    return group.title;
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return  [self.cityGroups valueForKey:@"title"];
}

#pragma mark - 代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CityGroup *group = self.cityGroups[indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:CityDidChangeNotification object:nil userInfo:@{SelectCityName : group.cities[indexPath.row]}];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
