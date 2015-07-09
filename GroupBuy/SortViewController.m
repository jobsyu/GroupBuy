//
//  SortViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "SortViewController.h"
#import "MetaTool.h"
#import "Sort.h"

@implementation SortViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSArray *sorts = [MetaTool sorts];
    NSUInteger count = sorts.count;
    CGFloat btnW = 100;
    CGFloat btnH = 30;
    CGFloat btnX = 15;
    CGFloat btnStartY = 15;
    CGFloat btnMargin = 15;
    CGFloat height = 0;
    for (NSUInteger i = 0; i<count; i++) {
        Sort *sort = sorts[i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.width = btnW;
        button.height = btnH;
        button.x = btnX;
        button.y = btnStartY + i *(btnH + btnMargin);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitle:sort.label forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"btn_filter_selected"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [self.view  addSubview:button];
        
        height = CGRectGetMaxY(button.frame);
        
    }
    
    //设置控制器在popover中的尺寸
    CGFloat width = btnW + 2 *btnX;
    height += btnMargin;
    self.preferredContentSize = CGSizeMake(width, height);
    
}

-(void)buttonClick:(UIButton *)button
{
    [MTNotificationCenter postNotificationName:SortDidChangeNotification object:nil userInfo:
     @{SelectSort :[MetaTool sorts][button.tag]}];
}


@end
