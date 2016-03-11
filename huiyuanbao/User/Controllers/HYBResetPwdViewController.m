//
//  HYBResetPwdViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/11.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBResetPwdViewController.h"
#import "masonry.h"
#import "HYBResetLogin.h"
#import "HYBHomeViewController.h"

@interface HYBResetPwdViewController ()
@property (nonatomic, strong) HYBResetLogin *resetlogin;
@property (nonatomic, strong) UITextField *phonefield;
@property (nonatomic, strong) UITextField *psdfield;

@property (nonatomic, strong) UIButton *okBtn;
@end

@implementation HYBResetPwdViewController
- (void) dealloc{
    [_resetlogin removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(224, 75, 68);
    self.navigationBar.title = @"重置密码";
    self.navigationBar.backgroundColor = RGB(224, 75, 68);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat inputHeight = 44.0f;
    
    UIView *superview = self.view;
    
    UILabel *bigTitle = UILabel.new;
    bigTitle.textAlignment = NSTextAlignmentCenter;
    bigTitle.textColor = RGB(255, 255, 255);
    bigTitle.font = [UIFont systemFontOfSize:30.0f];
    bigTitle.text = @"重置密码";
    [self.view addSubview:bigTitle];
    [bigTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(100.0f);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
    }];
    
    
    UIImageView *phoneicon = UIImageView.new;
    phoneicon.image = [UIImage imageNamed:@"u_psw"];
    [self.view addSubview:phoneicon];
    [phoneicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigTitle.bottom).offset((inputHeight-25.0f)/2+30.0f);
        make.left.equalTo(superview.left).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _phonefield = UITextField.new;
    _phonefield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    CGRect frame1 = [_phonefield frame];
    frame1.size.width = 15.0f;
    UIView *leftview1 = [[UIView alloc] initWithFrame:frame1];
    _phonefield.leftView=leftview1;//设置输入框内左边的图标
    [_phonefield setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _phonefield.leftViewMode=UITextFieldViewModeAlways;
    _phonefield.placeholder=@"输入密码";//默认显示的字
    _phonefield.secureTextEntry=YES;//设置成密码格式
    _phonefield.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _phonefield.returnKeyType=UIReturnKeyNext;//返回键的类型
    _phonefield.font = [UIFont systemFontOfSize:13.0f];
    _phonefield.textColor = RGB(67, 67, 67);
    _phonefield.delegate=self;//设置委托
    _phonefield.tag = 10001;
    [self.view addSubview:_phonefield];
    [_phonefield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bigTitle.bottom).offset(30.0f);
        make.left.equalTo(phoneicon.right);
        make.height.mas_equalTo(inputHeight);
        make.right.equalTo(superview.right).offset(-5);
    }];
    
    UIView *lineview1 = UIView.new;
    lineview1.backgroundColor = RGB(243, 183, 179);
    [self.view addSubview:lineview1];
    [lineview1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phonefield.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *psdicon = UIImageView.new;
    psdicon.image = [UIImage imageNamed:@"u_psw"];
    [self.view addSubview:psdicon];
    [psdicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview1.bottom).offset((inputHeight-25.0f)/2);
        make.left.equalTo(superview.left).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _psdfield = UITextField.new;
    _psdfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    CGRect frame2 = [_psdfield frame];
    frame2.size.width = 15.0f;
    UIView *leftview2 = [[UIView alloc] initWithFrame:frame2];
    _psdfield.leftView=leftview2;//设置输入框内左边的图标
    [_psdfield setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _psdfield.leftViewMode=UITextFieldViewModeAlways;
    _psdfield.placeholder=@"再次确认密码";//默认显示的字
    _psdfield.secureTextEntry=YES;//设置成密码格式
    _psdfield.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _psdfield.returnKeyType=UIReturnKeyDone;//返回键的类型
    _psdfield.font = [UIFont systemFontOfSize:13.0f];
    _psdfield.textColor = RGB(67, 67, 67);
    _psdfield.delegate=self;//设置委托
    _psdfield.tag = 10002;
    [self.view addSubview:_psdfield];
    [_psdfield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview1.bottom);
        make.left.equalTo(psdicon.right);
        make.height.mas_equalTo(inputHeight);
        make.right.equalTo(superview.right).offset(-5);
    }];
    
    UIView *lineview2 = UIView.new;
    lineview2.backgroundColor = RGB(243, 183, 179);
    [self.view addSubview:lineview2];
    [lineview2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psdfield.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(0.5);
    }];
    
    _okBtn = UIButton.new;
    _okBtn.backgroundColor = RGB(255, 186, 65);
    _okBtn.layer.cornerRadius = 5.0f;
    [_okBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_okBtn setTitle:@"登录" forState:UIControlStateNormal];
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_okBtn addTarget:self action:@selector(resetlogins) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_okBtn];
    [_okBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview2.bottom).offset(28);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    self.resetlogin = [[HYBResetLogin alloc] initWithBaseURL:HYB_API_BASE_URL path:RESET_LOGIN cachePolicyType:kCachePolicyTypeNone];
    
    [self.resetlogin addObserver:self
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
        if (object == _resetlogin) {
            if (_resetlogin.isLoaded) {
                [self hideLoadingView];
                HYBHomeViewController *pushController = [[HYBHomeViewController alloc] init];
                [self.navigationController pushViewController:pushController animated:YES];
            }
            else if (_resetlogin.error) {
                [self showErrorMessage:[_resetlogin.error localizedFailureReason]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)resetlogins{
    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSince1970] * 1000.0;
    long time = (long)ceilf(nowTimestamp);
    NSString *timex = [NSString stringWithFormat:@"%li",time];
    [self.resetlogin loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{@"phoneno":@"13236567035",@"loginpassword":[timex stringByAppendingString: _psdfield.text],@"userId":@"ea47794a91d0401089539020b170db24"}];
}

@end
