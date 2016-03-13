//
//  HYBPhoneChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBPhoneChargeViewController.h"
#import "masonry.h"
#import "HYBPhoneContactsViewController.h"
#import "HYBQueryBelong.h"
#import "HYBChargeFee.h"
#import "HYBChargeFlow.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBPhoneChargeViewController ()
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;

@property (strong, nonatomic) UITextField *phoneinput;
@property (strong, nonatomic) UITextField *phoneinput2;

@property (strong, nonatomic) HYBQueryBelong *querybelong1;
@property (strong, nonatomic) HYBQueryBelong *querybelong2;
@property (strong, nonatomic) HYBChargeFee *chargefee;
@property (strong, nonatomic) HYBChargeFlow *chargeflow;

@property (strong,nonatomic) UILabel *t_title1;
@property (strong,nonatomic) UILabel *t_title2;

@property (strong,nonatomic) NSArray *categorys;
@property (strong,nonatomic) NSArray *categorys2;
@property (strong,nonatomic) NSString *totalMoney;
@property (strong,nonatomic) NSString *totalMoney2;
@property (strong,nonatomic) NSString *totalFlow;

@property (strong,nonatomic) UIView *btn1s;
@property (strong,nonatomic) UIView *btn2s;
@end

@implementation HYBPhoneChargeViewController

- (void) dealloc{
    [_querybelong1 removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_querybelong2 removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_chargefee removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_chargeflow removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _totalMoney = @"0";
    _totalMoney2 = @"0";
    _totalFlow = @"0";
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
    
    _phoneinput = UITextField.new;
    [_phoneinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _phoneinput.leftViewMode=UITextFieldViewModeAlways;
    _phoneinput.placeholder=@"请填写手机号码";//默认显示的字
    _phoneinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    _phoneinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    _phoneinput.font = [UIFont systemFontOfSize:14.0f];
    _phoneinput.textColor = RGB(51, 51, 51);
    _phoneinput.delegate=self;//设置委托
    _phoneinput.tag = 10001;
    [_phoneinput addTarget:self action:@selector(phoneNumDidChange) forControlEvents:UIControlEventEditingChanged];
    [selectPhone addSubview:_phoneinput];
    [_phoneinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone.top).offset(15);
        make.left.equalTo(selectPhone.left).offset(15);
        make.width.mas_equalTo(180);
    }];
    
    UIButton *otherNumIcon = UIButton.new;
    otherNumIcon.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNumIcon setImage:[UIImage imageNamed:@"phonebook"] forState:UIControlStateNormal];
    [otherNumIcon addTarget:self action:@selector(otherNums:) forControlEvents:UIControlEventTouchUpInside];
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
    [otherNum addTarget:self action:@selector(otherNums:) forControlEvents:UIControlEventTouchUpInside];
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
    
    _t_title1 = UILabel.new;
    _t_title1.textAlignment = NSTextAlignmentCenter;
    _t_title1.textColor = RGB(136, 136, 136);
    _t_title1.font = [UIFont systemFontOfSize:14.0f];
    _t_title1.text = @"";
    [title1 addSubview:_t_title1];
    [_t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    _btn1s = UIView.new;
    _btn1s.backgroundColor = [UIColor clearColor];
    [container1 addSubview:_btn1s];
    [_btn1s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(container1.left);
        make.right.equalTo(container1.right);
        make.height.mas_equalTo(15*2+33*1);
    }];
    
    _categorys = @[@{@"name":@"5元",@"id":@"5"},@{@"name":@"30元",@"id":@"30"},@{@"name":@"100元",@"id":@"100"}];
    for(int i=0;i<_categorys.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[_categorys[i] objectForKey:@"name"] forState:UIControlStateNormal];
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
    
    UIButton *btn1x = UIButton.new;
    btn1x.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn1x.layer.cornerRadius = 5.0f;
    [btn1x setTitle:@"立即充值" forState:UIControlStateNormal];
    [btn1x setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn1x addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [container1 addSubview:btn1x];
    btn1x.backgroundColor = MAIN_COLOR;
    [btn1x makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn1s.bottom).offset(20);
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
    
    [container1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipsDetail).offset(18);
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
    [phoneinput2 addTarget:self action:@selector(phoneNumDidChange2) forControlEvents:UIControlEventEditingChanged];
    [selectPhone2 addSubview:phoneinput2];
    [phoneinput2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectPhone2.top).offset(15);
        make.left.equalTo(selectPhone2.left).offset(15);
        make.width.mas_equalTo(200);
    }];
    
    UIButton *otherNumIcon2 = UIButton.new;
    otherNumIcon2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [otherNumIcon2 setImage:[UIImage imageNamed:@"phonebook"] forState:UIControlStateNormal];
    [otherNumIcon2 addTarget:self action:@selector(otherNums2:) forControlEvents:UIControlEventTouchUpInside];
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
    [otherNum2 addTarget:self action:@selector(otherNums2:) forControlEvents:UIControlEventTouchUpInside];
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
    
    _t_title2 = UILabel.new;
    _t_title2.textAlignment = NSTextAlignmentCenter;
    _t_title2.textColor = RGB(136, 136, 136);
    _t_title2.font = [UIFont systemFontOfSize:14.0f];
    _t_title2.text = @"";
    [title2 addSubview:_t_title2];
    [_t_title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.top).offset(7);
        make.left.equalTo(title2.left).offset(15);
    }];
    
    _btn2s = UIView.new;
    _btn2s.backgroundColor = [UIColor clearColor];
    [container2 addSubview:_btn2s];
    [_btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.bottom);
        make.left.equalTo(container2.left);
        make.right.equalTo(container2.right);
        make.height.mas_equalTo(15*2+33*1);
    }];
    
    _categorys2 = @[@{@"name":@"5元",@"id":@"5",@"flow":@"10"},@{@"name":@"10元",@"id":@"10",@"flow":@"30"},@{@"name":@"20元",@"id":@"20",@"flow":@"50"}];
    for(int i=0;i<_categorys2.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[_categorys2[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.layer.borderColor = MAIN_COLOR.CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 5.0;
        btn.tag = 10001+i;
        btn.selected = NO;
        [btn addTarget:self action:@selector(btn2clicked:) forControlEvents:UIControlEventTouchUpInside];
        [_btn2s addSubview:btn];
        int btnw = (width-30-30)/4;
        if(i<4){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn2s.top).offset(15);
                make.left.mas_equalTo((btnw+10)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(33);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_btn2s.top).offset(15*2+33);
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
        make.top.equalTo(_btn2s.bottom).offset(20);
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
    
    [container2 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipsDetail2).offset(18);
    }];
    
    self.querybelong1 = [[HYBQueryBelong alloc] initWithBaseURL:HYB_API_BASE_URL path:QUERY_BLONG cachePolicyType:kCachePolicyTypeNone];
    
    [self.querybelong1 addObserver:self
                   forKeyPath:kResourceLoadingStatusKeyPath
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    self.querybelong2 = [[HYBQueryBelong alloc] initWithBaseURL:HYB_API_BASE_URL path:QUERY_BLONG cachePolicyType:kCachePolicyTypeNone];
    
    [self.querybelong2 addObserver:self
                        forKeyPath:kResourceLoadingStatusKeyPath
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    
    self.chargefee = [[HYBChargeFee alloc] initWithBaseURL:HYB_API_BASE_URL path:CHARGE_FEE cachePolicyType:kCachePolicyTypeNone];
    
    [self.chargefee addObserver:self
                       forKeyPath:kResourceLoadingStatusKeyPath
                          options:NSKeyValueObservingOptionNew
                          context:nil];
    
    self.chargeflow = [[HYBChargeFlow alloc] initWithBaseURL:HYB_API_BASE_URL path:CHARGE_FLOW cachePolicyType:kCachePolicyTypeNone];
    
    [self.chargeflow addObserver:self
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
        if (object == _querybelong1) {
            if (_querybelong1.isLoaded) {
                [self hideLoadingView];
                _t_title1.text = _querybelong1.msg;
                
            }
            else if (_querybelong1.error) {
                [self showErrorMessage:[_querybelong1.error localizedFailureReason]];
            }
        }else if (object == _querybelong2) {
            if (_querybelong2.isLoaded) {
                [self hideLoadingView];
                _t_title2.text = _querybelong2.msg;
                
            }
            else if (_querybelong2.error) {
                [self showErrorMessage:[_querybelong2.error localizedFailureReason]];
            }
        }else if (object == _chargefee) {
            if (_chargefee.isLoaded) {
                 [self hideLoadingView];
            }
            else if (_chargefee.error) {
                [self showErrorMessage:[_chargefee.error localizedFailureReason]];
            }
        }else if (object == _chargeflow) {
            if (_chargeflow.isLoaded) {
                [self hideLoadingView];
            }
            else if (_chargeflow.error) {
                [self showErrorMessage:[_chargeflow.error localizedFailureReason]];
            }
        }
    }
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

-(void)otherNums:(id)sender{
    HYBPhoneContactsViewController *viewController = [[HYBPhoneContactsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)otherNums2:(id)sender{
    HYBPhoneContactsViewController *viewController = [[HYBPhoneContactsViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)charge{
    [self.chargefee loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                           @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                           @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                           @"mobile":_phoneinput.text,
                                                                                           @"totalMoney":_totalMoney,
                                                                                           @"cardType":@"0",
                                                                                           @"consumeType":@"1"
                                                                                           }];
}

-(void)charge2{
    [self.chargeflow loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                           @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                           @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                           @"mobile":_phoneinput.text,
                                                                                           @"cardType":@"0",
                                                                                           @"errMsg":_totalFlow,
                                                                                           @"consumeType":@"5",
                                                                                           @"totalMoney":_totalMoney2
                                                                                           }];
}

-(void)btn1clicked:(UIButton *)sender{
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
    
    _totalMoney = [_categorys[label-10001] objectForKey:@"id"];
}

-(void)btn2clicked:(UIButton *)sender{
    long label = sender.tag;
    for (UIButton *btn in _btn2s.subviews) {
        if(btn.tag == label){
            sender.selected = YES;
            sender.backgroundColor = MAIN_COLOR;
        }else{
            sender.selected = NO;
            sender.backgroundColor = [UIColor clearColor];
        }
    }
    _totalMoney2 = [_categorys[label-10001] objectForKey:@"id"];
    _totalFlow = [_categorys[label-10001] objectForKey:@"flow"];
}

-(void)phoneNumDidChange{
    if(_phoneinput.text.length == 11){
        [self.querybelong1 loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                              @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                              @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                              @"mobile":_phoneinput.text
                                                                                              }];
    }
}

-(void)phoneNumDidChange2{
    if(_phoneinput2.text.length == 11){
        [self.querybelong2 loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                               @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                               @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                               @"mobile":_phoneinput2.text
                                                                                               }];
    }
}

@end

