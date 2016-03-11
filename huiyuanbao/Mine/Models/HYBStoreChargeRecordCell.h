//
//  HYBStoreChargeRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBStoreChargeRecord;
@protocol HYBStoreChargeRecordCellDelegate;

@interface HYBStoreChargeRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStoreChargeRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBStoreChargeRecord *storeChargeRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBStoreChargeRecord *)storeChargeRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStoreChargeRecordCellDelegate <NSObject>

-(void) gotoStoreChargeRecordDetail:(HYBStoreChargeRecordCell *)cell withStoreChargeRecord:(HYBStoreChargeRecord *)storeChargeRecord;

@end
