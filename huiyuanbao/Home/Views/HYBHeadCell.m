//
//  HYBHeadCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHeadCell.h"
#import "masonry.h"

@implementation HYBHeadCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *t_title1 = UILabel.new;
        t_title1.textAlignment = NSTextAlignmentCenter;
        t_title1.textColor = RGB(136, 136, 136);
        t_title1.font = [UIFont systemFontOfSize:14.0f];
        t_title1.text = @"本月";
        [self.contentView addSubview:t_title1];
        [t_title1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.top).offset(7);
            make.left.equalTo(self.contentView.left).offset(15);
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end

