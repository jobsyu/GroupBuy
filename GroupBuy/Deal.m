//
//  Deal.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "Deal.h"
#import "MJExtension.h"

@implementation Deal
-(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"desc" : @"description"};
}

-(BOOL)isEqual:(Deal *)object
{
    return [self.deal_id isEqual:object.deal_id];
}

MJCodingImplementation
@end
