//
//  HYBHuiTixianRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBHuiTixianRecord;
@protocol HYBHuiTixianRecordCellDelegate;

@interface HYBHuiTixianRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBHuiTixianRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBHuiTixianRecord *huiTixianRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBHuiTixianRecord *)tixianRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBHuiTixianRecordCellDelegate <NSObject>

-(void) gotoHuiTixianRecordDetail:(HYBHuiTixianRecordCell *)cell withHuiTixianRecord:(HYBHuiTixianRecord *)tixianRecord;

@end
