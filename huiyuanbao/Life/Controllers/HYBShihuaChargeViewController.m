//
//  HYBShihuaChargeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBShihuaChargeViewController.h"
#import "masonry.h"
#import "HYBQueryCardInfo.h"
#import "HYBChargeYou.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBShihuaChargeViewController ()
@property (strong, nonatomic) HYBQueryCardInfo *querycardinfo;
@property (strong, nonatomic) HYBChargeYou *chargeyou;

@property (strong, nonatomic) UITextField *cardinput;
@property (strong, nonatomic) UITextField *phoneinput;

@property (strong, nonatomic) NSString *cardid;//64127500 (中石化任意充) 64157002 (中石化直充500元)、64157001 (中石化直充1000元) 64157004 (中石化直充100元) 64349102 (中石油任意充)
@property (strong, nonatomic) NSString *cardType;//0 直冲 1 任意冲 手机只有直冲
@property (strong, nonatomic) NSString *totalMoney;

@property (strong, nonatomic) NSArray *pays;
@property (strong, nonatomic) UIView *btn2s;
@end

@implementation HYBShihuaChargeViewController

- (void) dealloc{
    [_querycardinfo removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_chargeyou removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _cardid = @"0";
    _cardType = @"0";
    _totalMoney = @"0";
    self.navigationBar.title = @"中石化加油卡充值";
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
    
    _cardinput = UITextField.new;
    [_cardinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _cardinput.leftViewMode=UITextFieldViewModeAlways;
    _cardinput.placeholder=@"";//默认显示的字
    _cardinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    _cardinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    _cardinput.font = [UIFont systemFontOfSize:15.0f];
    _cardinput.textColor = RGB(67, 67, 67);
    _cardinput.delegate=self;//设置委托
    _cardinput.tag = 30002;
    [cardview addSubview:_cardinput];
    [_cardinput makeConstraints:^(MASConstraintMaker *make) {
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
    
    _phoneinput = UITextField.new;
    [_phoneinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _phoneinput.leftViewMode=UITextFieldViewModeAlways;
    _phoneinput.placeholder=@"";//默认显示的字
    _phoneinput.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    _phoneinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    _phoneinput.font = [UIFont systemFontOfSize:15.0f];
    _phoneinput.textColor = RGB(67, 67, 67);
    _phoneinput.delegate=self;//设置委托
    _phoneinput.tag = 30003;
    [phoneview addSubview:_phoneinput];
    [_phoneinput makeConstraints:^(MASConstraintMaker *make) {
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
    
    _btn2s = UIView.new;
    _btn2s.backgroundColor = [UIColor clearColor];
    [container addSubview:_btn2s];
    [_btn2s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoview.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(15*2+44);
    }];
    
    _pays = @[@{@"name":@"100元",@"id":@"64157004",@"money":@"100"},@{@"name":@"500元",@"id":@"64157002",@"money":@"500"},@{@"name":@"1000元",@"id":@"64157001",@"money":@"1000"}];
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
        }
    }
    
    
    UIView *total = UIView.new;
    total.backgroundColor = [UIColor clearColor];
    [container addSubview:total];
    [total makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_btn2s.bottom);
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
    
    self.querycardinfo = [[HYBQueryCardInfo alloc] initWithBaseURL:HYB_API_BASE_URL path:QUERY_CARDINFO cachePolicyType:kCachePolicyTypeNone];
    
    [self.querycardinfo addObserver:self
                      forKeyPath:kResourceLoadingStatusKeyPath
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    self.chargeyou = [[HYBChargeYou alloc] initWithBaseURL:HYB_API_BASE_URL path:CHARGE_YOU cachePolicyType:kCachePolicyTypeNone];
    
    [self.chargeyou addObserver:self
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
        if (object == _querycardinfo) {
            if (_querycardinfo.isLoaded) {
                [self hideLoadingView];
                // TODO: 弹出卡信息
                
            }
            else if (_querycardinfo.error) {
                [self showErrorMessage:[_querycardinfo.error localizedFailureReason]];
            }
        }else if (object == _chargeyou) {
            if (_chargeyou.isLoaded) {
                [self hideLoadingView];
                
            }
            else if (_chargeyou.error) {
                [self showErrorMessage:[_chargeyou.error localizedFailureReason]];
            }
        }
    }
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
    _cardid = [_pays[label-20001] objectForKey:@"money"];
}

- (void)viewCard{
    [self.querycardinfo loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                            @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                            @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                            @"mobile":_phoneinput.text,
                                                                                            @"gameUserid":_cardinput.text
                                                                                            }];
}

-(void)charge{
    [self.chargeyou loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                             @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                             @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                             @"mobile":_phoneinput.text,
                                                                                             @"gameUserid":_cardinput.text,
                                                                                             @"consumeType":@"2",
                                                                                             @"consumeChildType":@"2",
                                                                                             @"cardType":_cardType,
                                                                                             @"totalMoney":_totalMoney,
                                                                                             @"cardid":_cardid
                                                                                             
                                                                                             }];
}

@end
