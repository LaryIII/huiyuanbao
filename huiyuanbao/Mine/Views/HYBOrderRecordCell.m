//
//  HYBOrderRecordCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBOrderRecordCell.h"
#import "masonry.h"
#import "CXImageLoader.h"
#import "HYBOrderRecord.h"

@interface HYBOrderRecordCell()

@end

@implementation HYBOrderRecordCell
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

- (void)setOrderRecord:(HYBOrderRecord *)orderRecord
{
    _orderRecord = orderRecord;
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
    if(_orderRecord.merchant_img && ![_orderRecord.merchant_img isEqualToString:@""]){
        [[CXImageLoader sharedImageLoader] loadImageForURL:[NSURL URLWithString:[IMG_PREFIX stringByAppendingString:_orderRecord.merchant_img]] image:^(UIImage *image, NSError *error) {
            storeImageView.image = image;
        }];
    }
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
    storeTitle.text = _orderRecord.merchant_name;//@"蓝湾咖啡";
    [bottomView addSubview:storeTitle];
    [storeTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(10);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    UILabel *order = UILabel.new;
    order.textAlignment = NSTextAlignmentLeft;
    order.textColor = RGB(102, 102, 102);
    order.font = [UIFont systemFontOfSize:11.0f];
    order.text = [NSString stringWithFormat: @"订单:%@ %@",_orderRecord.product_number, _orderRecord.product_name];
    [bottomView addSubview:order];
    [order makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(2);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    UILabel *zhekou = UILabel.new;
    zhekou.textAlignment = NSTextAlignmentLeft;
    zhekou.textColor = RGB(102, 102, 102);
    zhekou.font = [UIFont systemFontOfSize:11.0f];
    zhekou.text = [NSString stringWithFormat: @"折扣: %@折",_orderRecord.discount];
    [bottomView addSubview:zhekou];
    [zhekou makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(order.bottom).offset(2);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    
    UILabel *time = UILabel.new;
    time.textAlignment = NSTextAlignmentLeft;
    time.textColor = RGB(102, 102, 102);
    time.font = [UIFont systemFontOfSize:11.0f];
    time.text = [NSString stringWithFormat: @"失效时间: %@",_orderRecord.disable_time];
    [bottomView addSubview:time];
    [time makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhekou.bottom).offset(2);
        make.left.equalTo(storeImageView.right).offset(10);
    }];
    
    UIButton *btn = UIButton.new;
    btn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
    switch ([_orderRecord.status integerValue]) {
        case 1:
        case 2:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = RGB(59, 206, 157).CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"预约成功" forState:UIControlStateNormal];
            [btn setTitleColor:RGB(59, 206, 157) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            break;
        case 3:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = MAIN_COLOR.CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"已取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = MAIN_COLOR;
            break;
        case 4:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = MAIN_COLOR.CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"已失效" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = MAIN_COLOR;
            break;
        case 5:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = MAIN_COLOR.CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"预约中" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = MAIN_COLOR;
            break;
        case 6:
        case 8:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = MAIN_COLOR.CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"去支付" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = MAIN_COLOR;
            break;
        case 7:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = RGB(59, 206, 157).CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"商品售罄" forState:UIControlStateNormal];
            [btn setTitleColor:RGB(59, 206, 157) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            break;
        case 9:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = RGB(59, 206, 157).CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"退款中" forState:UIControlStateNormal];
            [btn setTitleColor:RGB(59, 206, 157) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            break;
        case 10:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = RGB(237, 112, 44).CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"退款成功" forState:UIControlStateNormal];
            [btn setTitleColor:RGB(237, 112, 44) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            break;
        case 11:
            btn.layer.cornerRadius = 5.0f;
            btn.layer.borderColor = RGB(237, 112, 44).CGColor;
            btn.layer.borderWidth = 0.5f;
            [btn setTitle:@"拒绝退款" forState:UIControlStateNormal];
            [btn setTitleColor:RGB(237, 112, 44) forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
    
    [btn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:btn];
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
