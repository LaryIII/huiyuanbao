//
//  HYBTixianViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBTixianViewController.h"
#import "masonry.h"
#import "HYBTixian.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBTixianViewController ()
@property (nonatomic, strong) UITextField *nameValue;
@property (nonatomic, strong) UITextField *phoneValue;
@property (nonatomic, strong) UITextField *amountValue;
@property (nonatomic, strong) UITextField *bankValue;
@property (nonatomic, strong) UITextField *bankingValue;
@property (nonatomic, strong) UIButton *tixianBtn;
@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, assign) int num;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) HYBTixian *tixian;
@end

@implementation HYBTixianViewController
- (void) dealloc{
    [_tixian removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.navigationBar.title = @"余额提现";
    self.view.backgroundColor = RGB(240, 240, 240);
    CGFloat inputHeight = 44.0f;
    
    UIView *superview = self.view;
    
    UIView *form = UIView.new;
    form.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:form];
    [form makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44*5+10);
    }];
    
    UIView *infoView = UIView.new;
    infoView.backgroundColor = [UIColor whiteColor];
    [form addSubview:infoView];
    [infoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(form.top);
        make.left.equalTo(form.left);
        make.right.equalTo(form.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *nameKey = UILabel.new;
    nameKey.textAlignment = NSTextAlignmentLeft;
    nameKey.textColor = RGB(153, 153, 153);
    nameKey.font = [UIFont systemFontOfSize:15.0f];
    nameKey.text = @"持卡人姓名";//@"一品牛腩煲";
    [infoView addSubview:nameKey];
    [nameKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.left.equalTo(infoView.left).offset(15);
    }];
    
    _nameValue = UITextField.new;
    _nameValue.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_nameValue setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _nameValue.leftViewMode=UITextFieldViewModeAlways;
    _nameValue.textAlignment = NSTextAlignmentRight;
    _nameValue.placeholder=@"";//默认显示的字
    _nameValue.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _nameValue.returnKeyType=UIReturnKeyDone;//返回键的类型
    _nameValue.font = [UIFont systemFontOfSize:13.0f];
    _nameValue.textColor = RGB(67, 67, 67);
    _nameValue.delegate=self;//设置委托
    _nameValue.tag = 10001;
    [infoView addSubview:_nameValue];
    [_nameValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.right.equalTo(infoView.right).offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *phoneView = UIView.new;
    phoneView.backgroundColor = [UIColor whiteColor];
    [form addSubview:phoneView];
    [phoneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *phoneLabel = UILabel.new;
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = RGB(153, 153, 153);
    phoneLabel.font = [UIFont systemFontOfSize:15.0f];
    phoneLabel.text = @"预留手机号";
    [phoneView addSubview:phoneLabel];
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.top).offset(15);
        make.left.equalTo(phoneView.left).offset(15);
    }];
    _phoneValue = UITextField.new;
    _phoneValue.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_phoneValue setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _phoneValue.leftViewMode=UITextFieldViewModeAlways;
    _phoneValue.textAlignment = NSTextAlignmentRight;
    _phoneValue.placeholder=@"";//默认显示的字
    _phoneValue.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _phoneValue.returnKeyType=UIReturnKeyDone;//返回键的类型
    _phoneValue.font = [UIFont systemFontOfSize:13.0f];
    _phoneValue.textColor = RGB(67, 67, 67);
    _phoneValue.delegate=self;//设置委托
    _phoneValue.tag = 10002;
    [phoneView addSubview:_phoneValue];
    [_phoneValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.top).offset(15);
        make.right.equalTo(phoneView.right).offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *lineview = UIView.new;
    lineview.backgroundColor = RGB(240, 240, 240);
    [infoView addSubview:lineview];
    [lineview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.bottom);
        make.left.equalTo(phoneView.left);
        make.right.equalTo(phoneView.right);
        make.height.mas_equalTo(10);
    }];
    
    UIView *amountView = UIView.new;
    amountView.backgroundColor = [UIColor whiteColor];
    [form addSubview:amountView];
    [amountView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *amountLabel = UILabel.new;
    amountLabel.textAlignment = NSTextAlignmentLeft;
    amountLabel.textColor = RGB(153, 153, 153);
    amountLabel.font = [UIFont systemFontOfSize:15.0f];
    amountLabel.text = @"提现金额";
    [amountView addSubview:amountLabel];
    [amountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountView.top).offset(15);
        make.left.equalTo(amountView.left).offset(15);
    }];
    _amountValue = UITextField.new;
    _amountValue.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_amountValue setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _amountValue.leftViewMode=UITextFieldViewModeAlways;
    _amountValue.textAlignment = NSTextAlignmentRight;
    _amountValue.placeholder=@"";//默认显示的字
    _amountValue.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _amountValue.returnKeyType=UIReturnKeyDone;//返回键的类型
    _amountValue.font = [UIFont systemFontOfSize:13.0f];
    _amountValue.textColor = RGB(67, 67, 67);
    _amountValue.delegate=self;//设置委托
    _amountValue.tag = 10003;
    [amountView addSubview:_amountValue];
    [_amountValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountView.top).offset(15);
        make.right.equalTo(amountView.right).offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    UIView *bankView = UIView.new;
    bankView.backgroundColor = [UIColor whiteColor];
    [form addSubview:bankView];
    [bankView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(amountView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *bankLabel = UILabel.new;
    bankLabel.textAlignment = NSTextAlignmentLeft;
    bankLabel.textColor = RGB(153, 153, 153);
    bankLabel.font = [UIFont systemFontOfSize:15.0f];
    bankLabel.text = @"银行卡号";
    [bankView addSubview:bankLabel];
    [bankLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView.top).offset(15);
        make.left.equalTo(bankView.left).offset(15);
    }];
    _bankValue = UITextField.new;
    _bankValue.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_bankValue setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _bankValue.leftViewMode=UITextFieldViewModeAlways;
    _bankValue.textAlignment = NSTextAlignmentRight;
    _bankValue.placeholder=@"";//默认显示的字
    _bankValue.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _bankValue.returnKeyType=UIReturnKeyDone;//返回键的类型
    _bankValue.font = [UIFont systemFontOfSize:13.0f];
    _bankValue.textColor = RGB(67, 67, 67);
    _bankValue.delegate=self;//设置委托
    _bankValue.tag = 10004;
    [bankView addSubview:_bankValue];
    [_bankValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView.top).offset(15);
        make.right.equalTo(bankView.right).offset(-15);
        make.width.mas_equalTo(200);
    }];
    
    
    UIView *bankingView = UIView.new;
    bankingView.backgroundColor = [UIColor whiteColor];
    [form addSubview:bankingView];
    [bankingView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *bankingLabel = UILabel.new;
    bankingLabel.textAlignment = NSTextAlignmentLeft;
    bankingLabel.textColor = RGB(153, 153, 153);
    bankingLabel.font = [UIFont systemFontOfSize:15.0f];
    bankingLabel.text = @"开户银行";
    [bankingView addSubview:bankingLabel];
    [bankingLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankingView.top).offset(15);
        make.left.equalTo(bankingView.left).offset(15);
    }];
    
    _bankingValue = UITextField.new;
    _bankingValue.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    [_bankingValue setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _bankingValue.leftViewMode=UITextFieldViewModeAlways;
    _bankingValue.textAlignment = NSTextAlignmentRight;
    _bankingValue.placeholder=@"";//默认显示的字
    _bankingValue.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _bankingValue.returnKeyType=UIReturnKeyDone;//返回键的类型
    _bankingValue.font = [UIFont systemFontOfSize:13.0f];
    _bankingValue.textColor = RGB(67, 67, 67);
    _bankingValue.delegate=self;//设置委托
    _bankingValue.tag = 10005;
    [bankingView addSubview:_bankingValue];
    [_bankingValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankingView.top).offset(15);
        make.right.equalTo(bankingView.right).offset(-15);
        make.width.mas_equalTo(200);
    }];

//    _arrowBtn = UIButton.new;
//    [_arrowBtn setImage:[UIImage imageNamed:@"filter_arrow"] forState:UIControlStateNormal];
//    [_arrowBtn setImage:[UIImage imageNamed:@"filter_arrow"] forState:UIControlStateDisabled];
//    [_arrowBtn addTarget:self action:@selector(selectbank) forControlEvents:UIControlEventTouchUpInside];
//    //    _arrowBtn.enabled = NO;
//    [bankingView addSubview:_arrowBtn];
//    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(bankingView.top).offset(11);
//        make.right.equalTo(bankingView.right);
//        make.width.mas_equalTo(15);
//        make.height.mas_equalTo(15);
//    }];
//    
    
    _tixianBtn = UIButton.new;
    _tixianBtn.backgroundColor = MAIN_COLOR;
    _tixianBtn.layer.cornerRadius = 5.0f;
    [_tixianBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_tixianBtn setTitle:@"确认提现" forState:UIControlStateNormal];
    _tixianBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_tixianBtn addTarget:self action:@selector(tixians) forControlEvents:UIControlEventTouchUpInside];
    //    _tixianBtn.selected = NO;
    [self.view addSubview:_tixianBtn];
    [_tixianBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(form.bottom).offset(15);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.tixian = [[HYBTixian alloc] initWithBaseURL:HYB_API_BASE_URL path:TIXIAN cachePolicyType:kCachePolicyTypeNone];
    
    [self.tixian addObserver:self
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
        if (object == _tixian) {
            if (_tixian.isLoaded) {
                [self hideLoadingView];
                // 跳支付？
                
            }
            else if (_tixian.error) {
                [self showErrorMessage:[_tixian.error localizedFailureReason]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyBoard{
    [self.view endEditing:YES];
}

-(void)tixians{
    [self showLoadingView];
    [self.tixian loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                            @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                            @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                            @"amount":_amountValue.text,//
                                                                                            @"bankcardno":_bankValue.text,//
                                                                                            @"bankuserphone":_phoneValue.text,
                                                                                            @"bankname":_bankingValue.text,
                                                                                            @"bankusername":_nameValue.text
                                                                                            }];
}
@end

