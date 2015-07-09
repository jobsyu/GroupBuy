//
//  CenterLineLabel.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "CenterLineLabel.h"

@implementation CenterLineLabel

-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 画线
    // 设置起点
    //    CGContextMoveToPoint(ctx, 0, rect.size.height * 0.5);
    //    // 连线到另一个点
    //    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height * 0.5);
    //    // 渲染
    //    CGContextStrokePath(ctx);
}

@end
