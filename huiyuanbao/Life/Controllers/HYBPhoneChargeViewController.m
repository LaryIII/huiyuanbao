//
//  HYBPhoneChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBPhoneChargeViewController.h"
#import "masonry.h"

@interface HYBPhoneChargeViewController ()
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;
@end

@implementation HYBPhoneChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"手机充值";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    UIView *segView = UIView.new;
    segView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segView];
    [segView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    _btn1 = UIButton.new;
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn1 setTitle:@"充话费" forState:UIControlStateNormal];
    [_btn1 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn1 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(huafei) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn1];
    _btn1.selected = YES;
    [_btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(segView.left);
        make.width.mas_equalTo(width/2);
        make.height.mas_equalTo(44);
    }];
    
    _btn2 = UIButton.new;
    _btn2.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn2 setTitle:@"充流量" forState:UIControlStateNormal];
    [_btn2 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn2 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn2 addTarget:self action:@selector(liuliang) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn2];
    _btn2.selected = NO;
    [_btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(_btn1.right);
        make.width.mas_equalTo(width/2);
        make.height.mas_equalTo(44);
    }];

    UIView *ssuperview = self.view;
    
    _scrollView1 = UIScrollView.new;
    _scrollView1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView1];
    _scrollView1.hidden = NO;
    [_scrollView1 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ssuperview).with.insets(UIEdgeInsetsMake(self.navigationBarHeight+44,0,0,0));
    }];
    
    UIView *container1 = [UIView new];
    [_scrollView1 addSubview:container1];
    [container1 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView1);
        make.width.equalTo(_scrollView1.width);
    }];
    
    UIView *selectPhone = UIView.new;
    selectPhone.backgroundColor = [UIColor whiteColor];
    [container1 addSubview:selectPhone];
    [selectPhone makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container1.top);
        make.left.equalTo(container1.left);
        make.right.equalTo(container1.right);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *phoneinput = UITextField.new;
    [phoneinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    phoneinput.leftViewMode=UITextFieldViewModeAlways;
    phoneinput.placeholder=@"请填写手机号码";//默认显示的字
    phoneinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    phoneinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    phoneinput.font = [UIFont systemFontOfSize:14.0f];
    phoneinput.textColor = RGB(51, 51, 51);
    phoneinput.delegate=self;//设置委托
    phoneinput.tag = 10001;
    [selectPhone addSubview:phoneinput];
    [phoneinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone.top).offset(15);
        make.left.equalTo(selectPhone.left).offset(15);
        make.width.mas_equalTo(200);
    }];
    
    UIButton *otherNumIcon = UIButton.new;
    otherNumIcon.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNumIcon setImage:[UIImage imageNamed:@"phonebook"] forState:UIControlStateNormal];
    [otherNumIcon addTarget:self action:@selector(otherNum) forControlEvents:UIControlEventTouchUpInside];
    [selectPhone addSubview:otherNumIcon];
    [otherNumIcon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone.top).offset(10);
        make.right.equalTo(selectPhone.right).offset(-15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *otherNum = UIButton.new;
    otherNum.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNum setTitle:@"其他号码" forState:UIControlStateNormal];
    [otherNum setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    [otherNum addTarget:self action:@selector(otherNum) forControlEvents:UIControlEventTouchUpInside];
    [selectPhone addSubview:otherNum];
    [otherNum makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone.top).offset(10);
        make.right.equalTo(otherNumIcon.left).offset(-10);
    }];
    
    UIView *title1 = UIView.new;
    title1.backgroundColor = RGB(235,235,235);
    [container1 addSubview: title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone.bottom);
        make.left.equalTo(container1.left);
        make.right.equalTo(container1.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title1 = UILabel.new;
    t_title1.textAlignment = NSTextAlignmentCenter;
    t_title1.textColor = RGB(136, 136, 136);
    t_title1.font = [UIFont systemFontOfSize:14.0f];
    t_title1.text = @"江苏移动";
    [title1 addSubview:t_title1];
    [t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    UIView *btn1s = UIView.new;
    btn1s.backgroundColor = [UIColor clearColor];
    [container1 addSubview:btn1s];
    [btn1s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(container1.left);
        make.right.equalTo(container1.right);
        make.height.mas_equalTo(15*2+33*1);
    }];
    
    NSArray *categarys = @[@{@"name":@"5元",@"id":@5},@{@"name":@"30元",@"id":@30},@{@"name":@"100元",@"id":@100}];
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
    
    UIButton *btn1x = UIButton.new;
    btn1x.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn1x.layer.cornerRadius = 5.0f;
    [btn1x setTitle:@"立即充值" forState:UIControlStateNormal];
    [btn1x setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1x addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [container1 addSubview:btn1x];
    btn1x.backgroundColor = MAIN_COLOR;
    [btn1x makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1s.bottom).offset(20);
        make.left.equalTo(container1.left).offset(15);
        make.right.equalTo(container1.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *tipsTitle = UILabel.new;
    tipsTitle.textAlignment = NSTextAlignmentCenter;
    tipsTitle.textColor = RGB(102, 102, 102);
    tipsTitle.font = [UIFont systemFontOfSize:15.0f];
    tipsTitle.text = @"温馨提示";
    [container1 addSubview:tipsTitle];
    [tipsTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1x.bottom).offset(30);
        make.left.equalTo(container1.left).offset(15);
    }];
    
    UILabel *tipsDetail = UILabel.new;
    tipsDetail.textAlignment = NSTextAlignmentCenter;
    tipsDetail.textColor = RGB(153, 153, 153);
    tipsDetail.font = [UIFont systemFontOfSize:12.0f];
    tipsDetail.text = @"1.全国可用, 及时生效, 当月有效, 无限制";
    [container1 addSubview:tipsDetail];
    [tipsDetail makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsTitle.bottom).offset(10);
        make.left.equalTo(container1.left).offset(15);
    }];

    
    
    
    
    _scrollView2 = UIScrollView.new;
    _scrollView2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView2];
    _scrollView2.hidden = YES;
    [_scrollView2 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ssuperview).with.insets(UIEdgeInsetsMake(self.navigationBarHeight+44,0,0,0));
    }];
    
    UIView *container2 = [UIView new];
    [_scrollView2 addSubview:container2];
    [container2 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView2);
        make.width.equalTo(_scrollView2.width);
    }];
    
    UIView *selectPhone2 = UIView.new;
    selectPhone2.backgroundColor = [UIColor whiteColor];
    [container2 addSubview:selectPhone2];
    [selectPhone2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(container2.top);
        make.left.equalTo(container2.left);
        make.right.equalTo(container2.right);
        make.height.mas_equalTo(50);
    }];
    
    UITextField *phoneinput2 = UITextField.new;
    [phoneinput2 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    phoneinput2.leftViewMode=UITextFieldViewModeAlways;
    phoneinput2.placeholder=@"请填写手机号码";//默认显示的字
    phoneinput2.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    phoneinput2.returnKeyType=UIReturnKeyDone;//返回键的类型
    phoneinput2.font = [UIFont systemFontOfSize:14.0f];
    phoneinput2.textColor = RGB(51, 51, 51);
    phoneinput2.delegate=self;//设置委托
    phoneinput2.tag = 10001;
    [selectPhone2 addSubview:phoneinput2];
    [phoneinput2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone2.top).offset(15);
        make.left.equalTo(selectPhone2.left).offset(15);
        make.width.mas_equalTo(200);
    }];
    
    UIButton *otherNumIcon2 = UIButton.new;
    otherNumIcon2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNumIcon2 setImage:[UIImage imageNamed:@"phonebook"] forState:UIControlStateNormal];
    [otherNumIcon2 addTarget:self action:@selector(otherNum2) forControlEvents:UIControlEventTouchUpInside];
    [selectPhone2 addSubview:otherNumIcon2];
    [otherNumIcon2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone2.top).offset(10);
        make.right.equalTo(selectPhone2.right).offset(-15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *otherNum2 = UIButton.new;
    otherNum2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNum2 setTitle:@"其他号码" forState:UIControlStateNormal];
    [otherNum2 setTitleColor:RGB(204, 204, 204) forState:UIControlStateNormal];
    [otherNum2 addTarget:self action:@selector(otherNum2) forControlEvents:UIControlEventTouchUpInside];
    [selectPhone2 addSubview:otherNum2];
    [otherNum2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone2.top).offset(10);
        make.right.equalTo(otherNumIcon2.left).offset(-10);
    }];
    
    UIView *title2 = UIView.new;
    title2.backgroundColor = RGB(235,235,235);
    [container2 addSubview: title2];
    [title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone2.bottom);
        make.left.equalTo(container2.left);
        make.right.equalTo(container2.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title2 = UILabel.new;
    t_title2.textAlignment = NSTextAlignmentCenter;
    t_title2.textColor = RGB(136, 136, 136);
    t_title2.font = [UIFont systemFontOfSize:14.0f];
    t_title2.text = @"江苏移动";
    [title2 addSubview:t_title2];
    [t_title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.top).offset(7);
        make.left.equalTo(title2.left).offset(15);
    }];
    
    UIView *btn2s = UIView.new;
    btn2s.backgroundColor = [UIColor clearColor];
    [container2 addSubview:btn2s];
    [btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.bottom);
        make.left.equalTo(container2.left);
        make.right.equalTo(container2.right);
        make.height.mas_equalTo(15*2+33*1);
    }];
    
    NSArray *categarys2 = @[@{@"name":@"5元",@"id":@5},@{@"name":@"30元",@"id":@30},@{@"name":@"100元",@"id":@100}];
    for(int i=0;i<categarys2.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[categarys2[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 10001+i;
        [btn addTarget:self action:@selector(btn1clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn2s addSubview:btn];
        int btnw = (width-30-30)/4;
        if(i<4){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn2s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn2s.top).offset(15*2+33);
                make.left.mas_equalTo((btnw+10)*(i-4)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }
        
    }
    
    UIButton *btn2x = UIButton.new;
    btn2x.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn2x.layer.cornerRadius = 5.0f;
    [btn2x setTitle:@"立即充值" forState:UIControlStateNormal];
    [btn2x setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn2x addTarget:self action:@selector(charge2) forControlEvents:UIControlEventTouchUpInside];
    [container2 addSubview:btn2x];
    btn2x.backgroundColor = MAIN_COLOR;
    [btn2x makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2s.bottom).offset(20);
        make.left.equalTo(container2.left).offset(15);
        make.right.equalTo(container2.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *tipsTitle2 = UILabel.new;
    tipsTitle2.textAlignment = NSTextAlignmentCenter;
    tipsTitle2.textColor = RGB(102, 102, 102);
    tipsTitle2.font = [UIFont systemFontOfSize:15.0f];
    tipsTitle2.text = @"温馨提示";
    [container2 addSubview:tipsTitle2];
    [tipsTitle2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2x.bottom).offset(30);
        make.left.equalTo(container2.left).offset(15);
    }];
    
    UILabel *tipsDetail2 = UILabel.new;
    tipsDetail2.textAlignment = NSTextAlignmentCenter;
    tipsDetail2.textColor = RGB(153, 153, 153);
    tipsDetail2.font = [UIFont systemFontOfSize:12.0f];
    tipsDetail2.text = @"1.全国可用, 及时生效, 当月有效, 无限制";
    [container2 addSubview:tipsDetail2];
    [tipsDetail2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsTitle2.bottom).offset(10);
        make.left.equalTo(container2.left).offset(15);
    }];
    
}

-(void)huafei{
    _scrollView1.hidden = NO;
    _scrollView2.hidden = YES;
    _btn1.selected = YES;
    _btn2.selected = NO;
}

-(void)liuliang{
    _scrollView1.hidden = YES;
    _scrollView2.hidden = NO;
    _btn1.selected = NO;
    _btn2.selected = YES;
}

-(void)otherNum{
    
}

-(void)otherNum2{
    
}

-(void)charge{
    
}

-(void)charge2{
    
}

@end

