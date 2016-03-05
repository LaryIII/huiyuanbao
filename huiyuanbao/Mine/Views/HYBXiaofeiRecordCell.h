//
//  HYBXiaofeiRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBXiaofeiRecord;
@protocol HYBXiaofeiRecordCellDelegate;

@interface HYBXiaofeiRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBXiaofeiRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBXiaofeiRecord *xiaofeiRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBXiaofeiRecord *)xiaofeiRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBXiaofeiRecordCellDelegate <NSObject>

-(void) gotoXiaofeiRecordDetail:(HYBXiaofeiRecordCell *)cell withXiaofeiRecord:(HYBXiaofeiRecord *)xiaofeiRecord;

@end