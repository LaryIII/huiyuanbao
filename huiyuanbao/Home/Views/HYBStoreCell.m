//
//  HYBStoreCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreCell.h"
#import "HYBStore.h"
#import "CXImageLoader.h"
#import "masonry.h"

static const CGFloat imgWidth = 100.0f;
static const CGFloat margin = 10.0f;
static const CGFloat innerMargin = 7.0f;


@interface HYBStoreCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *labelView;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIView *ratingView;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation HYBStoreCell

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
        
        UIView *headerView = UIView.new;
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.layer.masksToBounds = YES;
        [firstView addSubview:headerView];
        
        [headerView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(firstView.top).offset(0);
            make.left.equalTo(firstView.left).offset(0);
            make.right.equalTo(firstView.right).offset(0);
            make.height.mas_equalTo(40);
        }];
        
        UIImageView *icon = UIImageView.new;
        UIImage *image = [UIImage imageNamed:@"location"];
        [icon setImage:image];
        [headerView addSubview:icon];
        [icon makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.top).offset(10);
            make.left.equalTo(headerView.left).offset(padding);
        }];
        
        UILabel *title = UILabel.new;
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = RGB(51, 51, 51);
        title.font = [UIFont systemFontOfSize:14.0f];
        title.text = @"附近推荐";
        [headerView addSubview:title];
        [title makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.top).offset(11);
            make.left.equalTo(icon.right).offset(8);
        }];
        
        UIView *lineView = UIView.new;
        lineView.backgroundColor = RGB(204, 204, 204);
        [firstView addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.bottom).offset(0);
            make.left.equalTo(headerView.left).offset(0);
            make.right.equalTo(headerView.right).offset(0);
            make.height.mas_equalTo(0.5f);
        }];
        
        UIView *bottomView = UIView.new;
        [firstView addSubview:bottomView];
        [bottomView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.bottom).offset(0);
            make.left.equalTo(firstView.left).offset(0);
            make.right.equalTo(firstView.right).offset(0);
            make.bottom.equalTo(firstView.bottom).offset(0);
        }];
        
        UIImageView *storeImageView = UIImageView.new;
        UIImage *storeImg = [UIImage imageNamed:@"store_default"];
        [storeImageView setImage:storeImg];
        [bottomView addSubview:storeImageView];
        [storeImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bottomView.top).offset(padding);
            make.left.equalTo(bottomView.left).offset(padding);
            make.width.mas_equalTo(90);
            make.height.mas_equalTo(90);
        }];
        
        
        UILabel *storeTitle = UILabel.new;
        storeTitle.textAlignment = NSTextAlignmentLeft;
        storeTitle.textColor = RGB(51, 51, 51);
        storeTitle.font = [UIFont systemFontOfSize:14.0f];
        storeTitle.text = @"猫空咖啡(时代广场店)";
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
        
        UILabel *zhuying = UILabel.new;
        zhuying.textAlignment = NSTextAlignmentLeft;
        zhuying.textColor = RGB(204, 204, 204);
        zhuying.font = [UIFont systemFontOfSize:12.0f];
        zhuying.text = @"主营: 咖啡、茗茶、港式简餐、特色小食一应俱全";
        [bottomView addSubview:zhuying];
        [zhuying makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(storeTitle.bottom).offset(padding);
            make.left.equalTo(storeImageView.right).offset(15);
        }];
        
        UIView *ratingView = UIView.new;
        [bottomView addSubview:ratingView];
        [ratingView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(zhuying.bottom).offset(10);
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
            make.top.equalTo(zhuying.bottom).offset(15);
            make.left.equalTo(ratingView.right).offset(5);
        }];
        
        UILabel *info1 = UILabel.new;
        info1.textAlignment = NSTextAlignmentLeft;
        info1.textColor = RGB(204, 204, 204);
        info1.font = [UIFont systemFontOfSize:13.0f];
        info1.text = @"会员: ";
        [bottomView addSubview:info1];
        [info1 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(10);
            make.left.equalTo(storeImageView.right).offset(15);
        }];
        
        UILabel *info2 = UILabel.new;
        info2.textAlignment = NSTextAlignmentLeft;
        info2.textColor = RGB(245, 114, 110);
        info2.font = [UIFont systemFontOfSize:13.0f];
        info2.text = @"5";
        [bottomView addSubview:info2];
        [info2 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(10);
            make.left.equalTo(info1.right).offset(0);
        }];
        
        UILabel *info3 = UILabel.new;
        info3.textAlignment = NSTextAlignmentLeft;
        info3.textColor = RGB(204, 204, 204);
        info3.font = [UIFont systemFontOfSize:13.0f];
        info3.text = @"折";
        [bottomView addSubview:info3];
        [info3 makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(10);
            make.left.equalTo(info2.right).offset(0);
        }];
        
        UILabel *total = UILabel.new;
        total.textAlignment = NSTextAlignmentLeft;
        total.textColor = RGB(204, 204, 204);
        total.font = [UIFont systemFontOfSize:13.0f];
        total.text = @"共有545会员";
        [bottomView addSubview:total];
        [total makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.bottom).offset(10);
            make.right.equalTo(bottomView.right).offset(-padding);
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

- (void)setStore:(HYBStore *)store
{
    [self setNeedsLayout];
}


+ (CGSize)calculateCellSizeWithSummary:(HYBStore *)store containerWidth:(CGFloat)containerWidth
{
    return CGSizeMake(containerWidth, 148.0f);
}

-(void)clickAction{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoStoreDetail:withStore:)]) {
        [self.delegate gotoStoreDetail:self withStore:_store];
    }
}

//裁剪图片
- (UIImage *)cutImage:(UIImage*)image
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (imgWidth / imgWidth)) {
        newSize.width = image.size.width*image.scale;
        newSize.height = image.size.width*image.scale;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.scale*image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height*image.scale;
        newSize.width = image.size.height*image.scale;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.scale*image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

@end

