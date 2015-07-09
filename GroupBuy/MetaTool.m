//
//  MetaTool.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/8.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "MetaTool.h"
#import "MJExtension.h"
#import "City.h"
#import "Categorys.h"
#import "Sort.h"

@implementation MetaTool

static NSArray *_cities;

+(NSArray *)cities
{
    if (_cities == nil) {
        _cities = [City objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

static NSArray *_categories;

+(NSArray *)categories
{
    if (_categories == nil) {
        _categories = [Categorys objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}
static NSArray *_sorts;

+(NSArray *)sorts
{
    if (_sorts == nil) {
        _sorts = [Sort objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}
@end
