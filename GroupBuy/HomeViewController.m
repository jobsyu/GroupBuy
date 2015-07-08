//
//  HomeViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopItem.h"

@interface HomeViewController()


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
    
    //设置导航栏按钮
    [self setupLeftNav];
    [self setupRightNav];
}

-(void)setupLeftNav
{
    //1.LOGO
    UIBarButtonItem *logo = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_meituan_logo"] style:UIBarButtonItemStyleDone target:nil action:nil];
    logo.enabled = NO;
    
    //2.类别
    HomeTopItem *categoryItem = [HomeTopItem item];
    UIBarButtonItem *category = [[UIBarButtonItem alloc] initWithCustomView:categoryItem];
    
    //3.地区
    HomeTopItem *cityItem = [HomeTopItem item];
    UIBarButtonItem *city = [[UIBarButtonItem alloc] initWithCustomView:cityItem];
    
    //4.排序
    HomeTopItem *sortItem = [HomeTopItem item];
    UIBarButtonItem *sort = [[UIBarButtonItem alloc] initWithCustomView:sortItem];
    
    self.navigationItem.leftBarButtonItems = @[logo,category,city,sort];
    
}

-(void)setupRightNav
{
   UIBarButtonItem *search = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_search" selectedImage:@"icon_search_highlighted"];
    
   UIBarButtonItem *map = [UIBarButtonItem itemWithTarget:nil action:nil image:@"icon_map" selectedImage:@"icon_map_highlighted"];
    
    self.navigationItem.rightBarButtonItems= @[search,map];
}
@end
