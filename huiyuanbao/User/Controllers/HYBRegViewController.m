//
//  HYBRegViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBRegViewController.h"
#import "masonry.h"
#import "HYBSetPwdViewController.h"
#import "HYBSMSCode.h"

@interface HYBRegViewController ()
@property (nonatomic, strong) HYBSMSCode *smscode;
@property (nonatomic, strong) UITextField *phonefield;
@property (nonatomic, strong) UITextField *psdfield;
@property (nonatomic, strong) UITextField *emailfield;

@property (nonatomic, strong) UIButton *regBtn;
@end

@implementation HYBRegViewController

- (void) dealloc{
    [_smscode removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(224, 75, 68);
    self.navigationBar.title = @"注册";
    self.navigationBar.backgroundColor = RGB(224, 75, 68);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat inputHeight = 44.0f;
    
    UIView *superview = self.view;
    
    UILabel *bigTitle = UILabel.new;
    bigTitle.textAlignment = NSTextAlignmentCenter;
    bigTitle.textColor = RGB(255, 255, 255);
    bigTitle.font = [UIFont systemFontOfSize:30.0f];
    bigTitle.text = @"用户注册";
    [self.view addSubview:bigTitle];
    [bigTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.top).offset(100.0f);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
    }];
    
    
    UIImageView *phoneicon = UIImageView.new;
    phoneicon.image = [UIImage imageNamed:@"u_phone"];
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
    _phonefield.placeholder=@"手机号码";//默认显示的字
    _phonefield.keyboardType=UIKeyboardTypePhonePad;//设置键盘类型为默认的
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
    _psdfield.placeholder=@"验证码";//默认显示的字
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
    
    UILabel *gvlabel = UILabel.new;
    gvlabel.textAlignment = NSTextAlignmentLeft;
    gvlabel.text = @"获取验证码";
    gvlabel.textColor = RGB(255, 255, 255);
    gvlabel.font = [UIFont systemFontOfSize:13.0f];
    gvlabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(getCode)];
    [gvlabel addGestureRecognizer:tap];
    [self.view addSubview:gvlabel];
    [gvlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview1.bottom).offset((inputHeight-13)/2);
        make.right.equalTo(superview.right).offset(-15);
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
    
    UIImageView *emailicon = UIImageView.new;
    emailicon.image = [UIImage imageNamed:@"u_email"];
    [self.view addSubview:emailicon];
    [emailicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview2.bottom).offset((inputHeight-25.0f)/2);
        make.left.equalTo(superview.left).offset(15);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _emailfield = UITextField.new;
    _emailfield.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//设置其输入内容竖直居中
    CGRect frame3 = [_psdfield frame];
    frame3.size.width = 15.0f;
    UIView *leftview3 = [[UIView alloc] initWithFrame:frame2];
    _emailfield.leftView=leftview3;//设置输入框内左边的图标
    [_emailfield setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _emailfield.leftViewMode=UITextFieldViewModeAlways;
    _emailfield.placeholder=@"邮箱地址";//默认显示的字
    _emailfield.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _emailfield.returnKeyType=UIReturnKeyDone;//返回键的类型
    _emailfield.font = [UIFont systemFontOfSize:13.0f];
    _emailfield.textColor = RGB(67, 67, 67);
    _emailfield.delegate=self;//设置委托
    _emailfield.tag = 10003;
    [self.view addSubview:_emailfield];
    [_emailfield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview2.bottom);
        make.left.equalTo(psdicon.right);
        make.height.mas_equalTo(inputHeight);
        make.right.equalTo(superview.right).offset(-5);
    }];
    
    UIView *lineview3 = UIView.new;
    lineview3.backgroundColor = RGB(243, 183, 179);
    [self.view addSubview:lineview3];
    [lineview3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_emailfield.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(0.5);
    }];
    
    _regBtn = UIButton.new;
    _regBtn.backgroundColor = RGB(255, 186, 65);
    _regBtn.layer.cornerRadius = 5.0f;
    [_regBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_regBtn setTitle:@"下一步" forState:UIControlStateNormal];
    _regBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_regBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_regBtn];
    [_regBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview3.bottom).offset(28);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *checkBtn = UIButton.new;
    [checkBtn setTitleColor:RGB(243, 183, 179) forState:UIControlStateNormal];
    [checkBtn setTitle:@"我已阅读并同意遵守" forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"u_checkbox_normal"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"u_checkbox_selected"] forState:UIControlStateSelected];
    [checkBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [checkBtn addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkBtn];
    [checkBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_regBtn.bottom).offset(20);
        make.left.equalTo(superview.left).offset(15);
        make.width.mas_equalTo(156.0f);
    }];
    
    UIButton *protocolBtn = UIButton.new;
    [protocolBtn setTitleColor:RGB(243, 183, 179) forState:UIControlStateNormal];
    [protocolBtn setTitle:@"《惠员包软件许可与服务协议》" forState:UIControlStateNormal];
    [protocolBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [protocolBtn addTarget:self action:@selector(protocol) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolBtn];
    [protocolBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkBtn.bottom).offset(5);
        make.left.equalTo(superview.left).offset(36);
        make.width.mas_equalTo(198.0f);
    }];
    
    self.smscode = [[HYBSMSCode alloc] initWithBaseURL:HYB_API_BASE_URL path:SMS_CODE cachePolicyType:kCachePolicyTypeNone];
    
    [self.smscode addObserver:self
                   forKeyPath:kResourceLoadingStatusKeyPath
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
        if (object == _smscode) {
            if (_smscode.isLoaded) {
                // [self hideLoadingView];
//                [self.validate startTime];
            }
            else if (_smscode.error) {
                [self showErrorMessage:[_smscode.error localizedFailureReason]];
            }
        }
    }
}

- (void)hideKeyBoard{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == 10001){
        [_psdfield becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    
    return YES;
}
-(void)next{
    HYBSetPwdViewController *pushController = [[HYBSetPwdViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}
-(void)read{
    
}
-(void)protocol{
    
}
-(void)getCode{
//    [self.smscode loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{@"phoneno":@"13236567035",@"type":@1,@"uuid":@"54f5558da0cf601d42c34d4ca726cbed7c1b666b",@"cpuid":@"00000000-113a-8e7d-21d0-61980885d8da",@"timeStamp":@"1452916561019"}];
    [self.smscode loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{}];
}

@end
