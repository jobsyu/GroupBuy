//
//  HomeTopItem.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTopItem : UIView

+(instancetype)item;

/**
 *  设置点击的监听器
 *
 *  @param target 监听器
 *  @param action 监听方法
 */
-(void)addTarget:(id)target action:(SEL)action;

@end
