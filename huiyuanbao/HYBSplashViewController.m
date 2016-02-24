//
//  HYBSplashViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 15/9/6.
//  Copyright (c) 2015年 huiyuanbao. All rights reserved.
//

#import "HYBSplashViewController.h"
#import "GVUserDefaults+HYBProperties.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "HYBCommonTool.h"
#import "HYBTabNavViewController.h"

@interface HYBSplashViewController ()

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, retain) NSTimer        *animationTimer;

@property (nonatomic, retain) UIImageView     *animateImgView;

@property (nonatomic, retain) UIImageView     *backImgView;

@end

@implementation HYBSplashViewController
{
    NSArray     *_aniArray;
}

- (id)init{
    if(self = [super init])
    {
//        self.view.backgroundColor = [UIColor whiteColor];
//        _aniArray = @[@[@(117*31/18), @(146*41/99)],@[@(132*31/18), @(145*36/99)], @[@(156*31/18), @(171*31/99)], @[@(166*33/18), @(191*31/99)]];
//        [self createBlurryAnimationImgView:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    }
    return self;
}

- (void)createBlurryAnimationImgView:(CGRect)frame
{
    DeviceIdiomCode cod = [HYBCommonTool getCurrentDeviceModelIdiom];
    
    NSArray *distanceArray = [_aniArray objectAtIndex:cod];
    
    NSInteger start = [[distanceArray objectAtIndex:0] integerValue];
    NSInteger end = [[distanceArray objectAtIndex:1] integerValue];
    
    if(!_backImgView)
    {
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    }
    if(cod != DeviceIdiomIphone4)
    {
        [_backImgView setImage:[UIImage imageNamed:@"launch"]];
    }
    else
    {
        [_backImgView setImage:[UIImage imageNamed:@"launch4"]];
    }
    _backImgView.alpha = 0;
    [self.view  addSubview:_backImgView];
    
    [UIView animateWithDuration:0.5 animations:^{
        _backImgView.alpha=1;//让scrollview 渐变消失
        
    }completion:^(BOOL finished) {
        
    } ];
    
    [UIView animateWithDuration:.7 animations:^{
        
        [_animateImgView setFrame:CGRectMake((CGRectGetWidth(frame)-182)/2 ,CGRectGetHeight(frame) - end-start, 182, 27)];
        [_animateImgView setAlpha:1.0];
        
    } completion:^(BOOL finish){}];
    
    [self createAnimationTimer];
}

- (void)createAnimationTimer
{
    if(!_animationTimer)
    {
        _animationTimer = [NSTimer scheduledTimerWithTimeInterval:1.7 target:self selector:@selector(animationTimerRun:) userInfo:nil repeats:NO];
    }
}
- (void)animationTimerRun:(NSTimer *)timer
{
    [self setupViewControllers];
    NSArray *arr = [[UIApplication sharedApplication] windows];
    UIWindow *mainWindow = [arr objectAtIndex:0];
    [mainWindow setRootViewController: self.navigationController];
    
    [self destoryTimer];
}

- (void)destoryTimer
{
    if(_animationTimer)
    {
        if([_animationTimer isValid])
        {
            [_animationTimer invalidate];
        }
        _animationTimer = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    NSArray *arr = [[UIApplication sharedApplication] windows];
    UIWindow *mainWindow = [arr objectAtIndex:0];
    [mainWindow setRootViewController: self.navigationController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewControllers {
    // 判断用户是否已登录，如果没有登录，则跳登录，如果登录再进首页
//        [GVUserDefaults standardUserDefaults].token = nil;
//    if (![GVUserDefaults standardUserDefaults].token) {
//        HDWLoginViewController *loginController = [[HDWLoginViewController alloc] init];
////        loginController.delegate = self;
//        self.navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
//        self.navigationController.navigationBarHidden = YES;
////        [self presentViewController:navigationController animated:YES completion:^{
////        }];
//    }else{
        HYBTabNavViewController *tabnavController = [[HYBTabNavViewController alloc]init];
//        [self.navigationController pushViewController:tabnavController animated:YES];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:tabnavController];
        self.navigationController.navigationBarHidden = YES;
//    }
}


@end
