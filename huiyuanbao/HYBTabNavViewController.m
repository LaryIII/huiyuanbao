//
//  HYBTabNavViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 15/12/10.
//  Copyright © 2015年 huiyuanbao. All rights reserved.
//

#import "HYBTabNavViewController.h"
#import "RDVTabBarController.h"
#import "GVUserDefaults+HYBProperties.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "HYBCommonTool.h"
#import "HYBHomeViewController.h"
#import "HYBClazzViewController.h"
#import "HYBLifeViewController.h"
#import "HYBMineViewController.h"

@interface HYBTabNavViewController ()
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation HYBTabNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGB(255, 255, 255);

    HYBHomeViewController *homeController = [[HYBHomeViewController alloc] init];
    homeController.title = @"首页";
    RDVTabBarItem *homeItem = [[RDVTabBarItem alloc] init];
    homeItem.title = @"首页";
    homeItem.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
    [homeItem setFinishedSelectedImage:[UIImage imageNamed:@"home_active"] withFinishedUnselectedImage:[UIImage imageNamed:@"home"]];
    UIViewController *homeNavigationController = [[UINavigationController alloc]
                                                  initWithRootViewController:homeController];
    
    HYBClazzViewController *clazzController = [[HYBClazzViewController alloc] init];
    clazzController.title = @"分类";
    RDVTabBarItem *clazzItem = [[RDVTabBarItem alloc] init];
    clazzItem.title = @"分类";
    clazzItem.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
    [clazzItem setFinishedSelectedImage:[UIImage imageNamed:@"class_active"] withFinishedUnselectedImage:[UIImage imageNamed:@"class"]];
    UIViewController *clazzNavigationController = [[UINavigationController alloc]
                                                     initWithRootViewController:clazzController];
    
    HYBLifeViewController *lifeController = [[HYBLifeViewController alloc] init];
    lifeController.title = @"生活";
    RDVTabBarItem *lifeItem = [[RDVTabBarItem alloc] init];
    lifeItem.title = @"生活";
    lifeItem.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
    [lifeItem setFinishedSelectedImage:[UIImage imageNamed:@"life_active"] withFinishedUnselectedImage:[UIImage imageNamed:@"life"]];
    UIViewController *lifeNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:lifeController];
    
    HYBMineViewController *mineController = [[HYBMineViewController alloc] init];
    mineController.title = @"我的";
    RDVTabBarItem *mineItem = [[RDVTabBarItem alloc] init];
    mineItem.title = @"我的";
    mineItem.titlePositionAdjustment = UIOffsetMake(0.0f, 2.0f);
    [mineItem setFinishedSelectedImage:[UIImage imageNamed:@"mine_active"] withFinishedUnselectedImage:[UIImage imageNamed:@"mine"]];
    UIViewController *mineNavigationController = [[UINavigationController alloc]
                                                initWithRootViewController:mineController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    
    [tabBarController setViewControllers:@[homeNavigationController, clazzNavigationController,lifeNavigationController, mineNavigationController]];
    
    tabBarController.tabBar.items = @[homeItem, clazzItem, lifeItem, mineItem];
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        item.selectedTitleAttributes = @{
                                         NSFontAttributeName: [UIFont systemFontOfSize:10],
                                         NSForegroundColorAttributeName: MAIN_COLOR,
                                         };
        item.unselectedTitleAttributes = @{
                                           NSFontAttributeName: [UIFont systemFontOfSize:10],NSForegroundColorAttributeName: RGB(102, 102, 102),
                                           };
    }
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    self.navigationController.navigationBarHidden = YES;
    
    
    
    NSArray *arr = [[UIApplication sharedApplication] windows];
    UIWindow *mainWindow = [arr objectAtIndex:0];
    [mainWindow setRootViewController: self.navigationController];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
