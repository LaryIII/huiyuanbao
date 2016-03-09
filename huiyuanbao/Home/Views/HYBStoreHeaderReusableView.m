//
//  HYBStoreHeaderReusableView.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/9.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreHeaderReusableView.h"
#import "masonry.h"

@implementation HYBStoreHeaderReusableView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int padding = 8;
        
        UIView *firstView = UIView.new;
        firstView.backgroundColor = [UIColor whiteColor];
        firstView.layer.masksToBounds = YES;
        [self addSubview:firstView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [firstView addGestureRecognizer:singleTap];
        
        UIView *superview = self;
        
        [firstView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superview.top).offset(0);
            make.left.equalTo(superview.left).offset(0);
            make.right.equalTo(superview.right).offset(0);
            make.bottom.equalTo(superview.bottom);
        }];
        
        UIView *headerView = UIView.new;
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.layer.masksToBounds = YES;
        [firstView addSubview:headerView];
        
        [headerView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.top).offset(0);
            make.left.equalTo(firstView.left).offset(0);
            make.right.equalTo(firstView.right).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        UIImageView *icon = UIImageView.new;
        UIImage *image = [UIImage imageNamed:@"location"];
        [icon setImage:image];
        [headerView addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.top).offset(10);
            make.left.equalTo(headerView.left).offset(padding);
        }];
        
        UILabel *title = UILabel.new;
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = RGB(51, 51, 51);
        title.font = [UIFont systemFontOfSize:14.0f];
        title.text = @"附近推荐";
        [headerView addSubview:title];
        [title makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.top).offset(11);
            make.left.equalTo(icon.right).offset(8);
        }];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = RGB(204, 204, 204);
        [firstView addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.bottom).offset(0);
            make.left.equalTo(headerView.left).offset(0);
            make.right.equalTo(headerView.right).offset(0);
            make.height.mas_equalTo(0.5f);
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
@end
