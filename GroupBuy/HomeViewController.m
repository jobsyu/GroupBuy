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

@interface HomeViewController()
@property (nonatomic,weak) UIBarButtonItem *categoryItem;
@property (nonatomic,weak) UIBarButtonItem *cityItem;
@property (nonatomic,weak) UIBarButtonItem *sortItem;

@property (nonatomic,strong) UIPopoverController *popover;

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
    
    //设置导航栏内容
    [self setupLeftNav];
    [self setupRightNav];
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
    HomeTopItem *cityTopItem = [HomeTopItem item];
    [cityTopItem addTarget:self action:@selector(cityClick)];
    UIBarButtonItem *city = [[UIBarButtonItem alloc] initWithCustomView:cityTopItem];
    self.cityItem = city;
    
    //4.排序
    HomeTopItem *sortTopItem = [HomeTopItem item];
    [sortTopItem addTarget:self action:@selector(sortClick)];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithCustomView:sortTopItem];
    self.sortItem = sort;
    
    self.navigationItem.leftBarButtonItems = @[logo,category,city,sort];
    
}

-(void)setupRightNav
{
    UIBarButtonItem *search = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" selectedImage:@"icon_search_highlighted"];
    search.customView.width = rightNavWidth;
    
    UIBarButtonItem *map = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" selectedImage:@"icon_map_highlighted"];
    search.customView.width = rightNavWidth;
    
    self.navigationItem.rightBarButtonItems= @[search,map];
}


#pragma mark 顶部item点击方法
-(void)categoryClick
{
    UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:[[CategoryViewController alloc]init]];
    
    [popover presentPopoverFromBarButtonItem:self.categoryItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    self.popover = popover;
}

-(void)cityClick
{
  
}

-(void)sortClick
{
   
}

@end
