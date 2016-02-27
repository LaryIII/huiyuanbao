//
//  HYBStore2Cell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBStore2;
@protocol HYBStore2CellDelegate;

@interface HYBStore2Cell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStore2CellDelegate> delegate;
@property (nonatomic, strong) HYBStore2 *store;
+ (CGSize)calculateCellSizeWithSummary:(HYBStore2 *)store containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStore2CellDelegate <NSObject>

-(void) gotoStoreDetail:(HYBStore2Cell *)cell withStore:(HYBStore2 *)store;

@end