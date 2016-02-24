
//
//  CXWebViewController.m
//
//  Created by 熊财兴 on 15/1/12.
//  Copyright (c) 2015年 熊财兴. All rights reserved.
//

#import "CXWebViewController.h"

#import "RDVTabBarController.h"

#import "HDWRefreshView.h"

//#import "AJValidate.h"

//#import "AJLostConnectionView.h"

//#import "WebViewJavascriptBridge.h"

//#import "AJLoginController.h"

#import "GVUserDefaults+HYBProperties.h"

//#import "AJOrderListViewController.h"

//#import "AJPullDownRefreshView.h"

//#import "AJCompositeDetailController.h"

//#import "AJDecorationRootController.h"

//#import "AJActionSheet.h"

//#import "AJWeiXinPayment.h"

//#import "AJPullPayment.h"

//#import "AJConstant.h"

//#import "AJShareManager.h"

//#import "AJPayment.h"

#import "CXLog.h"

#import "HYBCommonTool.h"


#define KSpecialWebViewTag    199


@interface CXWebViewController () <UIWebViewDelegate, HDWRefreshViewDelegate, NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLRequest    *request;

@property (nonatomic, assign) BOOL            authed;

@property (nonatomic, retain) NSURLRequest    *originRequest;

@property (nonatomic, retain) NSURLRequest    *tmpRequest;

@end

@implementation CXWebViewController
{
    BOOL           _needRefresh;
    HDWRefreshView  *_refreshView;
}
#pragma mark - Initialization

- (void)dealloc {
    [_webView stopLoading];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    _webView.delegate = nil;
}

- (instancetype)initWithAddress:(NSString *)urlString {
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

- (instancetype)initWithURL:(NSURL*)pageURL {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:pageURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:15.0];
    return [self initWithURLRequest:request];
}

- (instancetype)initWithURLRequest:(NSURLRequest*)request {
    self = [super init];
    if (self) {
        self.request = request;
    }
    return self;
}

- (void)loadRequest:(NSURLRequest*)request {
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];

    [self destoryWebView];
    if(_loadSpecialWeb)
    {
        [self.specialWebView loadRequest:request];
        [self.specialWebView setDelegate:self];
    }
    else
    {
        [self.webView setFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - self.navigationBarHeight)];
        [self.webView setDelegate:self];
        [self.webView loadRequest:request];
    }
    DDLogDebug(@"*******************************request === %@", request);
}

- (void)specialWebViewLoadRequest:(NSURLRequest*)request {
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.specialWebView loadRequest:request];
    [self.specialWebView setDelegate:self];
    DDLogDebug(@"*******************************request === %@", request);
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    NSURLCache *sharedCache   = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    [self.view addSubview:self.webView];
    
    [self loadRequest:self.request];
    _refreshView = [[HDWRefreshView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    [_refreshView setDelegate:self];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)refreshCurrentPage
{
    [self loadRequest:self.request];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;

    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - Getters

- (void)destoryWebView
{
    [_webView stopLoading];
    [_webView setDelegate:nil];
    [_webView removeFromSuperview];
    if (_webView)
        _webView = nil;
    if(_bridge)
        _bridge = nil;
}

- (UIWebView*)webView {
    if(!_webView) {
        
        if(_specialWebView)
        {
            [_specialWebView removeFromSuperview];
            _specialWebView = nil;
        }
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - self.navigationBarHeight)];
//        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.backgroundColor = [UIColor clearColor];
        _webView.opaque = NO;
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    if([_webView superview] == nil)
    {
        [self.view addSubview:_webView];
    }
    
    [_webView setFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - self.navigationBarHeight)];
    return _webView;
}
- (void)addRefreshHead
{
    
}
- (void)refreshCurrentPageData
{
    [self loadRequest:self.request];
}

- (UIWebView*)specialWebView
{
    if(!_specialWebView) {
        
        if(_webView)
        {
            [_webView removeFromSuperview];
            _webView = nil;
        }
        
        _specialWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - self.navigationBarHeight)];
        _specialWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _specialWebView.backgroundColor = [UIColor clearColor];
        _specialWebView.opaque = NO;
        _specialWebView.tag = KSpecialWebViewTag;
        _specialWebView.delegate = self;
        _specialWebView.scalesPageToFit = YES;
    }
    if([_specialWebView superview] == nil)
    {
        [self.view addSubview:_specialWebView];
    }
    
    [_specialWebView setFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds) - self.navigationBarHeight)];
    return _specialWebView;
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    _needRefresh = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    if(self.navigationBar)
        self.navigationBar.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none'"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self networkAbnormalNeedCheck:NO];
}


- (void)back:(UIButton *)sender
{
    if(self.loadSpecialWeb)
    {
        if (self.specialWebView.canGoBack) {
            [self.specialWebView goBack];
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
            if ([[self rdv_tabBarController] isTabBarHidden]) {
                [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
            }
        }
    }
    else
    {
        if (self.webView.canGoBack) {
            [self.webView goBack];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)shouldRefresh
{
//    if(_needRefresh)
//    {
//        [self.view addSubview:_refreshView];
//        [self.webView loadHTMLString:@" " baseURL:nil];
//    }
//    else
//    {
//        [self.webView.scrollView.pullToRefreshView  stopAnimating];
//
//        [_refreshView removeFromSuperview];
//    }
}

#pragma mark   refresh view delegate

- (void)refreshViewTapped:(id)sender;
{
    _needRefresh = NO;
    [_refreshView removeFromSuperview];
    [self loadRequest:self.request];
}

#pragma mark --  Network refresh view
- (void)networkAbnormalNeedCheck:(BOOL)check
{
    if(!check)
    {
        [self createNetworkRefreshView];
    }
    else
    {
        
    }
}

- (void)createNetworkRefreshView
{
}

- (void)removeLostConnetionView
{
}
/*
 Delegate
 */
- (void)loseConnectionPageBeenTappedToRefresh:(id)sender;
{
    [self removeLostConnetionView];
    
    [self networkAbnormalNeedCheck:YES];
    
    if(_loadSpecialWeb)
    {
        [self specialWebViewLoadRequest:self.request];
    }
    else
        [self loadRequest:self.request];
}

#pragma mark  -- -  NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge previousFailureCount]== 0) {
        _authed = YES;
        //NSURLCredential 这个类是表示身份验证凭据不可变对象。凭证的实际类型声明的类的构造函数来确定。
        NSURLCredential* cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        [challenge.sender useCredential:cre forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:
(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod
            isEqualToString:NSURLAuthenticationMethodServerTrust];
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:
(NSURLAuthenticationChallenge *)challenge {
    if (([challenge.protectionSpace.authenticationMethod
          isEqualToString:NSURLAuthenticationMethodServerTrust])) {
//        if ([challenge.protectionSpace.host isEqualToString:TRUSTED_HOST]) {
            NSLog(@"Allowing bypass...");
            NSURLCredential *credential = [NSURLCredential credentialForTrust:
                                           challenge.protectionSpace.serverTrust];
            [challenge.sender useCredential:credential
                 forAuthenticationChallenge:challenge];
//        }
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.authed = YES;
    [connection cancel];

    //webview 重新加载请求。
    [self.webView loadRequest:_originRequest];
}

@end
