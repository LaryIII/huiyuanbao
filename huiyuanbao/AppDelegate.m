//
//  AppDelegate.m
//  huiyuanbao
//
//  Created by zhouhai on 15/9/6.
//  Copyright (c) 2015年 huiyuanbao. All rights reserved.
//

#import "AppDelegate.h"
#import "CXLog.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "HYBSplashViewController.h"
#import "RDVTabBarController.h"
#import "HYBLaunchViewController.h"
#import "GVUserDefaults+HYBProperties.h"

#define NotifyActionKey "NotifyAction"
NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

@interface AppDelegate ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSString *deviceToken;
@property (nonatomic, strong) NSString *payloadId;
@property (nonatomic, assign) int lastPaylodIndex;
@property (nonatomic) BOOL isLaunchedByNotification;
@property (nonatomic, strong) NSDictionary *userinfo;

//@property (nonatomic, strong) HDWRecruitDetail *recruitDetail;
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    CXLogFormatter *formatter = [[CXLogFormatter alloc] init];
    [[DDASLLogger sharedInstance] setLogFormatter:formatter];
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) { // 判断是否是IOS7
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        [application setStatusBarStyle:UIStatusBarStyleLightContent];//黑体白字
        [application setStatusBarStyle:UIStatusBarStyleDefault];//黑体黑字
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    [self gotoMain];
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (void) gotoLaunch{
    HYBLaunchViewController *splashViewController = [[HYBLaunchViewController alloc] init];
    [self.window setRootViewController:splashViewController];
}

- (void) gotoMain{
    HYBSplashViewController *splashViewController = [[HYBSplashViewController alloc] init];
    [self.window setRootViewController:splashViewController];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    NSLog(@"%@", @"123");
}


@end
