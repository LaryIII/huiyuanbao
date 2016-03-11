//
//  HYBPhoneContactsCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/11.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBPhoneContactsCell.h"
#import "HYBPhoneContact.h"

@interface HYBPhoneContactsCell()
@property (nonatomic, strong) UIButton *contactView;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation HYBPhoneContactsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width = CGRectGetWidth(self.bounds);
        
        self.contentView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.95f alpha:1];
        
        self.contactView = [[UIButton alloc] initWithFrame:self.bounds];
        self.contactView.backgroundColor = [UIColor whiteColor];
        [self.contactView addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.contactView.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.image = [UIImage imageNamed:@"radio"];
        self.imageView.backgroundColor = [UIColor whiteColor];
        self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contactView addSubview:self.imageView];
        
        self.textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.textColor = [UIColor blackColor];
        self.textLabel.font = [UIFont systemFontOfSize:15.0f];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.text = @"";
        self.textLabel.backgroundColor = [UIColor whiteColor];
        self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contactView addSubview:self.textLabel];
        
        _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0.0F, 40.0f-0.5f, width, 0.5f)];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1.0f];
        [self.contactView addSubview:_bottomLineView];
        [self.contentView addSubview:self.contactView];
        
        NSDictionary *innerViews = @{
                                     @"contactView":self.contactView,
                                     @"icon":self.imageView,
                                     @"text":self.textLabel
                                     };
        [self.contactView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[icon(==30)]-10-[text]-10-|" options:0 metrics:0 views:innerViews]];
        [self.contactView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[icon(==30)]-5-|" options:0 metrics:0 views:innerViews]];
        [self.contactView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[text(==30)]-5-|" options:0 metrics:0 views:innerViews]];
        
        NSDictionary *views = @{
                                @"contentView":self.contentView,
                                @"contactView":self.contactView
                                };
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[contactView]-0-|" options:0 metrics:0 views:views]];
    }
    return self;
}

- (void)layoutSubviews
{
    //    [super layoutSubviews];
    //
    //    CGFloat width = CGRectGetWidth(self.bounds);
    //    CGFloat height = CGRectGetHeight(self.bounds);
    //
    //    _statusLabel.frame = CGRectMake(kAJMarginLeft, (height - 30.0f) / 2.0f, 30.0f, 30.0f);
}

- (void)setContact:(HYBPhoneContact *)contact
{
    //    _contact = contact;
    //    _letter.text = contact.pinYin;
    _contact = contact;
    _imageView.image = [UIImage imageNamed:@"radio"];
    _textLabel.text = _contact.contactName;
    
}

#pragma mark Button Response
- (void)clickAction:(UIButton *)sender
{
}

@end
