//
//  HYBStoreCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBStore;
@protocol HYBStoreCellDelegate;

@interface HYBStoreCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStoreCellDelegate> delegate;
@property (nonatomic, strong) HYBStore *store;
+ (CGSize)calculateCellSizeWithSummary:(HYBStore *)store containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStoreCellDelegate <NSObject>

-(void) gotoStoreDetail:(HYBStoreCell *)cell withStore:(HYBStore *)store;

@end
