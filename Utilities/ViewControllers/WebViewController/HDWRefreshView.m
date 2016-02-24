//
//  HDWRefreshView.m
//  haidaowan
//
//  Created by zhouhai on 15/4/28.
//  Copyright (c) 2015年 AiJia. All rights reserved.
//

#import "HDWRefreshView.h"

@implementation HDWRefreshView


- (id)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if(self)
    {
        CGFloat wid = 80.0f;
        UIImageView *iconImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame)/2-wid/2, CGRectGetHeight(frame)/2-wid/2-80, wid, wid)];
        [iconImgV setImage:[UIImage imageNamed:@"refresh"]];
        [self addSubview:iconImgV];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImgV.frame)+20, CGRectGetWidth(frame), 25)];
        [label setTextColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:12.0]];
        [label setText:@"网络出错，轻触屏幕重新加载"];
        [self addSubview:label];
        
        UITapGestureRecognizer *tapGuest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshIconTapped:)];
        [self addGestureRecognizer:tapGuest];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)refreshIconTapped:(id)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(refreshViewTapped:)])
    {
        [self.delegate refreshViewTapped:nil];
    }
}


@end
