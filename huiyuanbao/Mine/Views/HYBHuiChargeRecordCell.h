//
//  HYBHuiChargeRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBHuiChargeRecord;
@protocol HYBHuiChargeRecordCellDelegate;

@interface HYBHuiChargeRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBHuiChargeRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBHuiChargeRecord *huiChargeRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBHuiChargeRecord *)huiChargeRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBHuiChargeRecordCellDelegate <NSObject>

-(void) gotoHuiChargeRecordDetail:(HYBHuiChargeRecordCell *)cell withHuiChargeRecord:(HYBHuiChargeRecord *)huiChargeRecord;

@end
