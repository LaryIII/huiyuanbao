//
//  HYBQQChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQQChargeViewController.h"
#import "masonry.h"
#import "HYBChargeQQ.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBQQChargeViewController ()
@property (strong, nonatomic) HYBChargeQQ *chargeqq;

@property (strong, nonatomic) UITextField *qqinput;
@property (strong, nonatomic) NSString *consumeChildType;//5 QQ币 6红钻 7 紫钻 8 绿钻 9 QQ会员 11 蓝钻 12 黄钻 13 粉钻 手机固话充值无效
@property (strong, nonatomic) NSString *totalMoney;
@property (strong, nonatomic) NSString *cardid;

@property (strong, nonatomic) UIView *btn1s;
@property (strong, nonatomic) UIView *btn2s;

@property (strong, nonatomic) NSArray *categarys;
@property (strong, nonatomic) NSArray *pays;

@property (strong, nonatomic) UILabel *totalPay;
@end

@implementation HYBQQChargeViewController

- (void) dealloc{
    [_chargeqq removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _totalMoney = @"0";
    _cardid = @"";
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
    
    _btn1s = UIView.new;
    _btn1s.backgroundColor = [UIColor clearColor];
    [container addSubview:_btn1s];
    [_btn1s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*3+33*2);
    }];
    //5 QQ币 6红钻 7 紫钻 8 绿钻 9 QQ会员 11 蓝钻 12 黄钻 13 粉钻 手机固话充值无效
    _categarys = @[@{@"name":@"Q币",@"id":@"5"},@{@"name":@"QQ会员",@"id":@"9"},@{@"name":@"红钻",@"id":@"6"},@{@"name":@"黄钻",@"id":@"12"},@{@"name":@"蓝钻",@"id":@"11"},@{@"name":@"紫钻",@"id":@"7"},@{@"name":@"绿钻",@"id":@"8"},@{@"name":@"粉钻",@"id":@"13"}];
    for(int i=0;i<_categarys.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[_categarys[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 10001+i;
        btn.selected = NO;
        [btn addTarget:self action:@selector(btn1clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn1s addSubview:btn];
        int btnw = (width-30-30)/4;
        if(i<4){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn1s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn1s.top).offset(15*2+33);
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
        make.top.equalTo(_btn1s.bottom);
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
    
    _btn2s = UIView.new;
    _btn2s.backgroundColor = [UIColor clearColor];
    [container addSubview:_btn2s];
    [_btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*3+44*2);
    }];
    
    _pays = @[@{@"name":@"5元",@"id":@"5"},@{@"name":@"10元",@"id":@"10"},@{@"name":@"20元",@"id":@"20"},@{@"name":@"30元",@"id":@"30"},@{@"name":@"50元",@"id":@"50"},@{@"name":@"100元",@"id":@"100"}];
    for(int i=0;i<_pays.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [btn setTitle:[_pays[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 20001+i;
        btn.selected = NO;
        [btn addTarget:self action:@selector(btn2clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2s addSubview:btn];
        int btnw = (width-30-20)/3;
        if(i<3){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn2s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(44);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn2s.top).offset(15*2+44);
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
        make.top.equalTo(_btn2s.bottom);
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
    
    _qqinput = UITextField.new;
    [_qqinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _qqinput.leftViewMode=UITextFieldViewModeAlways;
    _qqinput.placeholder=@"";//默认显示的字
    _qqinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    _qqinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    _qqinput.font = [UIFont systemFontOfSize:15.0f];
    _qqinput.textColor = RGB(67, 67, 67);
    _qqinput.delegate=self;//设置委托
    _qqinput.tag = 30002;
    [qqma addSubview:_qqinput];
    [_qqinput makeConstraints:^(MASConstraintMaker *make) {
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
    _totalPay = UILabel.new;
    _totalPay.textAlignment = NSTextAlignmentRight;
    _totalPay.textColor = MAIN_COLOR;
    _totalPay.font = [UIFont systemFontOfSize:13.0f];
    _totalPay.text = @"￥100";
    [total addSubview:_totalPay];
    [_totalPay makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.chargeqq = [[HYBChargeQQ alloc] initWithBaseURL:HYB_API_BASE_URL path:CHARGE_QQ cachePolicyType:kCachePolicyTypeNone];
    
    [self.chargeqq addObserver:self
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
        if (object == _chargeqq) {
            if (_chargeqq.isLoaded) {
                [self hideLoadingView];
                
            }
            else if (_chargeqq.error) {
                [self showErrorMessage:[_chargeqq.error localizedFailureReason]];
            }
        }
    }
}

- (void)btn1clicked:(UIButton *)sender{
    long label = sender.tag;
    for (UIButton *btn in _btn1s.subviews) {
        if(btn.tag == label){
            btn.selected = YES;
            btn.backgroundColor = MAIN_COLOR;
        }else{
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
    _consumeChildType = [_categarys[label-10001] objectForKey:@"id"];
}

-(void)btn2clicked:(UIButton *)sender{
    long label = sender.tag;
    for (UIButton *btn in _btn2s.subviews) {
        if(btn.tag == label){
            btn.selected = YES;
            btn.backgroundColor = MAIN_COLOR;
        }else{
            btn.selected = NO;
            btn.backgroundColor = [UIColor clearColor];
        }
    }
    _totalMoney = [_pays[label-20001] objectForKey:@"id"];
    _totalPay.text = [NSString stringWithFormat:@"￥%@",_totalMoney];
}


-(void)charge{
    [self.chargeqq loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                         @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                         @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                         @"mobile":_qqinput.text,
                                                                                         @"consumeType":@"4",
                                                                                         @"consumeChildType":_consumeChildType,
                                                                                         @"cardnum":@"",
                                                                                         @"totalMoney":_totalMoney,
                                                                                         @"cardid":_cardid
                                                                                         
                                                                                         }];
}

@end
