//
//  HYBStoreBaseInfoCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBShopDetail;
@protocol HYBStoreBaseInfoCellDelegate;

@interface HYBStoreBaseInfoCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStoreBaseInfoCellDelegate> delegate;
@property (nonatomic, strong) HYBShopDetail *storeBaseInfo;
+ (CGSize)calculateCellSizeWithSummary:(HYBStoreBaseInfoCell *)store containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStoreBaseInfoCellDelegate <NSObject>

-(void) gotoMap:(HYBStoreBaseInfoCell *)cell withStoreBaseInfo:(HYBShopDetail *)storeBaseInfo;

@end
