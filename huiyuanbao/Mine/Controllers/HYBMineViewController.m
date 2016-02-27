//
//  HYBMineViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBMineViewController.h"
#import "masonry.h"
#import "ZButton.h"

@interface HYBMineViewController ()

@end

@implementation HYBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"我的";
    self.view.backgroundColor = RGB(240, 240, 240);
    // Do any additional setup after loading the view.
    
    [self addRightNavigatorButton];
    [self addLeftNavigatorButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightNavigatorButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 48, 10, 48, 32)];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateHighlighted];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(2, 14, 5, 9)];
    [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar setRightButton:rightButton];}

- (void)addLeftNavigatorButton
{
    ZButton *leftButton=[[ZButton alloc ] initWithFrame : CGRectMake (0, 31, 100, 44)];
    [leftButton setTitle : @"南京" forState : UIControlStateNormal];
    [leftButton setImage :[ UIImage imageNamed:@"city_arrow"] forState : UIControlStateNormal];
    [leftButton setTitleColor :RGB(255, 255, 255) forState : UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationBar addSubview :rightButton];
    [self.navigationBar setLeftButton:leftButton];
}

- (void)leftButtonTapped:(id)sender
{
    //TODO
}

- (void)rightButtonTapped:(id)sender
{
    //TODO
}

@end
