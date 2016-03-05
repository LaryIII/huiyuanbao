//
//  HYBMsgCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBMsg;
@protocol HYBMsgCellDelegate;

@interface HYBMsgCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBMsgCellDelegate> delegate;
@property (nonatomic, strong) HYBMsg *msg;
+ (CGSize)calculateCellSizeWithSummary:(HYBMsg *)card containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBMsgCellDelegate <NSObject>

-(void) gotoMsgDetail:(HYBMsgCell *)cell withMsg:(HYBMsg *)msg;

@end

