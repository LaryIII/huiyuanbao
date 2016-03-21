//
//  HYBHuiChargeRecordCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHuiChargeRecordCell.h"
#import "HYBHuiChargeRecord.h"
#import "masonry.h"
#import "CXImageLoader.h"

@implementation HYBHuiChargeRecordCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setHuiTradeRecord:(HYBHuiChargeRecord *)huiChargeRecord
{
    _huiChargeRecord = huiChargeRecord;
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
    if(_huiChargeRecord.logo && ![_huiChargeRecord.logo isEqualToString:@""]){
        [[CXImageLoader sharedImageLoader] loadImageForURL:[NSURL URLWithString:[IMG_PREFIX stringByAppendingString:_huiChargeRecord.logo]] image:^(UIImage *image, NSError *error) {
            storeImageView.image = image;
        }];
    }
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
    storeTitle.text = _huiChargeRecord.muname;//@"消费";
    [bottomView addSubview:storeTitle];
    [storeTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(13);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    UILabel *time = UILabel.new;
    time.textAlignment = NSTextAlignmentLeft;
    time.textColor = RGB(102, 102, 102);
    time.font = [UIFont systemFontOfSize:11.0f];
    time.text = _huiChargeRecord.createtime;//@"02-30 18:00";
    [bottomView addSubview:time];
    [time makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(16);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    UILabel *status = UILabel.new;
    status.textAlignment = NSTextAlignmentLeft;
    status.textColor = RGB(51, 51, 51);
    status.font = [UIFont systemFontOfSize:14.0f];
    NSString *statusText = @"";
    switch ([_huiChargeRecord.status integerValue]) {
        case 0:
            statusText = @"未完成";
            break;
        case 1:
            statusText = @"已完成";
            break;
        case 2:
            statusText = @"充值异常";
            break;
        case 3:
            statusText = @"充值失败";
            break;
        default:
            break;
    }
    status.text = statusText;//@"成功";
    [bottomView addSubview:status];
    [status makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(13);
        make.right.equalTo(firstView.right).offset(-15);
    }];
    
    UILabel *youvalue = UILabel.new;
    youvalue.textAlignment = NSTextAlignmentLeft;
    youvalue.textColor = MAIN_COLOR;
    youvalue.font = [UIFont systemFontOfSize:11.0f];
    youvalue.text = [NSString stringWithFormat:@"￥%@", _huiChargeRecord.cashback];//@"￥0.00";
    [bottomView addSubview:youvalue];
    [youvalue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(status.bottom).offset(16);
        make.right.equalTo(firstView.right).offset(-15);
    }];
    
    UILabel *youname = UILabel.new;
    youname.textAlignment = NSTextAlignmentLeft;
    youname.textColor = RGB(102, 102, 102);
    youname.font = [UIFont systemFontOfSize:11.0f];
    youname.text = @"返红包";
    [bottomView addSubview:youname];
    [youname makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(status.bottom).offset(16);
        make.right.equalTo(youvalue.left).offset(-2);
    }];
    
    UILabel *alivalue = UILabel.new;
    alivalue.textAlignment = NSTextAlignmentLeft;
    alivalue.textColor = MAIN_COLOR;
    alivalue.font = [UIFont systemFontOfSize:11.0f];
    alivalue.text = [NSString stringWithFormat:@"￥%@", _huiChargeRecord.balance];//@"￥3.00";
    [bottomView addSubview:alivalue];
    [alivalue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(status.bottom).offset(16);
        make.right.equalTo(youname.left).offset(-2);
    }];
    
    UILabel *aliname = UILabel.new;
    aliname.textAlignment = NSTextAlignmentLeft;
    aliname.textColor = RGB(102, 102, 102);
    aliname.font = [UIFont systemFontOfSize:11.0f];
    aliname.text = @"充值金额";
    [bottomView addSubview:aliname];
    [aliname makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(status.bottom).offset(16);
        make.right.equalTo(alivalue.left).offset(-2);
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
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBHuiChargeRecord *)huiChargeRecord containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 70.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoHuiChargeRecordDetail:withHuiChargeRecord:)]) {
        [self.delegate gotoHuiChargeRecordDetail:self withHuiChargeRecord:_huiChargeRecord];
    }
}
@end