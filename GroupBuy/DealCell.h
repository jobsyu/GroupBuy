//
//  DealCell.h
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deal,DealCell;

@protocol DealCellDelegate <NSObject>

@optional
-(void)dealCellCheckingStateDidChange:(DealCell *)cell;
@end

@interface DealCell : UICollectionViewCell
@property (nonatomic,strong) Deal *deal;
@property (nonatomic,weak) id<DealCellDelegate> delegate;

@end
