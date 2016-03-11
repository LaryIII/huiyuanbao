//
//  HYBContactLetterCell.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/11.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBContactLetterCell.h"
@interface HYBContactLetterCell()
@property (nonatomic, strong) UILabel *letterLabel;
@end
@implementation HYBContactLetterCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:0.93f green:0.93f blue:0.95f alpha:1];
        self.letterLabel = [[UILabel alloc] initWithFrame:self.bounds];
        self.letterLabel.textAlignment = NSTextAlignmentLeft;
        self.letterLabel.textColor = [UIColor colorWithRed:0.55f green:0.55f blue:0.57f alpha:1.0];
        self.letterLabel.font = [UIFont systemFontOfSize:14.0f];
        self.letterLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        self.letterLabel.numberOfLines = 0;
        self.letterLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.letterLabel setText:@""];
        [self.contentView addSubview:self.letterLabel];
        
        NSDictionary *views = @{
                                @"contentView":self.contentView,
                                @"letterLabel":self.letterLabel
                                };
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[letterLabel]-10-|" options:0 metrics:0 views:views]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[letterLabel]-5-|" options:0 metrics:0 views:views]];
    }
    return self;
}

- (void)layoutSubviews
{
}

- (void)setLetter:(NSString *)letter
{
    _letterLabel.text = letter;
    
}

@end