//
//  CXWebView.h
//
//  Created by 熊财兴 on 15/1/20.
//  Copyright (c) 2015年 熊财兴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXWebView : UIWebView

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *headerView;

- (void)headerViewHeightChange:(CGFloat)height animated:(BOOL)animated;

@end
