//
//  HYBStoreBaseInfoCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreBaseInfoCell.h"
#import "masonry.h"
#import "CXImageLoader.h"
#import "HYBShopDetail.h"

@implementation HYBStoreBaseInfoCell
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

- (void)setStoreBaseInfo:(HYBShopDetail *)storeBaseInfo
{
    _storeBaseInfo = storeBaseInfo;
    int padding = 8;
    
    UIView *firstView = UIView.new;
    firstView.backgroundColor = RGB(240, 240, 240);
    firstView.layer.masksToBounds = YES;
    [self.contentView addSubview:firstView];
    
    UIView *superview = self.contentView;
    
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(0);
        make.left.equalTo(superview.left).offset(0);
        make.right.equalTo(superview.right).offset(0);
        make.bottom.equalTo(superview.bottom).offset(-10);
    }];
    
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = [UIColor whiteColor];
    [firstView addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.top).offset(0);
        make.left.equalTo(firstView.left).offset(0);
        make.right.equalTo(firstView.right).offset(0);
        make.bottom.equalTo(firstView.bottom).offset(0);
    }];
    
    UIImageView *storeImageView = UIImageView.new;
    UIImage *storeImg = [UIImage imageNamed:@"store_default"];
    [storeImageView setImage:storeImg];
    if(_storeBaseInfo.merchant_img && ![_storeBaseInfo.merchant_img isEqualToString:@""]){
        [[CXImageLoader sharedImageLoader] loadImageForURL:[NSURL URLWithString:[IMG_PREFIX stringByAppendingString:_storeBaseInfo.merchant_img]] image:^(UIImage *image, NSError *error) {
            storeImageView.image = image;
        }];
    }
    [bottomView addSubview:storeImageView];
    [storeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding);
        make.left.equalTo(bottomView.left).offset(padding);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(83);
    }];
    
    
    UILabel *storeTitle = UILabel.new;
    storeTitle.textAlignment = NSTextAlignmentLeft;
    storeTitle.textColor = RGB(51, 51, 51);
    storeTitle.font = [UIFont systemFontOfSize:14.0f];
    storeTitle.text = _storeBaseInfo.merchant_name;//@"猫空咖啡(时代广场店)";
    [bottomView addSubview:storeTitle];
    [storeTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding+2);
        make.left.equalTo(storeImageView.right).offset(15);
    }];
    
    
    UIImageView *RMBicon = UIImageView.new;
    UIImage *rmb = [UIImage imageNamed:@"store"];
    [RMBicon setImage:rmb];
    [bottomView addSubview:RMBicon];
    [RMBicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding+2);
        make.left.equalTo(storeTitle.right).offset(4);
    }];
    
    UIImageView *vipicon = UIImageView.new;
    UIImage *vip = [UIImage imageNamed:@"vip"];
    [vipicon setImage:vip];
    [bottomView addSubview:vipicon];
    [vipicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding);
        make.left.equalTo(RMBicon.right).offset(4);
    }];
    
    UIView *ratingView = UIView.new;
    [bottomView addSubview:ratingView];
    [ratingView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(22);
        make.left.equalTo(storeImageView.right).offset(15);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(14);
    }];
    for (int i=0; i<5; i++) {
        UIImageView *star = UIImageView.new;
        if(i<4){
            [star setImage:[UIImage imageNamed:@"star"]];
            [ratingView addSubview:star];
        }else{
            [star setImage:[UIImage imageNamed:@"star_gray"]];
            [ratingView addSubview:star];
        }
        [star makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.top).offset(0);
            make.left.mas_equalTo(i*14+3*i);
        }];
    }
    
    UILabel *score = UILabel.new;
    score.textAlignment = NSTextAlignmentLeft;
    score.textColor = RGB(250, 155, 59);
    score.font = [UIFont systemFontOfSize:12.0f];
    score.text = @"4.0分";
    [bottomView addSubview:score];
    [score makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(22);
        make.left.equalTo(ratingView.right).offset(5);
    }];
    
    if([_storeBaseInfo.isvip isEqualToString:@"N"]){
        UIButton *addBtn = UIButton.new;
        addBtn.titleLabel.font = [UIFont systemFontOfSize:11.0f];
        [addBtn setTitle:@"【加入会员, 享受更多优惠】" forState:UIControlStateNormal];
        [addBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [addBtn addTarget:self action:@selector(addhuiyuan) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:addBtn];
        [addBtn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(storeImageView.right).offset(13);
            make.bottom.equalTo(storeImageView.bottom).offset(5);
        }];
    }else if([_storeBaseInfo.isvip isEqualToString:@"Y"]){
        UILabel *info1 = UILabel.new;
        info1.textAlignment = NSTextAlignmentLeft;
        info1.textColor = RGB(204, 204, 204);
        info1.font = [UIFont systemFontOfSize:11.0f];
        info1.text = @"余额: ";
        [bottomView addSubview:info1];
        [info1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(20);
            make.left.equalTo(storeImageView.right).offset(15);
        }];
        
        UILabel *info2 = UILabel.new;
        info2.textAlignment = NSTextAlignmentLeft;
        info2.textColor = MAIN_COLOR;
        info2.font = [UIFont systemFontOfSize:11.0f];
        info2.text = [NSString stringWithFormat:@"￥%@",_storeBaseInfo.merchant_redpacket];
        [bottomView addSubview:info2];
        [info2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(20);
            make.left.equalTo(info1.right).offset(0);
        }];
        
        UILabel *info11 = UILabel.new;
        info11.textAlignment = NSTextAlignmentLeft;
        info11.textColor = RGB(204, 204, 204);
        info11.font = [UIFont systemFontOfSize:11.0f];
        info11.text = @"昨日返利: ";
        [bottomView addSubview:info11];
        [info11 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(20);
            make.left.equalTo(info2.right).offset(25);
        }];
        
        UILabel *info22 = UILabel.new;
        info22.textAlignment = NSTextAlignmentLeft;
        info22.textColor = MAIN_COLOR;
        info22.font = [UIFont systemFontOfSize:11.0f];
        info22.text = [NSString stringWithFormat:@"￥%@",_storeBaseInfo.interest];
        [bottomView addSubview:info22];
        [info22 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(20);
            make.left.equalTo(info11.right).offset(0);
        }];
    }
    
    
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = RGB(240, 240, 240);
    [bottomView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeImageView.bottom).offset(8);
        make.left.equalTo(bottomView.left).offset(0);
        make.right.equalTo(bottomView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *zhuyingview = UIView.new;
    zhuyingview.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:zhuyingview];
    [zhuyingview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *zhuying = UILabel.new;
    zhuying.textAlignment = NSTextAlignmentLeft;
    zhuying.textColor = RGB(102, 102, 102);
    zhuying.font = [UIFont systemFontOfSize:12.0f];
    zhuying.text = _storeBaseInfo.merchant_describe;//@"主营: 咖啡、茗茶、港式简餐、特色小食一应俱全";
    [zhuyingview addSubview:zhuying];
    [zhuying makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhuyingview.top).offset(15);
        make.left.equalTo(zhuyingview.left).offset(15);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = RGB(240, 240, 240);
    [zhuyingview addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhuyingview.bottom).offset(-0.5);
        make.left.equalTo(zhuyingview.left).offset(0);
        make.right.equalTo(zhuyingview.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *addressview = UIView.new;
    addressview.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:addressview];
    [addressview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *address = UILabel.new;
    address.textAlignment = NSTextAlignmentLeft;
    address.textColor = RGB(102, 102, 102);
    address.font = [UIFont systemFontOfSize:12.0f];
    address.text = _storeBaseInfo.merchant_adress;//@"地址: 南京市鼓楼区丰台南路129号";
    [addressview addSubview:address];
    [address makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.top).offset(15);
        make.left.equalTo(addressview.left).offset(15);
    }];
    
    UIImageView *loc = UIImageView.new;
    [loc setImage:[UIImage imageNamed:@"d_loc"]];
    [addressview addSubview:loc];
    [loc makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.top).offset(12);
        make.right.equalTo(addressview.right).offset(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView3 = UIView.new;
    lineView3.backgroundColor = RGB(240, 240, 240);
    [zhuyingview addSubview:lineView3];
    [lineView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.bottom).offset(-0.5);
        make.left.equalTo(addressview.left).offset(0);
        make.right.equalTo(addressview.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBShopDetail *)storeBaseInfo containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 197.0f);
}

-(void)addhuiyuan{
    // 加入会员
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoMap:withStoreBaseInfo:)]) {
        [self.delegate gotoMap:self withStoreBaseInfo:_storeBaseInfo];
    }
}
@end
