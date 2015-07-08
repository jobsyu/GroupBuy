//
//  CityGroup.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityGroup : NSObject
/** 这组的标题 **/
@property (nonatomic,copy) NSString *title;
/** 这组的所有城市 **/
@property (nonatomic,strong) NSArray *cities;
@end
