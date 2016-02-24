//
//  CXWebView.m
//
//  Created by 熊财兴 on 15/1/20.
//  Copyright (c) 2015年 熊财兴. All rights reserved.
//

#import "CXWebView.h"

/*CG_INLINE CGRect
 CGRectSetWidth(CGRect rect, CGFloat width)
 {
 rect.size.width = width;
 return rect;
 }
 
 CG_INLINE CGRect
 CGRectSetHeight(CGRect rect, CGFloat height)
 {
 rect.size.height = height;
 return rect;
 }*/
CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x)
{
    rect.origin.x = x;
    return rect;
}

CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y)
{
    rect.origin.y = y;
    return rect;
}


CG_INLINE UIEdgeInsets
UIEdgeInsetsSetTop(UIEdgeInsets insets, CGFloat top)
{
    insets.top = top;
    return insets;
}

/*CG_INLINE UIEdgeInsets
 UIEdgeInsetsSetLeft(UIEdgeInsets insets, CGFloat left)
 {
 insets.left = left;
 return insets;
 }*/
CG_INLINE UIEdgeInsets
UIEdgeInsetsSetBottom(UIEdgeInsets insets, CGFloat bottom)
{
    insets.bottom = bottom;
    return insets;
}

/*CG_INLINE UIEdgeInsets
 UIEdgeInsetsSetRight(UIEdgeInsets insets, CGFloat right)
 {
 insets.right = right;
 return insets;
 }*/

@interface CXWebView ()

@end

@implementation CXWebView

- (id) initWithFrame:(CGRect)aFrame
{
    if (self = [super initWithFrame:aFrame]) {
        
    }
    return self;
}

- (void)setFooterView:(UIView *)view
{
    if (_footerView) {
        [_footerView removeFromSuperview];
    }
    _footerView = view;
    _footerView.frame = CGRectSetY(_footerView.frame, self.scrollView.contentSize.height);
    
    self.scrollView.contentInset = UIEdgeInsetsSetBottom(self.scrollView.contentInset, view.frame.size.height);
    [self.scrollView addSubview:_footerView];
}

- (void)setHeaderView:(UIView *)view
{
    if (_headerView) {
        [_headerView removeFromSuperview];
    }
    _headerView = view;
    _headerView.frame = CGRectSetY(_headerView.frame, -_headerView.frame.size.height);
    self.scrollView.contentInset = UIEdgeInsetsSetTop(self.scrollView.contentInset, _headerView.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(0, -_headerView.frame.size.height);
    [self.scrollView addSubview:_headerView];
}


- (void)headerViewHeightChange:(CGFloat)height animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -height);
            self.scrollView.contentInset = UIEdgeInsetsSetTop(self.scrollView.contentInset, height);
            
            self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, -height, self.headerView.frame.size.width, height);
        }];
    }
    else {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -height);
        self.scrollView.contentInset = UIEdgeInsetsSetTop(self.scrollView.contentInset, height);
        
        self.headerView.frame = CGRectMake(self.headerView.frame.origin.x, -height, self.headerView.frame.size.width, height);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.footerView.frame = CGRectSetY(_footerView.frame, self.scrollView.contentSize.height);
    
    CGFloat webViewWidth = self.frame.size.width;
    
    //缩小到小于webview宽度时
    if (scrollView.contentSize.width < webViewWidth) {
        CGSize contentSize = scrollView.contentSize;
        contentSize.width = webViewWidth;
        scrollView.contentSize = contentSize;
    }
    
    //左右露边
    if (scrollView.contentSize.width - webViewWidth < 0 && scrollView.contentOffset.x < 0) {
        self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentOffset.x);
        self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentOffset.x);
    }
    
    //左露边
    else if (scrollView.contentOffset.x < 0) {
        self.headerView.frame = CGRectSetX(self.headerView.frame, 0);
        self.footerView.frame = CGRectSetX(self.footerView.frame, 0);
    }
    
    //右露边
    else if (scrollView.contentOffset.x > scrollView.contentSize.width - webViewWidth) {
        self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentSize.width - webViewWidth);
        self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentSize.width - webViewWidth);
    }
    
    //平常滚动/缩放
    else {
        self.headerView.frame = CGRectSetX(self.headerView.frame, scrollView.contentOffset.x);
        self.footerView.frame = CGRectSetX(self.footerView.frame, scrollView.contentOffset.x);
    }
}

@end
