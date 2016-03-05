//
//  HYBCardCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCardCell.h"
#import "masonry.h"

@interface HYBCardCell()

@end

@implementation HYBCardCell
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
        storeTitle.font = [UIFont systemFontOfSize:15.0f];
        storeTitle.text = @"蓝湾咖啡";
        [bottomView addSubview:storeTitle];
        [storeTitle makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(12);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        
        UILabel *money = UILabel.new;
        money.textAlignment = NSTextAlignmentLeft;
        money.textColor = RGB(102, 102, 102);
        money.font = [UIFont systemFontOfSize:11.0f];
        money.text = @"余额: ";
        [bottomView addSubview:money];
        [money makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(25);
            make.left.equalTo(storeImageView.right).offset(10);
        }];
        UILabel *moneyValue = UILabel.new;
        moneyValue.textAlignment = NSTextAlignmentLeft;
        moneyValue.textColor = MAIN_COLOR;
        moneyValue.font = [UIFont systemFontOfSize:11.0f];
        moneyValue.text = @"1200.00";
        [bottomView addSubview:moneyValue];
        [moneyValue makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(25);
            make.left.equalTo(money.right).offset(2);
        }];
        
        UILabel *fanli = UILabel.new;
        fanli.textAlignment = NSTextAlignmentLeft;
        fanli.textColor = RGB(102, 102, 102);
        fanli.font = [UIFont systemFontOfSize:11.0f];
        fanli.text = @"返利: ";
        [bottomView addSubview:fanli];
        [fanli makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(25);
            make.left.equalTo(moneyValue.right).offset(4);
        }];
        UILabel *fanliValue = UILabel.new;
        fanliValue.textAlignment = NSTextAlignmentLeft;
        fanliValue.textColor = MAIN_COLOR;
        fanliValue.font = [UIFont systemFontOfSize:11.0f];
        fanliValue.text = @"23.45";
        [bottomView addSubview:fanliValue];
        [fanliValue makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(25);
            make.left.equalTo(fanli.right).offset(2);
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

- (void)setCard:(HYBCard *)card
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBCard *)card containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 80.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoCardDetail:withCard:)]) {
        [self.delegate gotoCardDetail:self withCard:_card];
    }
}
@end
