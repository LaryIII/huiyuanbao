//
//  CXWebViewController.h
//
//  Created by 熊财兴 on 15/1/12.
//  Copyright (c) 2015年 熊财兴. All rights reserved.
//

#import "CXNavigationBarController.h"
@class WebViewJavascriptBridge;


@interface CXWebViewController : CXNavigationBarController

@property (nonatomic, strong) WebViewJavascriptBridge   *bridge;
@property (nonatomic, assign) BOOL                      pullRefreshSwitchClose;// defalut  is NO   means open. set Yes  close
@property (nonatomic, strong) UIWebView                 *webView;
@property (nonatomic, strong) UIWebView                 *specialWebView;//对特殊文件处理，如带视频微信文章,和正常webview加载分开，避免逻辑复杂
@property (nonatomic, assign) BOOL                      loadSpecialWeb;//if YES, use specialWebview or webview

- (instancetype)initWithAddress:(NSString*)urlString;
- (instancetype)initWithURL:(NSURL*)URL;
- (BOOL)webView:(UIWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;

- (void)loadRequest:(NSURLRequest*)request;

- (void)removeLostConnetionView;
- (void)createNetworkRefreshView;

- (void)networkAbnormalNeedCheck:(BOOL)check;

@end
