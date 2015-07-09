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
#import "MetaTool.h"

@interface CategoryViewController()<HomeDropdownDataSource,HomeDropdownDelegate>

@end

@implementation CategoryViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    HomeDropdown *dropDown = [HomeDropdown dropdown];
    //加载分类数据
    //dropDown.categories = [Categorys objectArrayWithFilename:@"categories.plist"];
    dropDown.dataSource =self;
    dropDown.delegate =self;
    self.view =dropDown;
    
    //设置控制器view在popover中的尺寸
    self.preferredContentSize = dropDown.size;
}

#pragma mark HomeDropdownDataSource
-(NSInteger)numberOfRowsInMainTable:(HomeDropdown *)homeDropdown
{
    return [MetaTool categories].count;
}

-(NSString *)homeDropdown:(HomeDropdown *)homeDropdown titleForRowInMainTable:(NSInteger)row
{
    Categorys *category = [MetaTool categories][row];
    return category.name;
}

-(NSArray *)homeDropdown:(HomeDropdown *)homeDropdown subdataForRowInMainTable:(NSInteger)row
{
    Categorys *category = [MetaTool categories][row];
    return category.subcategories;
}

-(NSString *)homeDropdown:(HomeDropdown *)homeDropdown iconForRowInMainTable:(NSInteger)row
{
    Categorys *category = [MetaTool categories][row];
    return category.small_icon;
}

-(NSString *)homeDropdown:(HomeDropdown *)homeDropdown selectedIconForRowInMainTable:(NSInteger)row
{
    Categorys *category = [MetaTool categories][row];
    return category.small_highlighted_icon;
}

-(void)homeDropdown:(HomeDropdown *)homeDropdown didSelectRowInMainTable:(NSInteger)row
{
    Categorys *category = [MetaTool categories][row];
    if(category.subcategories.count == 0)
    {
        [MTNotificationCenter postNotificationName:CategoryDidChangeNotification object:nil userInfo:
         @{SelectCategory : category}];
    }
}

-(void)homeDropdown:(HomeDropdown *)homeDropdown didSelectRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow
{
    Categorys *category = [MetaTool categories][mainRow];
    [MTNotificationCenter postNotificationName:CategoryDidChangeNotification object:nil userInfo:
     @{SelectCategory : category , SelectSubCategoryName : category.subcategories[subRow]}];
}
@end
