//
//  HYBStoreProductCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBStoreProduct;
@protocol HYBStoreProductCellDelegate;

@interface HYBStoreProductCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBStoreProductCellDelegate> delegate;
@property (nonatomic, strong) HYBStoreProduct *product;
+ (CGSize)calculateCellSizeWithSummary:(HYBStoreProduct *)product containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBStoreProductCellDelegate <NSObject>

-(void) gotoProductDetail:(HYBStoreProductCell *)cell withProduct:(HYBStoreProduct *)product;
-(void) orderProduct:(HYBStoreProductCell *)cell withProduct:(HYBStoreProduct *)product;
@end
