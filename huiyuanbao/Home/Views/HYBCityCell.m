//
//  HYBCityCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCityCell.h"
#import "masonry.h"

@implementation HYBCityCell
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
            make.height.mas_equalTo(44.0f);
        }];
        
        UILabel *city = UILabel.new;
        city.textAlignment = NSTextAlignmentLeft;
        city.textColor = RGB(51, 51, 51);
        city.font = [UIFont systemFontOfSize:14.0f];
        city.text = @"南京";
        [firstView addSubview:city];
        [city makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.top).offset(13);
            make.left.equalTo(firstView.left).offset(20);
        }];
        
        UIView *lineView2 = UIView.new;
        lineView2.backgroundColor = RGB(204, 204, 204);
        [firstView addSubview:lineView2];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.bottom).offset(-0.5);
            make.left.equalTo(firstView.left).offset(0);
            make.right.equalTo(firstView.right).offset(0);
            make.height.mas_equalTo(0.5f);
        }];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setCity:(HYBCity *)city
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBCity *)city containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 44.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoCity:withCity:)]) {
        [self.delegate gotoCity:self withCity:_city];
    }
}
@end
