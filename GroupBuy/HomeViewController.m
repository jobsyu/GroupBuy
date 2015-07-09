//
//  HomeViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#define rightNavWidth 60

#import "HomeViewController.h"
#import "HomeTopItem.h"
#import "CategoryViewController.h"
#import "RegionViewController.h"
#import "City.h"
#import "MetaTool.h"
#import "SortViewController.h"
#import "Sort.h"


@interface HomeViewController()
@property (nonatomic,weak) UIBarButtonItem *categoryItem;
@property (nonatomic,weak) UIBarButtonItem *regionItem;
@property (nonatomic,weak) UIBarButtonItem *sortItem;

@property (nonatomic,strong) UIPopoverController *popover;

@property (nonatomic,copy) NSString *selectedCityName;
@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";


-(instancetype)init
{
    UICollectionViewLayout *layout = [[UICollectionViewLayout alloc] init];
    return [self initWithCollectionViewLayout:layout];
}


-(void)viewDidLoad{
    [super viewDidLoad];
    
    //设置背景色
    self.collectionView.backgroundColor = GBGlobalBg;
    
    //Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityDidChange:) name:CityDidChangeNotification object:nil];
    
    [MTNotificationCenter addObserver:self selector:@selector(sortDidChange:) name:SortDidChangeNotification object:nil];
    
    //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];
}


-(void)dealloc
{
    [MTNotificationCenter removeObserver:nil];
}

#pragma mark －点击城市通知事件
-(void)cityDidChange:(NSNotification *)notification
{
    self.selectedCityName = notification.userInfo[SelectCityName];
    HomeTopItem *topItem = (HomeTopItem *)self.regionItem.customView;
    [topItem setTitle:[NSString stringWithFormat:@"%@ - 全部",self.selectedCityName]];
    [topItem setSubTitle:nil];
}
     
-(void)sortDidChange:(NSNotification *)notification
{
    Sort *sort = notification.userInfo[SelectSort];
    HomeTopItem *topItem = (HomeTopItem *)self.sortItem.customView;
    [topItem setTitle:sort.label];
}

#pragma mark 设置导航栏内容
-(void)setupLeftNav
{
    //1.LOGO
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logo.enabled = NO;
    
    //2.类别
    HomeTopItem *categoryTopItem = [HomeTopItem item];
    [categoryTopItem addTarget:self action:@selector(categoryClick)];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithCustomView:categoryTopItem];
    self.categoryItem = category;
    
    //3.地区
    HomeTopItem *regionTopItem = [HomeTopItem item];
    [regionTopItem addTarget:self action:@selector(regionClick)];
    UIBarButtonItem *region = [[UIBarButtonItem alloc] initWithCustomView:regionTopItem];
    self.regionItem = region;
    
    //4.排序
    HomeTopItem *sortTopItem = [HomeTopItem item];
    [sortTopItem addTarget:self action:@selector(sortClick)];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    self.sortItem = sort;
    
    self.navigationItem.leftBarButtonItems = @[logo,category,region,sort];
    
}

-(void)setupRightNav
{
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" selectedImage:@"icon_search_highlighted"];
    searchItem.customView.width = rightNavWidth;
    
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" selectedImage:@"icon_map_highlighted"];
    searchItem.customView.width = rightNavWidth;
    
    self.navigationItem.rightBarButtonItems= @[searchItem,mapItem];
}


#pragma mark 顶部item点击方法
-(void)categoryClick
{
    UIPopoverController *categoryPopover = [[UIPopoverController alloc] initWithContentViewController:[[CategoryViewController alloc]init]];
    
    [categoryPopover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    //self.popover = popover;
}

-(void)regionClick
{
    RegionViewController *region = [[RegionViewController alloc] init];
    if (self.selectedCityName) {
        City *city = [[[MetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] firstObject];
        region.regions = city.regions;
        
    }
    UIPopoverController *regionPopover = [[UIPopoverController alloc] initWithContentViewController:region];
    [regionPopover presentPopoverFromBarButtonItem:self.regionItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

-(void)sortClick
{
    UIPopoverController *sortPopover = [[UIPopoverController alloc] initWithContentViewController:[[SortViewController alloc] init]];
    [sortPopover presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

@end
