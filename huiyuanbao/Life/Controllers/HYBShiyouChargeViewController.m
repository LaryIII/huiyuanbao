//
//  HYBShiyouChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBShiyouChargeViewController.h"
#import "masonry.h"

@interface HYBShiyouChargeViewController ()

@end

@implementation HYBShiyouChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"中石油加油卡充值";
    self.view.backgroundColor = RGB(240, 240, 240);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat top = self.navigationBarHeight;
    UIView *ssuperview = self.view;
    
    UIScrollView *scrollView = UIScrollView.new;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ssuperview).with.insets(UIEdgeInsetsMake(top,0,0,0));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView.width);
    }];
    
    
    UIView *cardview = UIView.new;
    cardview.backgroundColor = [UIColor whiteColor];
    [container addSubview:cardview];
    [cardview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.top);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *cardlabel = UILabel.new;
    cardlabel.textAlignment = NSTextAlignmentLeft;
    cardlabel.textColor = RGB(136, 136, 136);
    cardlabel.font = [UIFont systemFontOfSize:13.0f];
    cardlabel.text = @"加油卡卡号";
    [cardview addSubview:cardlabel];
    [cardlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardview.top).offset(16);
        make.left.equalTo(cardview.left).offset(15);
        make.width.mas_equalTo(80);
    }];
    
    UITextField *cardinput = UITextField.new;
    [cardinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    cardinput.leftViewMode=UITextFieldViewModeAlways;
    cardinput.placeholder=@"";//默认显示的字
    cardinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    cardinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    cardinput.font = [UIFont systemFontOfSize:15.0f];
    cardinput.textColor = RGB(67, 67, 67);
    cardinput.delegate=self;//设置委托
    cardinput.tag = 30002;
    [cardview addSubview:cardinput];
    [cardinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardview.top).offset(15);
        make.left.equalTo(cardview.right).offset(6);
        make.right.equalTo(cardview.right).offset(-15);
    }];
    
    UIView *phoneview = UIView.new;
    phoneview.backgroundColor = [UIColor whiteColor];
    [container addSubview:phoneview];
    [phoneview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardview.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *phonelabel = UILabel.new;
    phonelabel.textAlignment = NSTextAlignmentLeft;
    phonelabel.textColor = RGB(136, 136, 136);
    phonelabel.font = [UIFont systemFontOfSize:13.0f];
    phonelabel.text = @"手机号";
    [phoneview addSubview:phonelabel];
    [phonelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneview.top).offset(16);
        make.left.equalTo(phoneview.left).offset(15);
        make.width.mas_equalTo(50);
    }];
    
    UITextField *phoneinput = UITextField.new;
    [phoneinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    phoneinput.leftViewMode=UITextFieldViewModeAlways;
    phoneinput.placeholder=@"";//默认显示的字
    phoneinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    phoneinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    phoneinput.font = [UIFont systemFontOfSize:15.0f];
    phoneinput.textColor = RGB(67, 67, 67);
    phoneinput.delegate=self;//设置委托
    phoneinput.tag = 30003;
    [phoneview addSubview:phoneinput];
    [phoneinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneview.top).offset(15);
        make.left.equalTo(phoneview.right).offset(6);
        make.right.equalTo(phoneview.right).offset(-15);
    }];
    
    UIView *infoview = UIView.new;
    infoview.backgroundColor = [UIColor whiteColor];
    [container addSubview:infoview];
    [infoview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneview.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *infolabel = UILabel.new;
    infolabel.textAlignment = NSTextAlignmentLeft;
    infolabel.textColor = RGB(136, 136, 136);
    infolabel.font = [UIFont systemFontOfSize:13.0f];
    infolabel.text = @"卡信息";
    [infoview addSubview:infolabel];
    [infolabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoview.top).offset(16);
        make.left.equalTo(infoview.left).offset(15);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *infobtn = UIButton.new;
    infobtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [infobtn setTitle:@"点击查看" forState:UIControlStateNormal];
    [infobtn setTitleColor:RGB(51, 153, 255) forState:UIControlStateNormal];
    [infobtn addTarget:self action:@selector(viewCard) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:infobtn];
    [infobtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoview.top).offset(16);
        make.right.equalTo(container.right).offset(-15);
        make.height.mas_equalTo(13);
    }];
    
    UIView *btn2s = UIView.new;
    btn2s.backgroundColor = [UIColor clearColor];
    [container addSubview:btn2s];
    [btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoview.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*2+44);
    }];
    
    NSArray *pays = @[@{@"name":@"100元",@"id":@100},@{@"name":@"500元",@"id":@500},@{@"name":@"1000元",@"id":@1000}];
    for(int i=0;i<pays.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [btn setTitle:[pays[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 20001+i;
        [btn addTarget:self action:@selector(btn2clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn2s addSubview:btn];
        int btnw = (width-30-20)/3;
        if(i<3){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn2s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(44);
            }];
        }
    }
    
    
    UIView *total = UIView.new;
    total.backgroundColor = [UIColor clearColor];
    [container addSubview:total];
    [total makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2s.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    UILabel *totalLabel = UILabel.new;
    totalLabel.textAlignment = NSTextAlignmentLeft;
    totalLabel.textColor = RGB(51, 51, 51);
    totalLabel.font = [UIFont systemFontOfSize:13.0f];
    totalLabel.text = @"零售价";
    [total addSubview:totalLabel];
    [totalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(total.top).offset(15);
        make.left.equalTo(total.left).offset(15);
        make.width.mas_equalTo(50);
    }];
    UILabel *totalPay = UILabel.new;
    totalPay.textAlignment = NSTextAlignmentRight;
    totalPay.textColor = MAIN_COLOR;
    totalPay.font = [UIFont systemFontOfSize:13.0f];
    totalPay.text = @"￥100";
    [total addSubview:totalPay];
    [totalPay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(total.top).offset(15);
        make.right.equalTo(total.right).offset(-15);
        //        make.width.mas_equalTo(50);
    }];
    
    UIButton *btn = UIButton.new;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn.layer.cornerRadius = 5.0f;
    [btn setTitle:@"立即充值" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btn];
    btn.backgroundColor = MAIN_COLOR;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(total.bottom).offset(40);
        make.left.equalTo(container.left).offset(15);
        make.right.equalTo(container.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btn.bottom).offset(18);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewCard{
    
}

@end
