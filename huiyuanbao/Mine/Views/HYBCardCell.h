//
//  HYBCardCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBCard;
@protocol HYBCardCellDelegate;

@interface HYBCardCell : UICollectionViewCell
@property (nonatomic, strong) id<HYBCardCellDelegate> delegate;
@property (nonatomic, strong) HYBCard *card;
+ (CGSize)calculateCellSizeWithSummary:(HYBCard *)card containerWidth:(CGFloat)containerWidth;
@end

@protocol HYBCardCellDelegate <NSObject>

-(void) gotoCardDetail:(HYBCardCell *)cell withCard:(HYBCard *)card;

@end
