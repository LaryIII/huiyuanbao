//
//  HYBSetPasswordViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBSetPasswordViewController.h"
#import "masonry.h"
#import "HYBSetPassword.h"

@interface HYBSetPasswordViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) HYBSetPassword *setpassword;

@property (nonatomic, strong) UITextField *psd1;
@property (nonatomic, strong) UITextField *psd2;
@end

@implementation HYBSetPasswordViewController
- (void) dealloc{
    [_setpassword removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"设置支付密码";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    UIView *formView = UIView.new;
    formView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:formView];
    [formView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(90);
    }];
    
    UIImageView *psd1icon = UIImageView.new;
    [psd1icon setImage:[UIImage imageNamed:@"password2"]];
    [formView addSubview:psd1icon];
    [psd1icon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.top).offset(8);
        make.left.equalTo(formView.left).offset(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _psd1 = UITextField.new;
    _psd1.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    [_psd1 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _psd1.leftViewMode=UITextFieldViewModeAlways;
    _psd1.placeholder=@"请输入6位支付密码";//默认显示的字
    _psd1.keyboardType=UIKeyboardTypePhonePad;//设置键盘类型为默认的
    _psd1.returnKeyType=UIReturnKeyNext;//返回键的类型
    _psd1.font = [UIFont systemFontOfSize:13.0f];
    _psd1.textColor = RGB(67, 67, 67);
    _psd1.delegate=self;//设置委托
    _psd1.tag = 10001;
    [formView addSubview:_psd1];
    [_psd1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.top);
        make.left.equalTo(psd1icon.right).offset(15);
        make.right.equalTo(formView.right);
        make.height.mas_equalTo(45);
    }];
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = RGB(204, 204, 204);
    [formView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psd1.bottom).offset(-0.5);
        make.left.equalTo(formView.left).offset(10);
        make.right.equalTo(formView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIImageView *psd2icon = UIImageView.new;
    [psd2icon setImage:[UIImage imageNamed:@"password2"]];
    [formView addSubview:psd2icon];
    [psd2icon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.top).offset(45+8);
        make.left.equalTo(formView.left).offset(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    _psd2 = UITextField.new;
    _psd2.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    [_psd2 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _psd2.leftViewMode=UITextFieldViewModeAlways;
    _psd2.placeholder=@"请再次输入";//默认显示的字
    _psd2.keyboardType=UIKeyboardTypePhonePad;//设置键盘类型为默认的
    _psd2.returnKeyType=UIReturnKeyNext;//返回键的类型
    _psd2.font = [UIFont systemFontOfSize:13.0f];
    _psd2.textColor = RGB(67, 67, 67);
    _psd2.delegate=self;//设置委托
    _psd2.tag = 10002;
    [formView addSubview:_psd2];
    [_psd2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.top).offset(45);
        make.left.equalTo(psd1icon.right).offset(15);
        make.right.equalTo(formView.right);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *btn = UIButton.new;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn.layer.cornerRadius = 5.0f;
    [btn setTitle:@"保存密码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(savepsd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.backgroundColor = MAIN_COLOR;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(formView.bottom).offset(13);
        make.left.equalTo(self.view.left).offset(13);
        make.right.equalTo(self.view.right).offset(-13);
        make.height.mas_equalTo(44);
    }];
    
    self.setpassword = [[HYBSetPassword alloc] initWithBaseURL:HYB_API_BASE_URL path:SET_PASSWORD cachePolicyType:kCachePolicyTypeNone];
    
    [self.setpassword addObserver:self
                 forKeyPath:kResourceLoadingStatusKeyPath
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    
}

#pragma mark Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
        if (object == _setpassword) {
            if (_setpassword.isLoaded) {
                [self hideLoadingView];
//                HYBHomeViewController *pushController = [[HYBHomeViewController alloc] init];
//                [self.navigationController pushViewController:pushController animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else if (_setpassword.error) {
                [self showErrorMessage:[_setpassword.error localizedFailureReason]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)savepsd{
    [self.setpassword loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{@"phoneno":@"",@"userId":@"",@"paypassword":_psd1.text}];
}

@end
