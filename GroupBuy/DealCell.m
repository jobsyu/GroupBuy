//
//  DealCell.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "DealCell.h"
#import "Deal.h"
#import "UIImageView+WebCache.h"

@interface DealCell()
@property (weak,nonatomic) IBOutlet UIImageView *imageView;
@property (weak,nonatomic) IBOutlet UILabel *titleLabel;
@property (weak,nonatomic) IBOutlet UILabel *descLabel;
@property (weak,nonatomic) IBOutlet UILabel *currentPriceLabel;
@property (weak,nonatomic) IBOutlet UILabel *listPriceLabel;
@property (weak,nonatomic) IBOutlet UILabel *purchaseCountLabel;
/**
 *  属性名不能以new开头
 */
@property (weak,nonatomic) IBOutlet UIImageView *dealNewView;
@end

@implementation DealCell

-(void)awakeFromNib
{

}

-(void)setDeal:(Deal *)deal
{
    _deal =deal;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:deal.s_image_url] placeholderImage:[UIImage imageNamed:@"placeholder_deal"]];
    self.titleLabel.text = deal.title;
    self.descLabel.text = deal.desc;
    
    //现价
    self.currentPriceLabel.text =  [NSString stringWithFormat:@"¥ %@",deal.current_price];
    NSUInteger dotLoc = [self.currentPriceLabel.text rangeOfString:@"."].location;
    if (dotLoc != NSNotFound) {
        //超过2位小数
        if (self.currentPriceLabel.text.length - dotLoc > 3) {
            self.currentPriceLabel.text = [self.currentPriceLabel.text substringToIndex:dotLoc + 3];
        }
    }
    //原价
    self.listPriceLabel.text = [NSString stringWithFormat:@"¥ %@",deal.list_price];
    //购买数
    self.purchaseCountLabel.text =[NSString stringWithFormat:@"已售 %d",deal.purchase_count];
    
}

-(void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"bg_dealcell"] drawInRect:rect];
}

@end
