//
//  HYBOrderRecordCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBOrderRecordCell.h"
#import "masonry.h"

@interface HYBOrderRecordCell()

@end

@implementation HYBOrderRecordCell
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
        storeTitle.font = [UIFont systemFontOfSize:11.0f];
        storeTitle.text = @"蓝湾咖啡";
        [bottomView addSubview:storeTitle];
        [storeTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(10);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *order = UILabel.new;
        order.textAlignment = NSTextAlignmentLeft;
        order.textColor = RGB(102, 102, 102);
        order.font = [UIFont systemFontOfSize:11.0f];
        order.text = @"订单:1【一品牛腩煲】";
        [bottomView addSubview:order];
        [order makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(2);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *zhekou = UILabel.new;
        zhekou.textAlignment = NSTextAlignmentLeft;
        zhekou.textColor = RGB(102, 102, 102);
        zhekou.font = [UIFont systemFontOfSize:11.0f];
        zhekou.text = @"折扣: 0.5折";
        [bottomView addSubview:zhekou];
        [zhekou makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(order.bottom).offset(2);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        
        UILabel *time = UILabel.new;
        time.textAlignment = NSTextAlignmentLeft;
        time.textColor = RGB(102, 102, 102);
        time.font = [UIFont systemFontOfSize:11.0f];
        time.text = @"失效时间: 2016-02-16 18:00";
        [bottomView addSubview:time];
        [time makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhekou.bottom).offset(2);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        btn.layer.cornerRadius = 5.0f;
        [btn setTitle:@"充值" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
        btn.backgroundColor = MAIN_COLOR;
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(15);
            make.right.equalTo(bottomView.right).offset(-15);
            make.width.mas_equalTo(60);
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

- (void)setOrderRecord:(HYBOrderRecord *)orderRecord
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBOrderRecord *)orderRecord containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 80.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoOrderRecordDetail:withOrderRecord:)]) {
        [self.delegate gotoOrderRecordDetail:self withOrderRecord:_orderRecord];
    }
}
@end
