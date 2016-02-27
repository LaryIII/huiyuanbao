//
//  HYBBannersCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CXCycleScrollView.h"

@class HYBAdvertisement;

@protocol HYBBannersCellDelegate;

@interface HYBBannersCell : UICollectionViewCell

@property (nonatomic, weak) id <HYBBannersCellDelegate> delegate;

@property (nonatomic, strong) NSArray *banners;

@property (nonatomic, strong) CXCycleScrollView *cycleScrollView;


@end

@protocol HYBBannersCellDelegate <NSObject>

- (void)bannersCell:(HYBBannersCell *)cell advertisement:(HYBAdvertisement *)advertisement;

@end