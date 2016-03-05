//
//  HYBMsgCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBMsgCell.h"
#import "masonry.h"

@interface HYBMsgCell()

@end

@implementation HYBMsgCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int padding = 8;
        
        UIView *firstView = UIView.new;
        firstView.backgroundColor = [UIColor whiteColor];
        firstView.layer.masksToBounds = YES;
        [self.contentView addSubview:firstView];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        [firstView addGestureRecognizer:singleTap];
        
        UIView *superview = self.contentView;
        
        [firstView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(superview.top).offset(0);
            make.left.equalTo(superview.left).offset(0);
            make.right.equalTo(superview.right).offset(0);
            make.bottom.equalTo(superview.bottom);
        }];
        
        UIView *bottomView = UIView.new;
        [firstView addSubview:bottomView];
        [bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.top).offset(0);
            make.left.equalTo(firstView.left).offset(0);
            make.right.equalTo(firstView.right).offset(0);
            make.bottom.equalTo(firstView.bottom).offset(0);
        }];
        
        UIImageView *storeImageView = UIImageView.new;
        UIImage *storeImg = [UIImage imageNamed:@"shang_default"];
        [storeImageView setImage:storeImg];
        [bottomView addSubview:storeImageView];
        [storeImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(10);
            make.left.equalTo(bottomView.left).offset(15);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(60);
        }];
        
        
        UILabel *storeTitle = UILabel.new;
        storeTitle.textAlignment = NSTextAlignmentLeft;
        storeTitle.textColor = RGB(51, 51, 51);
        storeTitle.font = [UIFont systemFontOfSize:13.0f];
        storeTitle.text = @"蓝湾咖啡";
        [bottomView addSubview:storeTitle];
        [storeTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(12);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *time = UILabel.new;
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = RGB(102, 102, 102);
        time.font = [UIFont systemFontOfSize:11.0f];
        time.text = @"过期时间至: 2016-02-30 18:00";
        [bottomView addSubview:time];
        [time makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(6);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *platform = UILabel.new;
        platform.textAlignment = NSTextAlignmentLeft;
        platform.textColor = RGB(51, 51, 51);
        platform.font = [UIFont systemFontOfSize:11.0f];
        platform.text = @"惠员包平台 01-26 15:00";
        [bottomView addSubview:platform];
        [platform makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time.bottom).offset(6);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UIView *lineView2 = UIView.new;
        lineView2.backgroundColor = RGB(240, 240, 240);
        [bottomView addSubview:lineView2];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.bottom).offset(-0.5);
            make.left.equalTo(bottomView.left).offset(0);
            make.right.equalTo(bottomView.right).offset(0);
            make.height.mas_equalTo(0.5f);
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setmSG:(HYBMsg *)msg
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBMsg *)MSG containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 80.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoMsgDetail:withMsg:)]) {
        [self.delegate gotoMsgDetail:self withMsg:_msg];
    }
}
@end
