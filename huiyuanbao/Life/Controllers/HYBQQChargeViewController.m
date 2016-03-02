//
//  HYBQQChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQQChargeViewController.h"
#import "masonry.h"

@interface HYBQQChargeViewController ()

@end

@implementation HYBQQChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"腾讯充值";
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
    
    UIView *title1 = UIView.new;
    title1.backgroundColor = RGB(235,235,235);
    [container addSubview: title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container.top);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title1 = UILabel.new;
    t_title1.textAlignment = NSTextAlignmentCenter;
    t_title1.textColor = RGB(136, 136, 136);
    t_title1.font = [UIFont systemFontOfSize:14.0f];
    t_title1.text = @"充值服务";
    [title1 addSubview:t_title1];
    [t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    UIView *btn1s = UIView.new;
    btn1s.backgroundColor = [UIColor clearColor];
    [container addSubview:btn1s];
    [btn1s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*3+33*2);
    }];
    
    NSArray *categarys = @[@{@"name":@"Q币",@"id":@1},@{@"name":@"QQ会员",@"id":@2},@{@"name":@"红钻",@"id":@3},@{@"name":@"黄钻",@"id":@4},@{@"name":@"蓝钻",@"id":@5},@{@"name":@"紫钻",@"id":@6},@{@"name":@"绿钻",@"id":@7}];
    for(int i=0;i<categarys.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[categarys[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 10001+i;
        [btn addTarget:self action:@selector(btn1clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn1s addSubview:btn];
        int btnw = (width-30-30)/4;
        if(i<4){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15*2+33);
                make.left.mas_equalTo((btnw+10)*(i-4)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }
        
    }
    
    
    UIView *title2 = UIView.new;
    title2.backgroundColor = RGB(235,235,235);
    [container addSubview: title2];
    [title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1s.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title2 = UILabel.new;
    t_title2.textAlignment = NSTextAlignmentCenter;
    t_title2.textColor = RGB(136, 136, 136);
    t_title2.font = [UIFont systemFontOfSize:14.0f];
    t_title2.text = @"充值金额";
    [title2 addSubview:t_title2];
    [t_title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.top).offset(7);
        make.left.equalTo(title2.left).offset(15);
    }];
    
    UIView *btn2s = UIView.new;
    btn2s.backgroundColor = [UIColor clearColor];
    [container addSubview:btn2s];
    [btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*3+44*2);
    }];
    
    NSArray *pays = @[@{@"name":@"5元",@"id":@5},@{@"name":@"10元",@"id":@10},@{@"name":@"20元",@"id":@20},@{@"name":@"30元",@"id":@30},@{@"name":@"50元",@"id":@50},@{@"name":@"100元",@"id":@100}];
    for(int i=0;i<pays.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [btn setTitle:[pays[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 20001+i;
        [btn addTarget:self action:@selector(btn1clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn1s addSubview:btn];
        int btnw = (width-30-20)/3;
        if(i<3){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn2s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(44);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn2s.top).offset(15*2+44);
                make.left.mas_equalTo((btnw+10)*(i-3)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(44);
            }];
        }
    }
    
    UIView *qqma = UIView.new;
    qqma.backgroundColor = [UIColor whiteColor];
    [container addSubview:qqma];
    [qqma makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2s.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *qqlabel = UILabel.new;
    qqlabel.textAlignment = NSTextAlignmentLeft;
    qqlabel.textColor = RGB(136, 136, 136);
    qqlabel.font = [UIFont systemFontOfSize:13.0f];
    qqlabel.text = @"QQ号码";
    [qqma addSubview:qqlabel];
    [qqlabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qqma.top).offset(16);
        make.left.equalTo(qqma.left).offset(15);
        make.width.mas_equalTo(50);
    }];
    
    UITextField *qqinput = UITextField.new;
    [qqinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    qqinput.leftViewMode=UITextFieldViewModeAlways;
    qqinput.placeholder=@"";//默认显示的字
    qqinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    qqinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    qqinput.font = [UIFont systemFontOfSize:15.0f];
    qqinput.textColor = RGB(67, 67, 67);
    qqinput.delegate=self;//设置委托
    qqinput.tag = 30002;
    [qqma addSubview:qqinput];
    [qqinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qqma.top).offset(15);
        make.left.equalTo(qqlabel.right).offset(6);
        make.right.equalTo(qqma.right).offset(-15);
    }];
    
    
    UIView *total = UIView.new;
    total.backgroundColor = [UIColor clearColor];
    [container addSubview:total];
    [total makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qqma.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(50);
    }];
    UILabel *totalLabel = UILabel.new;
    totalLabel.textAlignment = NSTextAlignmentLeft;
    totalLabel.textColor = RGB(51, 51, 51);
    totalLabel.font = [UIFont systemFontOfSize:13.0f];
    totalLabel.text = @"总价格";
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

- (void)btn1clicked:(id)sender{
    
}

@end
