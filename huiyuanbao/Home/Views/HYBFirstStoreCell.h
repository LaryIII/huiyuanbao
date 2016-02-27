//
//  HYBFirstStoreCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBFirstStore;
@protocol HYBFirstStoreCellDelegate;

@interface HYBFirstStoreCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBFirstStoreCellDelegate> delegate;
@property (nonatomic, strong) HYBFirstStore *store;
+ (CGSize)calculateCellSizeWithSummary:(HYBFirstStore *)store containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBFirstStoreCellDelegate <NSObject>

-(void) gotoFirstStoreDetail:(HYBFirstStoreCell *)cell withStore:(HYBFirstStore *)store;

@end