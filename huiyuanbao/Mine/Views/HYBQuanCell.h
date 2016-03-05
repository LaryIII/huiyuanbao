//
//  HYBQuanCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBQuan;
@protocol HYBQuanCellDelegate;

@interface HYBQuanCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBQuanCellDelegate> delegate;
@property (nonatomic, strong) HYBQuan *quan;
+ (CGSize)calculateCellSizeWithSummary:(HYBQuan *)card containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBQuanCellDelegate <NSObject>

-(void) gotoQuanDetail:(HYBQuanCell *)cell withQuan:(HYBQuan *)msg;

@end
