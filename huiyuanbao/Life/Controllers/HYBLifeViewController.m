//
//  HYBLifeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBLifeViewController.h"
#import "masonry.h"
#import "ZButton.h"
#import "RDVTabBarController.h"
#import "HYBPhoneChargeViewController.h"
#import "HYBShihuaChargeViewController.h"
#import "HYBQQChargeViewController.h"
#import "HYBShiyouChargeViewController.h"
#import "HYBSelectCityViewController.h"

@interface HYBLifeViewController ()

@end

@implementation HYBLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"分类";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    [self addLeftNavigatorButton];
    
    CGFloat l = (width-1)/3;
    
    UIButton *phone = UIButton.new;
    [phone addTarget:self action:@selector(phone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phone];
    phone.backgroundColor = [UIColor whiteColor];
    [phone makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.equalTo(self.view.left);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *phoneView = UIImageView.new;
    [phoneView setImage:[UIImage imageNamed:@"phone"]];
    [phone addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phone.top).offset(10);
        make.left.equalTo(phone.left).offset((l-50)/2);
    }];
    
    UILabel *phoneLabel = UILabel.new;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = RGB(51, 51, 51);
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    phoneLabel.text = @"手机充值";
    [phone addSubview:phoneLabel];
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom).offset(15);
        make.left.equalTo(phone.left);
        make.width.mas_equalTo(l);
    }];
    
    UIButton *shihua = UIButton.new;
    [shihua addTarget:self action:@selector(shihua) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shihua];
    shihua.backgroundColor = [UIColor whiteColor];
    [shihua makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.equalTo(self.view.left).offset(l+0.5);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *shihuaView = UIImageView.new;
    [shihuaView setImage:[UIImage imageNamed:@"shihua"]];
    [shihua addSubview:shihuaView];
    [shihuaView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shihua.top).offset(10);
        make.left.equalTo(shihua.left).offset((l-50)/2);
    }];
    
    UILabel *shihuaLabel = UILabel.new;
    shihuaLabel.textAlignment = NSTextAlignmentCenter;
    shihuaLabel.textColor = RGB(51, 51, 51);
    shihuaLabel.font = [UIFont systemFontOfSize:14.0f];
    shihuaLabel.text = @"中石化";
    [shihua addSubview:shihuaLabel];
    [shihuaLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shihuaView.bottom).offset(15);
        make.left.equalTo(shihua.left);
        make.width.mas_equalTo(l);
    }];
    
    
    UIButton *shiyou = UIButton.new;
    [shiyou addTarget:self action:@selector(shiyou) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shiyou];
    shiyou.backgroundColor = [UIColor whiteColor];
    [shiyou makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.equalTo(self.view.left).offset(l*2+1);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *shiyouView = UIImageView.new;
    [shiyouView setImage:[UIImage imageNamed:@"shiyou"]];
    [shiyou addSubview:shiyouView];
    [shiyouView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shiyou.top).offset(10);
        make.left.equalTo(shiyou.left).offset((l-50)/2);
    }];
    
    UILabel *shiyouLabel = UILabel.new;
    shiyouLabel.textAlignment = NSTextAlignmentCenter;
    shiyouLabel.textColor = RGB(51, 51, 51);
    shiyouLabel.font = [UIFont systemFontOfSize:14.0f];
    shiyouLabel.text = @"中石油";
    [shiyou addSubview:shiyouLabel];
    [shiyouLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shiyouView.bottom).offset(15);
        make.left.equalTo(shiyou.left);
        make.width.mas_equalTo(l);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(l);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    UIButton *qq = UIButton.new;
    [qq addTarget:self action:@selector(qq) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qq];
    qq.backgroundColor = [UIColor whiteColor];
    [qq makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(l+0.5);
        make.left.equalTo(self.view.left);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *qqView = UIImageView.new;
    [qqView setImage:[UIImage imageNamed:@"qq"]];
    [qq addSubview:qqView];
    [qqView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qq.top).offset(10);
        make.left.equalTo(qq.left).offset((l-50)/2);
    }];
    
    UILabel *qqLabel = UILabel.new;
    qqLabel.textAlignment = NSTextAlignmentCenter;
    qqLabel.textColor = RGB(51, 51, 51);
    qqLabel.font = [UIFont systemFontOfSize:14.0f];
    qqLabel.text = @"腾讯充值";
    [qq addSubview:qqLabel];
    [qqLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qqView.bottom).offset(15);
        make.left.equalTo(qq.left);
        make.width.mas_equalTo(l);
    }];
    
    
    UIButton *tel = UIButton.new;
    [tel addTarget:self action:@selector(tel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tel];
    tel.backgroundColor = [UIColor whiteColor];
    [tel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(l+0.5);
        make.left.equalTo(self.view.left).offset(l+0.5);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *telView = UIImageView.new;
    [telView setImage:[UIImage imageNamed:@"tel"]];
    [tel addSubview:telView];
    [telView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tel.top).offset(10);
        make.left.equalTo(tel.left).offset((l-50)/2);
    }];
    
    UILabel *telLabel = UILabel.new;
    telLabel.textAlignment = NSTextAlignmentCenter;
    telLabel.textColor = RGB(51, 51, 51);
    telLabel.font = [UIFont systemFontOfSize:14.0f];
    telLabel.text = @"固话宽带";
    [tel addSubview:telLabel];
    [telLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telView.bottom).offset(15);
        make.left.equalTo(tel.left);
        make.width.mas_equalTo(l);
    }];
    
}

-(void)addLeftNavigatorButton
{
    ZButton *leftButton=[[ZButton alloc ] initWithFrame : CGRectMake (0, 31, 100, 44)];
    [leftButton setTitle : @"南京" forState : UIControlStateNormal];
    [leftButton setImage :[ UIImage imageNamed:@"city_arrow"] forState : UIControlStateNormal];
    [leftButton setTitleColor :RGB(255, 255, 255) forState : UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationBar addSubview :rightButton];
    [self.navigationBar setLeftButton:leftButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftButtonTapped:(id)sender
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBSelectCityViewController *pushController = [[HYBSelectCityViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)phone{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBPhoneChargeViewController *pushController = [[HYBPhoneChargeViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)shihua{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBShihuaChargeViewController *pushController = [[HYBShihuaChargeViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)shiyou{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBShiyouChargeViewController *pushController = [[HYBShiyouChargeViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)qq{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBQQChargeViewController *pushController = [[HYBQQChargeViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)tel{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    //    [self refreshData];
}

@end
