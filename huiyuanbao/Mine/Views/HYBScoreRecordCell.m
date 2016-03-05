//
//  HYBScoreRecordCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBScoreRecordCell.h"
#import "masonry.h"

@interface HYBScoreRecordCell()

@end

@implementation HYBScoreRecordCell
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
        UIImage *storeImg = [UIImage imageNamed:@"charge_default"];
        [storeImageView setImage:storeImg];
        [bottomView addSubview:storeImageView];
        [storeImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(16);
            make.left.equalTo(bottomView.left).offset(15);
            make.width.mas_equalTo(37);
            make.height.mas_equalTo(37);
        }];
        
        
        UILabel *storeTitle = UILabel.new;
        storeTitle.textAlignment = NSTextAlignmentLeft;
        storeTitle.textColor = RGB(51, 51, 51);
        storeTitle.font = [UIFont systemFontOfSize:14.0f];
        storeTitle.text = @"消费获取";
        [bottomView addSubview:storeTitle];
        [storeTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(13);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *time = UILabel.new;
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = RGB(102, 102, 102);
        time.font = [UIFont systemFontOfSize:11.0f];
        time.text = @"02-30 18:00";
        [bottomView addSubview:time];
        [time makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(16);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *status = UILabel.new;
        status.textAlignment = NSTextAlignmentLeft;
        status.textColor = MAIN_COLOR;
        status.font = [UIFont systemFontOfSize:17.0f];
        status.text = @"+8";
        [bottomView addSubview:status];
        [status makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(30);
            make.right.equalTo(firstView.right).offset(-15);
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

- (void)setScoreRecord:(HYBScoreRecord *)scoreRecord
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBScoreRecord *)scoreRecord containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 70.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoScoreRecordDetail:withScoreRecord:)]) {
        [self.delegate gotoScoreRecordDetail:self withScoreRecord:_scoreRecord];
    }
}
@end