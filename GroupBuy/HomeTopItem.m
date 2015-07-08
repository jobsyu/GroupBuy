//
//  HomeTopItem.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "HomeTopItem.h"

@interface HomeTopItem()
@property (weak, nonatomic) IBOutlet UIButton *iconButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation HomeTopItem

+(instancetype)item
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeTopItem" owner:nil options:nil] firstObject];
}

-(void)awakeFromNib
{
    //不需要随父控件的尺寸变化而伸缩
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(void)setSubTitle:(NSString *)subtitle
{
    self.subtitleLabel.text = subtitle;
}

-(void)setIcon:(NSString *)Icon selectIcon:(NSString *)selectIcon
{
    [self.iconButton setImage:[UIImage imageNamed:Icon] forState:UIControlStateNormal];
    [self.iconButton setImage:[UIImage imageNamed:selectIcon] forState:UIControlStateHighlighted];
}
@end
