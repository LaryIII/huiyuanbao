//
//  HYBHuiTradeRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBHuiTradeRecord;
@protocol HYBHuiTradeRecordCellDelegate;

@interface HYBHuiTradeRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBHuiTradeRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBHuiTradeRecord *huiTradeRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBHuiTradeRecord *)huiTradeRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBHuiTradeRecordCellDelegate <NSObject>

-(void) gotoHuiTradeRecordDetail:(HYBHuiTradeRecordCell *)cell withHuiTradeRecord:(HYBHuiTradeRecord *)huiTradeRecord;

@end
