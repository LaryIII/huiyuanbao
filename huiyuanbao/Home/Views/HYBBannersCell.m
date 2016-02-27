//
//  HYBBannersCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//
#import "HYBBannersCell.h"

#import "CXCycleScrollView.h"

#import "HYBAdvertisement.h"

@interface HYBBannersCell () <CXCycleScrollViewDelegate>


@end

@implementation HYBBannersCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = CGRectGetWidth(self.bounds);
        CGFloat height = CGRectGetHeight(self.bounds);
        
        _cycleScrollView = [[CXCycleScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
        _cycleScrollView.showDot = YES;
        _cycleScrollView.delegate = self;
        [self.contentView addSubview:_cycleScrollView];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    
    _cycleScrollView.frame = CGRectMake(0.0F, 0.0F, width, height);
}

- (void)setBanners:(NSArray *)banners
{
    _banners = banners;
    
    if ([self.banners count] == 1) {
        HYBAdvertisement *advertisement = self.banners[0];
        self.cycleScrollView.imageURLArray = @[advertisement.bannerUrl];
    }
    else if ([self.banners count] > 1) {
        //        AJAdvertisement *fristAd = self.banners.firstObject;
        //        AJAdvertisement *lastAd = self.banners.lastObject;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (HYBAdvertisement *advertisement in self.banners) {
            [array addObject:advertisement.bannerUrl];
        }
        //        [array addObject:fristAd.bannerUrl];
        self.cycleScrollView.imageURLArray = array;
    }
    else {
        self.cycleScrollView.imageURLArray = @[];
    }
    _cycleScrollView.showDot = YES;
    
    [self setNeedsLayout];
}

#pragma mark CXCycleScrollViewDelegate
- (void)cycleScrollView:(CXCycleScrollView *)cycleScrollView didSelectIndex:(NSInteger)index
{
    if ([self.banners count] >= index) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannersCell:advertisement:)]) {
            if (index > 0) {
                [self.delegate bannersCell:self advertisement:self.banners[index - 1]];
            }
            else if (index == 0) {
                [self.delegate bannersCell:self advertisement:self.banners[index]];
            }
            
        }
    }
}

@end

