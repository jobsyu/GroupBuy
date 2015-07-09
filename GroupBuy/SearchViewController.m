//
//  SearchViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "SearchViewController.h"
#import "MJRefresh.h"

@interface SearchViewController()<UISearchBarDelegate>

@end

@implementation SearchViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //左边的返回
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"icon_back" selectedImage:@"icon_back_highlighted"];
    
    //中间的搜索框
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder= @"请输入关键字";
    searchBar.delegate = self;
    self.navigationItem.titleView =  searchBar;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark －搜索框代理
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //进入下拉刷新状态，发送请求给服务器
    [self.collectionView headerBeginRefreshing];
    
    //退出键盘
    [searchBar resignFirstResponder];
}

#pragma mark －实现与父类提供的方法
-(void)setupParams:(NSMutableDictionary *)params
{
    params[@"city"] = @"北京";
    UISearchBar *bar =(UISearchBar *)self.navigationItem.titleView;
    params[@"keyword"] = bar.text;
}

@end
