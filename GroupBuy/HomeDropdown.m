//
//  HomeDropdown.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeDropdown.h"
//#import "Categorys.h"
#import "HomeDropdownMainCell.h"
#import "HomeDropdownSubCell.h"
#import "Region.h"

@interface HomeDropdown()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *mainTableView;
@property (nonatomic,weak) IBOutlet UITableView *subTableView;

//@property (nonatomic,strong) Categorys *selectedCategory;
//@property (nonatomic,strong) Region *selectedRegion;
/** 左边主表选中的行号*/
@property (nonatomic,assign) NSInteger selectedMainRow;


@end

@implementation HomeDropdown



+(instancetype)dropdown
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeDropdown" owner:nil options:nil] firstObject];
}

-(void)awakeFromNib
{
    // 不需要跟随父控件的尺寸变化而伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}

#pragma mark - UITableViewDataSource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return  [self.dataSource numberOfRowsInMainTable:self];
    }else {
        return  [self.dataSource homeDropdown:self subdataForRowInMainTable:self.selectedMainRow].count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        cell = [HomeDropdownMainCell cellWithTableView:tableView];
        //设置文字
//        Region *region = self.regions[indexPath.row];
        cell.textLabel.text = [self.dataSource homeDropdown:self titleForRowInMainTable:indexPath.row];
        //cell.imageView.image = [UIImage imageNamed:region];
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:iconForRowInMainTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource homeDropdown:self iconForRowInMainTable:indexPath.row]];
        }
        if ([self.dataSource respondsToSelector:@selector(homeDropdown:selectedIconForRowInMainTable:)]) {
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource homeDropdown:self selectedIconForRowInMainTable:indexPath.row]];
        }
        NSArray *subdata  =[self.dataSource homeDropdown:self subdataForRowInMainTable:indexPath.row];
        
        if (subdata.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
        
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else { //从表
        cell = [HomeDropdownSubCell cellWithTableView:tableView];
        
        NSArray *subdata  =[self.dataSource homeDropdown:self subdataForRowInMainTable:self.selectedMainRow];
        
        cell.textLabel.text = subdata[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(tableView == self.mainTableView)
   {
       self.selectedMainRow = indexPath.row;
       
       [self.subTableView reloadData];
       
       if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInMainTable:)]) {
           [self.delegate homeDropdown:self didSelectRowInMainTable:indexPath.row];
       }
   } else if (tableView == self.subTableView){
       if ([self.delegate respondsToSelector:@selector(homeDropdown:didSelectRowInSubTable:inMainTable:)]) {
           [self.delegate homeDropdown:self didSelectRowInSubTable:indexPath.row inMainTable:self.selectedMainRow];
       }
   }
}

@end
