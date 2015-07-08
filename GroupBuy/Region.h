//
//  Region.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Region : NSObject
/** 区域名字 */
@property (nonatomic,copy) NSString *name;
/** 子区域 */
@property (nonatomic,strong) NSArray *subregions;
@end
