//
//  HYBQuanCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQuanCell.h"
#import "masonry.h"

@interface HYBQuanCell()
@end

@implementation HYBQuanCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = CGRectGetWidth(self.contentView.bounds);
        float x = 158.0f/580.0f;
        float y = 56.0f/580.0f;
        
        UIView *firstView = UIView.new;
        firstView.backgroundColor = [UIColor clearColor];
        firstView.layer.masksToBounds = YES;
        [self.contentView addSubview:firstView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [firstView addGestureRecognizer:singleTap];
        
        UIView *superview = self.contentView;
        
        [firstView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superview.top).offset(0);
            make.left.equalTo(superview.left).offset(0);
            make.right.equalTo(superview.right).offset(0);
            make.bottom.mas_equalTo((width-30.0f)*(x+y)+15.0f);
        }];
        
        UIView *topView = UIView.new;
        [firstView addSubview:topView];
        [topView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.top).offset(15);
            make.left.equalTo(firstView.left).offset(15);
            make.right.equalTo(firstView.right).offset(-15);
            make.height.mas_equalTo((width-30.0f)*x);
        }];
        
        UIButton *topBtn = UIButton.new;
        [topBtn setBackgroundImage:[UIImage imageNamed:@"quan_normal_top"] forState:UIControlStateNormal];
        [topBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:topBtn];
        [topBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.top);
            make.left.equalTo(topView.left);
            make.right.equalTo(topView.right);
            make.height.mas_equalTo((width-30.0f)*x);
        }];
        
        UILabel *num = UILabel.new;
        num.textAlignment = NSTextAlignmentLeft;
        num.textColor = RGB(255, 255, 255);
        num.font = [UIFont systemFontOfSize:18.0f];
        num.text = @"10.000";
        [topBtn addSubview:num];
        [num makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBtn.top).offset(30);
            make.left.equalTo(topBtn.left).offset(20);
            make.width.mas_equalTo(75);
        }];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = [UIColor whiteColor];
        [topBtn addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBtn.top).offset(15);
            make.left.equalTo(num.right);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(0.5f);
        }];
        
        UILabel *title = UILabel.new;
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = RGB(255, 255, 255);
        title.font = [UIFont systemFontOfSize:15.0f];
        title.text = @"大娘水饺";
        [topBtn addSubview:title];
        [title makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBtn.top).offset(20);
            make.left.equalTo(lineView.right).offset(6);
        }];
        
        UILabel *desc = UILabel.new;
        desc.textAlignment = NSTextAlignmentLeft;
        desc.textColor = RGB(255, 255, 255);
        desc.font = [UIFont systemFontOfSize:11.0f];
        desc.text = @"及时雨";
        [topBtn addSubview:desc];
        [desc makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.bottom).offset(4);
            make.left.equalTo(lineView.right).offset(6);
        }];
        
        UILabel *status = UILabel.new;
        status.textAlignment = NSTextAlignmentLeft;
        status.textColor = RGB(255, 255, 255);
        status.font = [UIFont systemFontOfSize:12.0f];
        status.text = @"可用";
        [topBtn addSubview:status];
        [status makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topBtn.top).offset(33);
            make.right.equalTo(topBtn.right).offset(-33);
        }];
        
        UIView *bottomView = UIView.new;
        [firstView addSubview:bottomView];
        [bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topView.bottom);
            make.left.equalTo(firstView.left).offset(15);
            make.right.equalTo(firstView.right).offset(-15);
            make.height.mas_equalTo((width-30.0f)*y);
        }];
        
        UIButton *bottomBtn = UIButton.new;
        [bottomBtn setBackgroundImage:[UIImage imageNamed:@"quan_normal_bottom"] forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:bottomBtn];
        [bottomBtn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top);
            make.left.equalTo(bottomView.left);
            make.right.equalTo(bottomView.right);
            make.height.mas_equalTo((width-30.0f)*y);
        }];
        
        UILabel *time = UILabel.new;
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = RGB(255, 255, 255);
        time.font = [UIFont systemFontOfSize:11.0f];
        time.text = @"有效期: 2016-02-01 09:00 至 2016-02-30 18:00";
        [bottomBtn addSubview:time];
        [time makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomBtn.top).offset(8);
            make.left.equalTo(bottomBtn.left).offset(15);
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setQuan:(HYBQuan *)quan
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBQuan *)quan containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 50);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoQuanDetail:withQuan:)]) {
        [self.delegate gotoQuanDetail:self withQuan:_quan];
    }
}
@end
