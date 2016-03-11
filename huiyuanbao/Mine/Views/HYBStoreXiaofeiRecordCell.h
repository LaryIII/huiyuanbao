//
//  HYBStoreXiaofeiRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBStoreXiaofeiRecord;
@protocol HYBStoreXiaofeiRecordCellDelegate;

@interface HYBStoreXiaofeiRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStoreXiaofeiRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBStoreXiaofeiRecord *storeXiaofeiRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBStoreXiaofeiRecord *)storeXiaofeiRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStoreXiaofeiRecordCellDelegate <NSObject>

-(void) gotoStoreXiaofeiRecordDetail:(HYBStoreXiaofeiRecordCell *)cell withStoreXiaofeiRecord:(HYBStoreXiaofeiRecord *)storeXiaofeiRecord;

@end
