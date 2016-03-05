//
//  HYBScoreRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBScoreRecord;
@protocol HYBScoreRecordCellDelegate;

@interface HYBScoreRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBScoreRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBScoreRecord *scoreRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBScoreRecord *)scoreRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBScoreRecordCellDelegate <NSObject>

-(void) gotoScoreRecordDetail:(HYBScoreRecordCell *)cell withScoreRecord:(HYBScoreRecord *)scoreRecord;

@end