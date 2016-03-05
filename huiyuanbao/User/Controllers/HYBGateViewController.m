//
//  HYBGateViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBGateViewController.h"
#import "masonry.h"
#import "HYBLoginViewController.h"
#import "HYBRegViewController.h"
#import "HYBChangePhoneViewController.h"
#import "HYBChangeNumViewController.h"

@interface HYBGateViewController ()
@end

@implementation HYBGateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(224, 75, 68);
    self.navigationBar.backgroundColor = RGB(224, 75, 68);
    self.navigationBar.hidden = YES;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIView *superview = self.view;
    
    UIImageView *logoView = UIImageView.new;
    logoView.image = [UIImage imageNamed:@"inner_logo"];
    [self.view addSubview:logoView];
    float left = (width-216)/2;
    [logoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(30);
        make.left.mas_equalTo(left);
        make.width.mas_equalTo(216);
        make.height.mas_equalTo(193);
    }];
    
    UILabel *bigTitle = UILabel.new;
    bigTitle.textAlignment = NSTextAlignmentCenter;
    bigTitle.textColor = RGB(255, 255, 255);
    bigTitle.font = [UIFont systemFontOfSize:30.0f];
    bigTitle.text = @"惠员包";
    bigTitle.hidden = YES;
    [superview addSubview:bigTitle];
    [bigTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoView.bottom).offset(20);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
    }];
    
    
    UIButton *okBtn = UIButton.new;
    okBtn.backgroundColor = RGB(239, 144, 41);
    okBtn.layer.cornerRadius = 5.0f;
    [okBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [okBtn setTitle:@"登录" forState:UIControlStateNormal];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [okBtn addTarget:self action:@selector(logins) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okBtn];
    [okBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigTitle.bottom).offset(65);
        make.left.equalTo(self.view.left).offset(15);
        make.right.equalTo(self.view.right).offset(-15);
        make.height.mas_equalTo(44.0f);
    }];
    
    UIButton *cancelBtn = UIButton.new;
    cancelBtn.backgroundColor = RGB(239, 144, 41);
    cancelBtn.layer.cornerRadius = 5.0f;
    [cancelBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [cancelBtn setTitle:@"注册" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [cancelBtn addTarget:self action:@selector(registers) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(okBtn.bottom).offset(18);
        make.left.equalTo(self.view.left).offset(15);
        make.right.equalTo(self.view.right).offset(-15);
        make.height.mas_equalTo(44.0f);
    }];
    
    
    UIButton *changePhone = UIButton.new;
    [changePhone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changePhone setTitle:@"更换手机" forState:UIControlStateNormal];
    changePhone.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [changePhone addTarget:self action:@selector(changePhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changePhone];
    
    [changePhone makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview.bottom).offset(-25);
        make.left.equalTo(self.view.left).offset(15);
        make.width.mas_equalTo(68.0f);
    }];
    
    UIButton *changeNum = UIButton.new;
    [changeNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeNum setTitle:@"更换号码" forState:UIControlStateNormal];
    changeNum.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [changeNum addTarget:self action:@selector(changeNum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeNum];
    
    [changeNum makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(superview.bottom).offset(-25);
        make.right.equalTo(self.view.right).offset(-15);
        make.width.mas_equalTo(68.0f);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyBoard{
    [self.view endEditing:YES];
}

-(void)logins{
    HYBLoginViewController *pushController = [[HYBLoginViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)registers{
    HYBRegViewController *pushController = [[HYBRegViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)changePhone{
    HYBChangePhoneViewController *pushController = [[HYBChangePhoneViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)changeNum{
    HYBChangeNumViewController *pushController = [[HYBChangeNumViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

@end
