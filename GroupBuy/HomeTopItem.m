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

@end

@implementation HomeTopItem

+(instancetype)item
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HomeTopItem" owner:nil options:nil] firstObject];
}

- (void)addTarget:(id)target action:(SEL)action
{
    [self.iconButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

@end
