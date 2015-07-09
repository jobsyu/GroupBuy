//
//  RecentViewController.m
//  GroupBuy
//
//  Created by qianfeng on 15/7/9.
//  Copyright (c) 2015年 ycp. All rights reserved.
//

#import "RecentViewController.h"

@implementation RecentViewController

static NSString *const reuseIdentifier =@"cell";

-(instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize =CGSizeMake(305, 305);
    return [self initWithCollectionViewLayout:layout];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

@end
