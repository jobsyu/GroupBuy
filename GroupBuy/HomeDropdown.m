//
//  HomeDropdown.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeDropdown.h"
#import "Categorys.h"
#import "HomeDropdownMainCell.h"
#import "HomeDropdownSubCell.h"

@interface HomeDropdown()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,weak) IBOutlet UITableView *mainTableView;
@property (nonatomic,weak) IBOutlet UITableView *subTableView;

@property (nonatomic,strong) Categorys *selectedCategory;
@end

@implementation HomeDropdown

+(instancetype)dropdown
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeDropdown" owner:nil options:nil] firstObject];
}

-(void)awakeFromNib
{
    //不需要随父控件的尺寸变化而伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}

#pragma mark - UITableViewDataSource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.mainTableView) {
        return  self.categories.count;
    }else {
        return  self.selectedCategory.subcategories.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.mainTableView) {
        cell = [HomeDropdownMainCell cellWithTableView:tableView];
        //设置文字
        Categorys *category = self.categories[indexPath.row];
        cell.textLabel.text = category.name;
        cell.imageView.image = [UIImage imageNamed:category.small_icon];
        if (category.subcategories.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
        
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }else { //从表
        cell = [HomeDropdownSubCell cellWithTableView:tableView];
        
        cell.textLabel.text = self.selectedCategory.subcategories[indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(tableView == self.mainTableView)
   {
       self.selectedCategory = self.categories[indexPath.row];
       
       [self.subTableView reloadData];
   }
}

@end
