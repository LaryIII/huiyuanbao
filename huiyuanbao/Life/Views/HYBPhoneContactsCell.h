//
//  HYBPhoneContactsCell.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/11.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYBPhoneContact;
@protocol HYBPhoneContactsCellDelegate;

@interface HYBPhoneContactsCell : UICollectionViewCell
@property (nonatomic, weak) id<HYBPhoneContactsCellDelegate> delegate;
@property (nonatomic, strong) HYBPhoneContact *contact;
@property (nonatomic, strong) UIImageView *imageView;

@end

@protocol HYBPhoneContactsCellDelegate <NSObject>

@end
