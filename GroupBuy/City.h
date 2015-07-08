//
//  City.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject
/** 城市名字 */
@property (nonatomic,copy) NSString *name;
/** 城市名字的拼音 */
@property (nonatomic,copy) NSString *pinYin;
/** 城市名字的拼音声母 */
@property (nonatomic,copy) NSString *pinYinHead;
/** 区域（存放的都是Region模型）*/
@property (nonatomic,strong) NSArray *regions;
@end
