//
//  HomeDropdownSubCell.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeDropdownSubCell.h"

@implementation HomeDropdownSubCell
#pragma mark － 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"SubView";
    HomeDropdownSubCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[HomeDropdownSubCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    return cell;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_rightpart"];
        self.backgroundView = bg;
        
        UIImageView *selectBg = [[UIImageView alloc] init];
        selectBg.image = [UIImage imageNamed:@"bg_dropdown_right_selected"];
        self.selectedBackgroundView = selectBg;
    }
    return self;
}
@end
