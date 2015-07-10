//
//  DealTool.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Deal;

@interface DealTool : NSObject

//收藏
/**
 * 返回第page页的收藏团购数据：page从1开始
 */
+(NSArray *)collectDeals:(int)page;
+(int)collectDealsCount;
/**
 *  收藏一个团购
 */
+(void)addCollectDeal:(Deal *)deal;
/**
 *  取消收藏一个团购
 */
+(void)removeCollectDeal:(Deal *)deal;
/**
 *  团购是否收藏
 */
+(BOOL)isCollected:(Deal *)deal;


//最近
/**
 * 返回第page页的最近团购数据：page从1开始
 */
+(NSArray *)recentDeals:(int)page;
+(int)recentDealsCount;
/**
 *  添加最近一个团购
 */
+(void)addRecentDeal:(Deal *)deal;
/**
 *  删除最近一个团购
 */
+(void)removeRecentDeal:(Deal *)deal;
/**
 *  团购是否是最近的
 */
+(BOOL)isRecented:(Deal *)deal;
@end
