//
//  RegionViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "RegionViewController.h"
#import "HomeDropdown.h"
#import "CityViewController.h"
#import "NavigationController.h"

@interface RegionViewController()
-(IBAction)changeCity;
@end
@implementation RegionViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //创建下拉菜单
    UIView *title = [self.view.subviews firstObject];
    HomeDropdown *dropDown = [HomeDropdown dropdown];
    dropDown.y = title.height;
    [self.view addSubview:dropDown];
    
    //设置尺寸
    self.preferredContentSize = CGSizeMake(dropDown.width, CGRectGetMaxY(dropDown.frame));
    
}

-(IBAction)changeCity{
    CityViewController *cityVc = [[CityViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:cityVc];
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nav animated:YES completion:nil];
}

@end
