//
//  HYBStoreProductCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreProductCell.h"
#import "masonry.h"

@interface HYBStoreProductCell()

@end

@implementation HYBStoreProductCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        int padding = 8;
        
        UIView *firstView = UIView.new;
        firstView.backgroundColor = [UIColor whiteColor];
        firstView.layer.masksToBounds = YES;
        [self.contentView addSubview:firstView];
    
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
        
        UILabel *productName = UILabel.new;
        productName.textAlignment = NSTextAlignmentLeft;
        productName.textColor = RGB(51, 51, 51);
        productName.font = [UIFont systemFontOfSize:14.0f];
        productName.text = @"牛肉水饺 [红包有优惠]";
        [bottomView addSubview:productName];
        [productName makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(padding+2);
            make.left.equalTo(bottomView.left).offset(15);
        }];
        
        UILabel *zhuying = UILabel.new;
        zhuying.textAlignment = NSTextAlignmentLeft;
        zhuying.textColor = RGB(204, 204, 204);
        zhuying.font = [UIFont systemFontOfSize:11.0f];
        zhuying.text = @"项目基本简介: 接口获取...";
        [bottomView addSubview:zhuying];
        [zhuying makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(productName.bottom).offset(padding);
            make.left.equalTo(bottomView.left).offset(15);
        }];
        
        UILabel *info1 = UILabel.new;
        info1.textAlignment = NSTextAlignmentLeft;
        info1.textColor = MAIN_COLOR;
        info1.font = [UIFont systemFontOfSize:11.0f];
        info1.text = @"￥12.00";
        [bottomView addSubview:info1];
        [info1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuying.bottom).offset(10);
            make.left.equalTo(bottomView.left).offset(15);
        }];
        
        UILabel *info2 = UILabel.new;
        info2.textAlignment = NSTextAlignmentLeft;
        info2.textColor = RGB(204, 204, 204);
        info2.font = [UIFont systemFontOfSize:11.0f];
        info2.text = @"/份";
        [bottomView addSubview:info2];
        [info2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuying.bottom).offset(10);
            make.left.equalTo(info1.right).offset(2);
        }];
        
        UILabel *info3 = UILabel.new;
        info3.textAlignment = NSTextAlignmentLeft;
        info3.textColor = RGB(204, 204, 204);
        info3.font = [UIFont systemFontOfSize:11.0f];
        info3.text = @"送积分";
        [bottomView addSubview:info3];
        [info3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuying.bottom).offset(10);
            make.left.equalTo(info2.right).offset(15);
        }];
        
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        btn.layer.cornerRadius = 5.0f;
        [btn setTitle:@"立即预订" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
        btn.backgroundColor = MAIN_COLOR;
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(20);
            make.right.equalTo(bottomView.right).offset(-15);
            make.width.mas_equalTo(75);
        }];

        
        UIView *lineView2 = UIView.new;
        lineView2.backgroundColor = RGB(204, 204, 204);
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

- (void)setStore:(HYBStoreProduct *)product
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBStoreProduct *)product containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 148.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoProductDetail:withProduct:)]) {
        [self.delegate gotoProductDetail:self withProduct:_product];
    }
}

-(void)order{
    
}
@end
