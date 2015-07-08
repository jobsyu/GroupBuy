//
//  CategoryViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "CategoryViewController.h"
#import "HomeDropdown.h"
#import "MJExtension.h"
#import "Categorys.h"

@implementation CategoryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    HomeDropdown *dropDown = [HomeDropdown dropdown];
    //加载分类数据
    dropDown.categories = [Categorys objectArrayWithFilename:@"categories.plist"];
    [self.view addSubview:dropDown];
    
    //设置控制器view在popover中的尺寸
    self.preferredContentSize = dropDown.size;
}

@end
