//
//  HomeDropdown.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeDropdown;

@protocol HomeDropdownDataSource <NSObject>
/**
 *   左边表格一共有多少行
 */
-(NSInteger)numberOfRowsInMainTable:(HomeDropdown *)homeDropdown;
/**
 *   左边表格每一行的标题
 */
-(NSString *)homeDropdown:(HomeDropdown *)homeDropdown titleForRowInMainTable:(NSInteger)row;
/**
 *   左边表格每一行的子数据
 */
-(NSArray *)homeDropdown:(HomeDropdown *)homeDropdown subdataForRowInMainTable:(NSInteger)row;
@optional
/**
 *  左边表格每一行的图标
 *  @param row          行号
 */
- (NSString *)homeDropdown:(HomeDropdown *)homeDropdown iconForRowInMainTable:(NSInteger)row;
/**
 *  左边表格每一行的选中图标
 *  @param row          行号
 */
- (NSString *)homeDropdown:(HomeDropdown *)homeDropdown selectedIconForRowInMainTable:(NSInteger)row;
@end

@protocol HomeDropdownDelegate <NSObject>

@optional
-(void)homeDropdown:(HomeDropdown *)homeDropdown didSelectRowInMainTable:(NSInteger)row;
-(void)homeDropdown:(HomeDropdown *)homeDropdown didSelectRowInSubTable:(NSInteger)subRow inMainTable:(NSInteger)mainRow;
@end

@interface HomeDropdown : UIView

+(instancetype)dropdown;
@property (nonatomic,weak) id<HomeDropdownDelegate> delegate;
@property (nonatomic,weak) id<HomeDropdownDataSource> dataSource;
@end
