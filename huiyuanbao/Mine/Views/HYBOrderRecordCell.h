//
//  HYBOrderRecordCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBOrderRecord;
@protocol HYBOrderRecordCellDelegate;

@interface HYBOrderRecordCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBOrderRecordCellDelegate> delegate;
@property (nonatomic, strong) HYBOrderRecord *orderRecord;
+ (CGSize)calculateCellSizeWithSummary:(HYBOrderRecord *)orderRecord containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBOrderRecordCellDelegate <NSObject>

-(void) gotoOrderRecordDetail:(HYBOrderRecordCell *)cell withOrderRecord:(HYBOrderRecord *)orderRecord;

@end
