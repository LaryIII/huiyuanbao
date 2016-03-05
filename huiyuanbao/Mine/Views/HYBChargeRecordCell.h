//
//  HYBChargeRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBChargeRecord;
@protocol HYBChargeRecordCellDelegate;

@interface HYBChargeRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBChargeRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBChargeRecord *chargeRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBChargeRecord *)chargeRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBChargeRecordCellDelegate <NSObject>

-(void) gotoChargeRecordDetail:(HYBChargeRecordCell *)cell withChargeRecord:(HYBChargeRecord *)chargeRecord;

@end

