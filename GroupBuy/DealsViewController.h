//
//  DealsViewController.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsViewController : UICollectionViewController
/**
 *  设置请求参数：交给子类去实现
 */
-(void)setupParams:(NSMutableDictionary *)params;
@end
