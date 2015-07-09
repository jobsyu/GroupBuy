//
//  City.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "City.h"
#import "MJExtension.h"
#import "Region.h"

@implementation City
-(NSDictionary *)objectClassInArray
{
    return @{@"regions" : [Region class]};
}
@end
