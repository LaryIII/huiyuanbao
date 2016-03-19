//
//  HYBTradeRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//
#import <UIKit/UIKit.h>
@class HYBTradeRecord;
@protocol HYBTradeRecordCellDelegate;

@interface HYBTradeRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBTradeRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBTradeRecord *tradeRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBTradeRecord *)tradeRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBTradeRecordCellDelegate <NSObject>

-(void) gotoTradeRecordDetail:(HYBTradeRecordCell *)cell withTradeRecord:(HYBTradeRecord *)tradeRecord;

@end
