//
//  AppDelegate.h
//  huiyuanbao
//
//  Created by zhouhai on 15/11/22.
//  Copyright © 2015年 huiyuanbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) dispatch_queue_t  workQueue;
@end
@interface BaiduMapApiDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
    BMKMapManager * _mapManager;
}

@end

