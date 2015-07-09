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
#import "Categorys.h"
#import "Region.h"
#import "Deal.h"
#import "MJRefresh.h"
#import "NavigationController.h"
#import "SearchViewController.h"


@interface HomeViewController()
@property (nonatomic,weak) UIBarButtonItem *categoryItem;
@property (nonatomic,weak) UIBarButtonItem *regionItem;
@property (nonatomic,weak) UIBarButtonItem *sortItem;

@property (nonatomic,strong) UIPopoverController *categoryPopover;
@property (nonatomic,strong) UIPopoverController *regionPopover;
@property (nonatomic,strong) UIPopoverController *sortPopover;

@property (nonatomic,copy) NSString *selectedCityName;
@property (nonatomic,copy) NSString *selectedRegionName;
@property (nonatomic,copy) NSString *selectedCategoryName;
@property (nonatomic,strong) Sort *selectedSort;
@end

@implementation HomeViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    
    //监听通知
    [MTNotificationCenter addObserver:self selector:@selector(cityDidChange:) name:CityDidChangeNotification object:nil];
    [MTNotificationCenter addObserver:self selector:@selector(categoryDidChange:) name:CategoryDidChangeNotification object:nil];
    [MTNotificationCenter addObserver:self selector:@selector(regionDidChange:) name:RegionDidChangeNotification object:nil];
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
    
    [self.collectionView headerBeginRefreshing];
}

-(void)categoryDidChange:(NSNotification *)notification
{
    Categorys *category = notification.userInfo[SelectCategory];
    NSString *subCategory = notification.userInfo[SelectSubCategoryName];
    
    if (subCategory == nil || [subCategory isEqualToString:@"全部"]) {
        self.selectedCategoryName = category.name;
    } else {
        self.selectedCategoryName = subCategory;
    }
    
    if ([self.selectedCategoryName isEqualToString:@"全部分类"]) {
        self.selectedCategoryName = nil;
    }
    
    HomeTopItem *categoryItem = (HomeTopItem *)self.categoryItem.customView;
    [categoryItem setTitle:category.name];
    [categoryItem setSubTitle:subCategory];
    [categoryItem setIcon:category.small_icon selectIcon:category.small_highlighted_icon];
    
    [self.categoryPopover dismissPopoverAnimated:YES];
    
    [self.collectionView headerBeginRefreshing];
}

-(void)regionDidChange:(NSNotification *)notification
{
    Region *region = notification.userInfo[SelectRegion];
    NSString *subRegion = notification.userInfo[SelectSubRegionName];
    
    if (subRegion == nil || [subRegion isEqualToString:@"全部"]) {
        self.selectedRegionName = region.name;
    } else {
        self.selectedRegionName = subRegion;
    }
    
    if ([self.selectedRegionName isEqualToString:@"全部"]) {
        self.selectedRegionName = nil;
    }
    
    HomeTopItem *regionItem = (HomeTopItem *)self.regionItem.customView;
    [regionItem setTitle:[NSString stringWithFormat:@"%@ - %@ ",self.selectedCityName,region.name]];
    [regionItem setSubTitle:subRegion];
    
    [self.regionPopover dismissPopoverAnimated:YES];
    [self.collectionView headerBeginRefreshing];
}

-(void)sortDidChange:(NSNotification *)notification
{
    self.selectedSort = notification.userInfo[SelectSort];
    HomeTopItem *topItem = (HomeTopItem *)self.sortItem.customView;
    [topItem setTitle:self.selectedSort.label];
    [self.sortPopover dismissPopoverAnimated:YES];
    [self.collectionView headerBeginRefreshing];
}

#pragma mark －实现夫类提供的方法
-(void)setupParams:(NSMutableDictionary *)params
{
    //城市
    params[@"city"] = self.selectedCityName;
    //分类（类别）
    if (self.selectedCategoryName) {
        params[@"category"] =self.selectedCategoryName;
    }
    //区域
    if (self.selectedRegionName) {
        params[@"region"] = self.selectedRegionName;
    }
    //排序
    if(self.selectedSort){
        params[@"sort"] = @(self.selectedSort.value);
    }
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
    [sortTopItem setTitle:@"排序"];
    [sortTopItem setIcon:@"icon_sort" selectIcon:@"icon_sort_highlighted"];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    self.sortItem = sort;
    
    self.navigationItem.leftBarButtonItems = @[logo,category,region,sort];
    
}

-(void)setupRightNav
{
    UIBarButtonItem *searchItem = [UIBarButtonItem itemWithTarget:self action:@selector(search) image:@"icon_search" selectedImage:@"icon_search_highlighted"];
    searchItem.customView.width = rightNavWidth;
    
    UIBarButtonItem *mapItem = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" selectedImage:@"icon_map_highlighted"];
    searchItem.customView.width = rightNavWidth;
    
    self.navigationItem.rightBarButtonItems= @[searchItem,mapItem];
}



#pragma mark 顶部item点击方法

-(void)search
{
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:[[SearchViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)categoryClick
{
    self.categoryPopover = [[UIPopoverController alloc] initWithContentViewController:[[CategoryViewController alloc]init]];
    
    [self.categoryPopover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    //self.popover = popover;
}

-(void)regionClick
{
    RegionViewController *region = [[RegionViewController alloc] init];
    if (self.selectedCityName) {
        City *city = [[[MetaTool cities] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name = %@",self.selectedCityName]] firstObject];
        region.regions = city.regions;
        
    }
    self.regionPopover = [[UIPopoverController alloc] initWithContentViewController:region];
    [self.regionPopover presentPopoverFromBarButtonItem:self.regionItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    region.popover = self.regionPopover;
}

-(void)sortClick
{
    self.sortPopover = [[UIPopoverController alloc] initWithContentViewController:[[SortViewController alloc] init]];
    [self.sortPopover presentPopoverFromBarButtonItem:self.sortItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


@end
