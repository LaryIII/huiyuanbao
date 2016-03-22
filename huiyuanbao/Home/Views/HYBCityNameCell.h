//
//  HYBCityNameCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
@class HYBCityName;
@protocol HYBCityNameCellDelegate;

@interface HYBCityNameCell : UICollectionViewCell
@property (nonatomic, weak) id<HYBCityNameCellDelegate> delegate;
@property (nonatomic, strong) HYBCityName *city;
@property (nonatomic, strong) UIImageView *imageView;

@end

@protocol HYBCityNameCellDelegate <NSObject>
-(void) setCity:(HYBCityNameCell *)cell withCity:(HYBCityName *)city;
@end
