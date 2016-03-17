//
//  HYBJoinShopViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBJoinShopViewController.h"
#import "masonry.h"

@interface HYBJoinShopViewController ()
@property (nonatomic, strong) UITextField *phonefield;
@property (nonatomic, strong) UITextField *psdfield;

@property (nonatomic, strong) UIButton *regBtn;
@property (nonatomic, strong) UIButton *checkBtn;
@end

@implementation HYBJoinShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat bannerH = width*300/640;
    self.navigationBar.title = @"会员注册";
    self.view.backgroundColor = RGB(240, 240, 240);
    CGFloat inputHeight = 44.0f;
    
    UIView *banner = UIView.new;
    [self.view addSubview:banner];
    [banner makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(bannerH);
    }];
    
    UIImageView *imageView = UIImageView.new;
    [imageView setImage:[UIImage imageNamed:@"d_bg"]];
    [banner addSubview:imageView];
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(banner);
    }];
    
    UILabel *shopName = UILabel.new;
    shopName.textAlignment = NSTextAlignmentCenter;
    shopName.textColor = [UIColor whiteColor];
    shopName.font = [UIFont systemFontOfSize:20.0f];
    shopName.text = @"蓝湾咖啡, 欢迎您";
    [banner addSubview:shopName];
    [shopName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banner.top).offset((bannerH-20)/2);
        make.left.equalTo(banner.left);
        make.right.equalTo(banner.right);
    }];
    
    UIView *superview = self.view;
    
    UIView *inputs = UIView.new;
    inputs.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputs];
    [inputs makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banner.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(88);
    }];
    
    UIImageView *phoneicon = UIImageView.new;
    phoneicon.image = [UIImage imageNamed:@"gray_phone"];
    phoneicon.backgroundColor = [UIColor whiteColor];
    [inputs addSubview:phoneicon];
    [phoneicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banner.bottom).offset((inputHeight-25.0f)/2);
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
    _phonefield.backgroundColor = [UIColor whiteColor];
    [inputs addSubview:_phonefield];
    [_phonefield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banner.bottom);
        make.left.equalTo(phoneicon.right);
        make.height.mas_equalTo(inputHeight);
        make.right.equalTo(superview.right).offset(-5);
    }];
    
    UIView *lineview1 = UIView.new;
    lineview1.backgroundColor = RGB(243, 183, 179);
    [inputs addSubview:lineview1];
    [lineview1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phonefield.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *psdicon = UIImageView.new;
    psdicon.image = [UIImage imageNamed:@"gray_name"];
    psdicon.backgroundColor = [UIColor whiteColor];
    [inputs addSubview:psdicon];
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
    _psdfield.placeholder=@"姓名";//默认显示的字
    _psdfield.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _psdfield.returnKeyType=UIReturnKeyDone;//返回键的类型
    _psdfield.font = [UIFont systemFontOfSize:13.0f];
    _psdfield.textColor = RGB(67, 67, 67);
    _psdfield.delegate=self;//设置委托
    _psdfield.tag = 10002;
    _psdfield.backgroundColor = [UIColor whiteColor];
    [inputs addSubview:_psdfield];
    [_psdfield makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview1.bottom);
        make.left.equalTo(psdicon.right);
        make.height.mas_equalTo(inputHeight);
        make.right.equalTo(superview.right).offset(-5);
    }];
    
    UIView *lineview2 = UIView.new;
    lineview2.backgroundColor = RGB(243, 183, 179);
    [inputs addSubview:lineview2];
    [lineview2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_psdfield.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(0.5);
    }];
    
    _checkBtn = UIButton.new;
    [_checkBtn setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_checkBtn setTitle:@"阅读并同意" forState:UIControlStateNormal];
    [_checkBtn setImage:[UIImage imageNamed:@"d_checkbox_normal"] forState:UIControlStateNormal];
    [_checkBtn setImage:[UIImage imageNamed:@"d_checkbox_selected"] forState:UIControlStateSelected];
    [_checkBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    _checkBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_checkBtn addTarget:self action:@selector(read) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_checkBtn];
    [_checkBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview2.bottom).offset(20);
        make.left.equalTo(superview.left).offset(10);
        make.width.mas_equalTo(98.0f);
        make.height.mas_equalTo(46);
    }];
    
    UIButton *protocolBtn = UIButton.new;
    [protocolBtn setTitleColor:RGB(51, 153, 255) forState:UIControlStateNormal];
    [protocolBtn setTitle:@"《注册协议》" forState:UIControlStateNormal];
    protocolBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [protocolBtn addTarget:self action:@selector(protocol) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:protocolBtn];
    [protocolBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineview2.bottom).offset(20);
        make.left.equalTo(_checkBtn.right).offset(4);
        make.width.mas_equalTo(86.0f);
        make.height.mas_equalTo(46);
    }];

    
   
    _regBtn = UIButton.new;
    _regBtn.backgroundColor = MAIN_COLOR;
    _regBtn.layer.cornerRadius = 5.0f;
    [_regBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_regBtn setTitle:@"注册" forState:UIControlStateNormal];
    _regBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_regBtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
    _regBtn.selected = NO;
    [self.view addSubview:_regBtn];
    [_regBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_checkBtn.bottom).offset(28);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)read{
    if(_checkBtn.selected){
        _checkBtn.selected = NO;
    }else{
        _checkBtn.selected = YES;
    }
    
}
@end
