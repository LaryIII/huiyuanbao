//
//  HYBCityCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBCityName;
@protocol HYBCityCellDelegate;

@interface HYBCityCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBCityCellDelegate> delegate;
@property (nonatomic, strong) HYBCityName *city;
+ (CGSize)calculateCellSizeWithSummary:(HYBCityName *)city containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBCityCellDelegate <NSObject>

-(void) gotoCity:(HYBCityCell *)cell withCity:(HYBCityName *)city;

@end
