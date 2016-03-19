//
//  HYBPayViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBPayViewController.h"
#import "masonry.h"
#import "HYBOrderRecord.h"

@interface HYBPayViewController ()
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) HYBOrderRecord *order;
@end

@implementation HYBPayViewController
- (instancetype)initWithOrder:(HYBOrderRecord *)order {
    self = [super init];
    if (self) {
        self.order = order;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    int padding = 8;
    self.navigationBar.title = @"预订详情";
    self.view.backgroundColor = RGB(240, 240, 240);
    CGFloat inputHeight = 44.0f;
    
    UIView *superview = self.view;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat top = self.navigationBarHeight;
    
    UIScrollView *scrollView = UIScrollView.new;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.insets(UIEdgeInsetsMake(top,0,0,0));
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
    t_title1.text = @"订单详情";
    [title1 addSubview:t_title1];
    [t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    UIView *form = UIView.new;
    form.backgroundColor = [UIColor whiteColor];
    [container addSubview:form];
    [form makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(44*4);
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
    
    UILabel *orderName = UILabel.new;
    orderName.textAlignment = NSTextAlignmentLeft;
    orderName.textColor = RGB(153, 153, 153);
    orderName.font = [UIFont systemFontOfSize:15.0f];
    orderName.text = @"订单号";
    [infoView addSubview:orderName];
    [orderName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.left.equalTo(infoView.left).offset(15);
    }];
    
    UILabel *orderNameValue = UILabel.new;
    orderNameValue.textAlignment = NSTextAlignmentRight;
    orderNameValue.textColor = RGB(153, 153, 153);
    orderNameValue.font = [UIFont systemFontOfSize:15.0f];
    orderNameValue.text = _order.orderid;//[NSString stringWithFormat:@"%@",@"牛肉水饺"];//@"￥89.00";
    [infoView addSubview:orderNameValue];
    [orderNameValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.right.equalTo(infoView.right).offset(-15);
    }];
    
    UIView *timeView = UIView.new;
    timeView.backgroundColor = [UIColor whiteColor];
    [form addSubview:timeView];
    [timeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *timeLabel = UILabel.new;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = RGB(153, 153, 153);
    timeLabel.font = [UIFont systemFontOfSize:15.0f];
    timeLabel.text = @"交易名称";
    [timeView addSubview:timeLabel];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(15);
        make.left.equalTo(timeView.left).offset(15);
    }];
    
    UILabel *timeValue = UILabel.new;
    timeValue.textAlignment = NSTextAlignmentRight;
    timeValue.textColor = RGB(153, 153, 153);
    timeValue.font = [UIFont systemFontOfSize:15.0f];
    timeValue.text = _order.product_name;//[NSString stringWithFormat:@"%@",@"2016-03-19 17:20"];//@"￥89.00";
    [timeView addSubview:timeValue];
    [timeValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(15);
        make.right.equalTo(timeView.right).offset(-15);
    }];
    
    UIView *orderNo = UIView.new;
    orderNo.backgroundColor = [UIColor whiteColor];
    [form addSubview:orderNo];
    [orderNo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *orderNoLabel = UILabel.new;
    orderNoLabel.textAlignment = NSTextAlignmentLeft;
    orderNoLabel.textColor = RGB(153, 153, 153);
    orderNoLabel.font = [UIFont systemFontOfSize:15.0f];
    orderNoLabel.text = @"交易金额";
    [orderNo addSubview:orderNoLabel];
    [orderNoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNo.top).offset(15);
        make.left.equalTo(orderNo.left).offset(15);
    }];
    
    UILabel *orderNoValue = UILabel.new;
    orderNoValue.textAlignment = NSTextAlignmentRight;
    orderNoValue.textColor = RGB(153, 153, 153);
    orderNoValue.font = [UIFont systemFontOfSize:15.0f];
    orderNoValue.text = _order.product_price;//[NSString stringWithFormat:@"%@",@"201312312213132"];//@"￥89.00";
    [orderNo addSubview:orderNoValue];
    [orderNoValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNo.top).offset(15);
        make.right.equalTo(orderNo.right).offset(-15);
    }];
    
    UIView *orderTime = UIView.new;
    orderTime.backgroundColor = [UIColor whiteColor];
    [form addSubview:orderTime];
    [orderTime makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNo.bottom);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *orderTimeLabel = UILabel.new;
    orderTimeLabel.textAlignment = NSTextAlignmentLeft;
    orderTimeLabel.textColor = RGB(153, 153, 153);
    orderTimeLabel.font = [UIFont systemFontOfSize:15.0f];
    orderTimeLabel.text = @"下单日期";
    [orderTime addSubview:orderTimeLabel];
    [orderTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderTime.top).offset(15);
        make.left.equalTo(orderTime.left).offset(15);
    }];
    
    UILabel *orderTimeValue = UILabel.new;
    orderTimeValue.textAlignment = NSTextAlignmentRight;
    orderTimeValue.textColor = RGB(153, 153, 153);
    orderTimeValue.font = [UIFont systemFontOfSize:15.0f];
    orderTimeValue.text = _order.order_time;//[NSString stringWithFormat:@"%@",@"2016-03-19 17:20"];//@"￥89.00";
    [orderTime addSubview:orderTimeValue];
    [orderTimeValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderTime.top).offset(15);
        make.right.equalTo(orderTime.right).offset(-15);
    }];
    
    // 选择支付方式
    UIView *cashType = UIView.new;
    cashType.backgroundColor = [UIColor whiteColor];
    [container addSubview:cashType];
    [cashType makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(form.bottom).offset(10);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(250);
    }];
    
    UIView *yinlianView = UIView.new;
    yinlianView.backgroundColor = [UIColor whiteColor];
    [cashType addSubview:yinlianView];
    [yinlianView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashType.top);
        make.left.equalTo(cashType.left);
        make.right.equalTo(cashType.right);
        make.height.mas_equalTo(68);
    }];
    
    UIImageView *yinlianPay = UIImageView.new;
    [yinlianPay setImage:[UIImage imageNamed:@"unionpay"]];
    [yinlianView addSubview:yinlianPay];
    [yinlianPay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yinlianView.top).offset(20);
        make.left.equalTo(yinlianView.left).offset(15);
        make.width.mas_equalTo(126);
        make.height.mas_equalTo(32);
    }];
    
    UIButton *check1 = UIButton.new;
    [check1 setImage:[UIImage imageNamed:@"paycheckbox_unselect"] forState:UIControlStateNormal];
    [check1 setImage:[UIImage imageNamed:@"paycheckbox_select"] forState:UIControlStateSelected];
    [check1 addTarget:self action:@selector(check1) forControlEvents:UIControlEventTouchUpInside];
    check1.selected = NO;
    [yinlianView addSubview:check1];
    [check1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yinlianView.top).offset(20);
        make.right.equalTo(yinlianView.right).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView1 = UIView.new;
    lineView1.backgroundColor = RGB(240, 240, 240);
    [yinlianView addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yinlianView.bottom);
        make.left.equalTo(yinlianView.left).offset(0);
        make.right.equalTo(yinlianView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *aliView = UIView.new;
    aliView.backgroundColor = [UIColor whiteColor];
    [cashType addSubview:aliView];
    [aliView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yinlianView.bottom);
        make.left.equalTo(cashType.left);
        make.right.equalTo(cashType.right);
        make.height.mas_equalTo(68);
    }];
    
    UIImageView *aliPay = UIImageView.new;
    [aliPay setImage:[UIImage imageNamed:@"zhifubao"]];
    [aliView addSubview:aliPay];
    [aliPay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliView.top).offset(20);
        make.left.equalTo(aliView.left).offset(15);
        make.width.mas_equalTo(94);
        make.height.mas_equalTo(32);
    }];
    
    UIButton *check2 = UIButton.new;
    [check2 setImage:[UIImage imageNamed:@"paycheckbox_unselect"] forState:UIControlStateNormal];
    [check2 setImage:[UIImage imageNamed:@"paycheckbox_select"] forState:UIControlStateSelected];
    [check2 addTarget:self action:@selector(check2) forControlEvents:UIControlEventTouchUpInside];
    check2.selected = NO;
    [aliView addSubview:check2];
    [check2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliView.top).offset(20);
        make.right.equalTo(aliView.right).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = RGB(240, 240, 240);
    [aliView addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliView.bottom);
        make.left.equalTo(aliView.left).offset(0);
        make.right.equalTo(aliView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *yueView = UIView.new;
    yueView.backgroundColor = [UIColor whiteColor];
    [cashType addSubview:yueView];
    [yueView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(aliView.bottom);
        make.left.equalTo(cashType.left);
        make.right.equalTo(cashType.right);
        make.height.mas_equalTo(113);
    }];
    
    UIImageView *yuePay = UIImageView.new;
    [yuePay setImage:[UIImage imageNamed:@"yuepay"]];
    [yueView addSubview:yuePay];
    [yuePay makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yueView.top).offset(20);
        make.left.equalTo(yueView.left).offset(15);
        make.width.mas_equalTo(39);
        make.height.mas_equalTo(32);
    }];
    
    UILabel *yuelabel = UILabel.new;
    yuelabel.textAlignment = NSTextAlignmentLeft;
    yuelabel.textColor = RGB(11, 11, 11);
    yuelabel.font = [UIFont systemFontOfSize:16.0f];
    yuelabel.text = @"余额支付";
    [yueView addSubview:yuelabel];
    [yuelabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yueView.top).offset(25);
        make.left.equalTo(yuePay.right).offset(4);
    }];
    
    UIButton *check3 = UIButton.new;
    [check3 setImage:[UIImage imageNamed:@"paycheckbox_unselect"] forState:UIControlStateNormal];
    [check3 setImage:[UIImage imageNamed:@"paycheckbox_select"] forState:UIControlStateSelected];
    [check3 addTarget:self action:@selector(check3) forControlEvents:UIControlEventTouchUpInside];
    check3.selected = NO;
    [yueView addSubview:check3];
    [check3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yueView.top).offset(20);
        make.right.equalTo(yueView.right).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *yuelabel1 = UILabel.new;
    yuelabel1.textAlignment = NSTextAlignmentLeft;
    yuelabel1.textColor = RGB(11, 11, 11);
    yuelabel1.font = [UIFont systemFontOfSize:13.0f];
    yuelabel1.text = @"余额(";
    [yueView addSubview:yuelabel1];
    [yuelabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuePay.bottom).offset(30);
        make.left.equalTo(yueView.left).offset(15);
    }];
    UILabel *yuelabel2 = UILabel.new;
    yuelabel2.textAlignment = NSTextAlignmentLeft;
    yuelabel2.textColor = MAIN_COLOR;
    yuelabel2.font = [UIFont systemFontOfSize:13.0f];
    yuelabel2.text = @"199.87";
    [yueView addSubview:yuelabel2];
    [yuelabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuePay.bottom).offset(30);
        make.left.equalTo(yuelabel1.right).offset(2);
    }];
    UILabel *yuelabel3 = UILabel.new;
    yuelabel3.textAlignment = NSTextAlignmentLeft;
    yuelabel3.textColor = RGB(11, 11, 11);
    yuelabel3.font = [UIFont systemFontOfSize:13.0f];
    yuelabel3.text = @")";
    [yueView addSubview:yuelabel3];
    [yuelabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(yuePay.bottom).offset(30);
        make.left.equalTo(yuelabel2.right).offset(2);
    }];
    
    UITextField *yueinput1 = UITextField.new;
    [yueinput1 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    yueinput1.layer.borderWidth = 0.5f;
    yueinput1.layer.borderColor = RGB(153, 153, 153).CGColor;
    yueinput1.layer.cornerRadius = 3.0f;
    yueinput1.leftViewMode=UITextFieldViewModeAlways;
    yueinput1.placeholder=@"";//默认显示的字
    yueinput1.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    yueinput1.returnKeyType=UIReturnKeyDone;//返回键的类型
    yueinput1.font = [UIFont systemFontOfSize:13.0f];
    yueinput1.textColor = RGB(67, 67, 67);
    yueinput1.delegate=self;//设置委托
    [yueView addSubview:yueinput1];
    [yueinput1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(check3.bottom).offset(28);
        make.right.equalTo(yueView.right).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *zhifu1 = UILabel.new;
    zhifu1.textAlignment = NSTextAlignmentLeft;
    zhifu1.textColor = RGB(153, 153, 153);
    zhifu1.font = [UIFont systemFontOfSize:13.0f];
    zhifu1.text = @"支付";
    [yueView addSubview:zhifu1];
    [zhifu1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(check3.bottom).offset(30);
        make.right.equalTo(yueinput1.left).offset(-10);
    }];
    
    UIView *feicashType = UIView.new;
    feicashType.backgroundColor = [UIColor whiteColor];
    [container addSubview:feicashType];
    [feicashType makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cashType.bottom).offset(10);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(130);
    }];
    
    UIView *jifenView = UIView.new;
    jifenView.backgroundColor = [UIColor whiteColor];
    [feicashType addSubview:jifenView];
    [jifenView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feicashType.top);
        make.left.equalTo(feicashType.left);
        make.right.equalTo(feicashType.right);
        make.height.mas_equalTo(65);
    }];
    
    UIButton *check4 = UIButton.new;
    [check4 setImage:[UIImage imageNamed:@"paycheckbox_unselect"] forState:UIControlStateNormal];
    [check4 setImage:[UIImage imageNamed:@"paycheckbox_select"] forState:UIControlStateSelected];
    [check4 addTarget:self action:@selector(check4) forControlEvents:UIControlEventTouchUpInside];
    check4.selected = NO;
    [jifenView addSubview:check4];
    [check4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(15);
        make.left.equalTo(jifenView.left).offset(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *jifenlabel1 = UILabel.new;
    jifenlabel1.textAlignment = NSTextAlignmentLeft;
    jifenlabel1.textColor = RGB(11, 11, 11);
    jifenlabel1.font = [UIFont systemFontOfSize:13.0f];
    jifenlabel1.text = @"积分支付(";
    [jifenView addSubview:jifenlabel1];
    [jifenlabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(10);
        make.left.equalTo(check4.right).offset(10);
    }];
    UILabel *jifenlabel2 = UILabel.new;
    jifenlabel2.textAlignment = NSTextAlignmentLeft;
    jifenlabel2.textColor = MAIN_COLOR;
    jifenlabel2.font = [UIFont systemFontOfSize:13.0f];
    jifenlabel2.text = @"199.87";
    [jifenView addSubview:jifenlabel2];
    [jifenlabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(10);
        make.left.equalTo(jifenlabel1.right).offset(2);
    }];
    UILabel *jifenlabel3 = UILabel.new;
    jifenlabel3.textAlignment = NSTextAlignmentLeft;
    jifenlabel3.textColor = RGB(11, 11, 11);
    jifenlabel3.font = [UIFont systemFontOfSize:13.0f];
    jifenlabel3.text = @")";
    [jifenView addSubview:jifenlabel3];
    [jifenlabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(10);
        make.left.equalTo(jifenlabel2.right).offset(2);
    }];
    
    UILabel *dikoulabel1 = UILabel.new;
    dikoulabel1.textAlignment = NSTextAlignmentLeft;
    dikoulabel1.textColor = RGB(153, 153, 153);
    dikoulabel1.font = [UIFont systemFontOfSize:9.0f];
    dikoulabel1.text = @"抵扣(";
    [jifenView addSubview:dikoulabel1];
    [dikoulabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenlabel1.bottom).offset(8);
        make.left.equalTo(check4.right).offset(10);
    }];
    UILabel *dikoulabel2 = UILabel.new;
    dikoulabel2.textAlignment = NSTextAlignmentLeft;
    dikoulabel2.textColor = MAIN_COLOR;
    dikoulabel2.font = [UIFont systemFontOfSize:9.0f];
    dikoulabel2.text = @"0.87";
    [jifenView addSubview:dikoulabel2];
    [dikoulabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenlabel1.bottom).offset(8);
        make.left.equalTo(dikoulabel1.right).offset(2);
    }];
    UILabel *dikoulabel3 = UILabel.new;
    dikoulabel3.textAlignment = NSTextAlignmentLeft;
    dikoulabel3.textColor = RGB(153, 153, 153);
    dikoulabel3.font = [UIFont systemFontOfSize:9.0f];
    dikoulabel3.text = @")";
    [jifenView addSubview:dikoulabel3];
    [dikoulabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenlabel1.bottom).offset(8);
        make.left.equalTo(dikoulabel2.right).offset(2);
    }];
    
    
    UITextField *yueinput2 = UITextField.new;
    [yueinput2 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    yueinput2.layer.borderWidth = 0.5f;
    yueinput2.layer.borderColor = RGB(153, 153, 153).CGColor;
    yueinput2.layer.cornerRadius = 3.0f;
    yueinput2.leftViewMode=UITextFieldViewModeAlways;
    yueinput2.placeholder=@"";//默认显示的字
    yueinput2.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    yueinput2.returnKeyType=UIReturnKeyDone;//返回键的类型
    yueinput2.font = [UIFont systemFontOfSize:13.0f];
    yueinput2.textColor = RGB(67, 67, 67);
    yueinput2.delegate=self;//设置委托
    [jifenView addSubview:yueinput2];
    [yueinput2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(15);
        make.right.equalTo(jifenView.right).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *zhifu2 = UILabel.new;
    zhifu2.textAlignment = NSTextAlignmentLeft;
    zhifu2.textColor = RGB(153, 153, 153);
    zhifu2.font = [UIFont systemFontOfSize:13.0f];
    zhifu2.text = @"支付";
    [jifenView addSubview:zhifu2];
    [zhifu2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.top).offset(18);
        make.right.equalTo(yueinput2.left).offset(-10);
    }];
    
    UIView *lineView3 = UIView.new;
    lineView3.backgroundColor = RGB(240, 240, 240);
    [jifenView addSubview:lineView3];
    [lineView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.bottom).offset(-0.5);
        make.left.equalTo(jifenView.left).offset(0);
        make.right.equalTo(jifenView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    UIView *hongbaoView = UIView.new;
    hongbaoView.backgroundColor = [UIColor whiteColor];
    [feicashType addSubview:hongbaoView];
    [hongbaoView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(jifenView.bottom);
        make.left.equalTo(feicashType.left);
        make.right.equalTo(feicashType.right);
        make.height.mas_equalTo(65);
    }];
    
    UIButton *check5 = UIButton.new;
    [check5 setImage:[UIImage imageNamed:@"paycheckbox_unselect"] forState:UIControlStateNormal];
    [check5 setImage:[UIImage imageNamed:@"paycheckbox_select"] forState:UIControlStateSelected];
    [check5 addTarget:self action:@selector(check5) forControlEvents:UIControlEventTouchUpInside];
    check5.selected = NO;
    [hongbaoView addSubview:check5];
    [check5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(15);
        make.left.equalTo(hongbaoView.left).offset(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *hongbaolabel1 = UILabel.new;
    hongbaolabel1.textAlignment = NSTextAlignmentLeft;
    hongbaolabel1.textColor = RGB(11, 11, 11);
    hongbaolabel1.font = [UIFont systemFontOfSize:13.0f];
    hongbaolabel1.text = @"红包支付(";
    [hongbaoView addSubview:hongbaolabel1];
    [hongbaolabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(10);
        make.left.equalTo(check5.right).offset(10);
    }];
    UILabel *hongbaolabel2 = UILabel.new;
    hongbaolabel2.textAlignment = NSTextAlignmentLeft;
    hongbaolabel2.textColor = MAIN_COLOR;
    hongbaolabel2.font = [UIFont systemFontOfSize:13.0f];
    hongbaolabel2.text = @"199.87";
    [hongbaoView addSubview:hongbaolabel2];
    [hongbaolabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(10);
        make.left.equalTo(hongbaolabel1.right).offset(2);
    }];
    UILabel *hongbaolabel3 = UILabel.new;
    hongbaolabel3.textAlignment = NSTextAlignmentLeft;
    hongbaolabel3.textColor = RGB(11, 11, 11);
    hongbaolabel3.font = [UIFont systemFontOfSize:13.0f];
    hongbaolabel3.text = @")";
    [hongbaoView addSubview:hongbaolabel3];
    [hongbaolabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(10);
        make.left.equalTo(hongbaolabel2.right).offset(2);
    }];
    
    UILabel *zuilabel1 = UILabel.new;
    zuilabel1.textAlignment = NSTextAlignmentLeft;
    zuilabel1.textColor = RGB(153, 153, 153);
    zuilabel1.font = [UIFont systemFontOfSize:9.0f];
    zuilabel1.text = @"最多使用红包(";
    [hongbaoView addSubview:zuilabel1];
    [zuilabel1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaolabel1.bottom).offset(8);
        make.left.equalTo(check5.right).offset(10);
    }];
    UILabel *zuilabel2 = UILabel.new;
    zuilabel2.textAlignment = NSTextAlignmentLeft;
    zuilabel2.textColor = MAIN_COLOR;
    zuilabel2.font = [UIFont systemFontOfSize:9.0f];
    zuilabel2.text = @"10";
    [hongbaoView addSubview:zuilabel2];
    [zuilabel2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaolabel1.bottom).offset(8);
        make.left.equalTo(zuilabel1.right).offset(2);
    }];
    UILabel *zuilabel3 = UILabel.new;
    zuilabel3.textAlignment = NSTextAlignmentLeft;
    zuilabel3.textColor = RGB(153, 153, 153);
    zuilabel3.font = [UIFont systemFontOfSize:9.0f];
    zuilabel3.text = @"),抵扣(";
    [hongbaoView addSubview:zuilabel3];
    [zuilabel3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaolabel1.bottom).offset(8);
        make.left.equalTo(zuilabel2.right).offset(2);
    }];
    UILabel *zuilabel4 = UILabel.new;
    zuilabel4.textAlignment = NSTextAlignmentLeft;
    zuilabel4.textColor = MAIN_COLOR;
    zuilabel4.font = [UIFont systemFontOfSize:9.0f];
    zuilabel4.text = @"10";
    [hongbaoView addSubview:zuilabel4];
    [zuilabel4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaolabel1.bottom).offset(8);
        make.left.equalTo(zuilabel3.right).offset(2);
    }];
    UILabel *zuilabel5 = UILabel.new;
    zuilabel5.textAlignment = NSTextAlignmentLeft;
    zuilabel5.textColor = RGB(153, 153, 153);
    zuilabel5.font = [UIFont systemFontOfSize:9.0f];
    zuilabel5.text = @")";
    [hongbaoView addSubview:zuilabel5];
    [zuilabel5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaolabel1.bottom).offset(8);
        make.left.equalTo(zuilabel4.right).offset(2);
    }];
    
    
    UITextField *yueinput3 = UITextField.new;
    [yueinput3 setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    yueinput3.layer.borderWidth = 0.5f;
    yueinput3.layer.borderColor = RGB(153, 153, 153).CGColor;
    yueinput3.layer.cornerRadius = 3.0f;
    yueinput3.leftViewMode=UITextFieldViewModeAlways;
    yueinput3.placeholder=@"";//默认显示的字
    yueinput3.keyboardType=UIKeyboardTypeNumberPad;//设置键盘类型为默认的
    yueinput3.returnKeyType=UIReturnKeyDone;//返回键的类型
    yueinput3.font = [UIFont systemFontOfSize:13.0f];
    yueinput3.textColor = RGB(67, 67, 67);
    yueinput3.delegate=self;//设置委托
    [hongbaoView addSubview:yueinput3];
    [yueinput3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(15);
        make.right.equalTo(hongbaoView.right).offset(-10);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *zhifu3 = UILabel.new;
    zhifu3.textAlignment = NSTextAlignmentLeft;
    zhifu3.textColor = RGB(153, 153, 153);
    zhifu3.font = [UIFont systemFontOfSize:13.0f];
    zhifu3.text = @"支付";
    [hongbaoView addSubview:zhifu3];
    [zhifu3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.top).offset(18);
        make.right.equalTo(yueinput3.left).offset(-10);
    }];
    
    UIView *lineView4 = UIView.new;
    lineView4.backgroundColor = RGB(240, 240, 240);
    [hongbaoView addSubview:lineView4];
    [lineView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(hongbaoView.bottom);
        make.left.equalTo(hongbaoView.left).offset(0);
        make.right.equalTo(hongbaoView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    
    UIView *youhuiquanView = UIView.new;
    youhuiquanView.backgroundColor = [UIColor whiteColor];
    [container addSubview:youhuiquanView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goYouhuiyuan)];
    
    [youhuiquanView addGestureRecognizer:tapGesture];
    [youhuiquanView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feicashType.bottom).offset(10);
        make.left.equalTo(container.left);
        make.right.equalTo(container.right);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *youhuiquanl = UILabel.new;
    youhuiquanl.textAlignment = NSTextAlignmentLeft;
    youhuiquanl.textColor = RGB(11, 11, 11);
    youhuiquanl.font = [UIFont systemFontOfSize:13.0f];
    youhuiquanl.text = @"优惠券";
    [youhuiquanView addSubview:youhuiquanl];
    [youhuiquanl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youhuiquanView.top).offset(15);
        make.left.equalTo(youhuiquanView.left).offset(15);
    }];
    
    UILabel *youhuiquanl2 = UILabel.new;
    youhuiquanl2.textAlignment = NSTextAlignmentRight;
    youhuiquanl2.textColor = RGB(153, 153, 153);
    youhuiquanl2.font = [UIFont systemFontOfSize:13.0f];
    youhuiquanl2.text = @"选择优惠券";
    [youhuiquanView addSubview:youhuiquanl2];
    [youhuiquanl2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youhuiquanView.top).offset(15);
        make.right.equalTo(youhuiquanView.right).offset(-40);
    }];
    
    UIImageView *yhqarrow = UIImageView.new;
    [yhqarrow setImage:[UIImage imageNamed:@"arrow_r"]];
    [youhuiquanView addSubview:yhqarrow];
    [yhqarrow makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(youhuiquanView.top).offset(13);
        make.right.equalTo(youhuiquanView.right).offset(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    
    UIView *buttonView = UIView.new;
    buttonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttonView];
    [buttonView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.bottom).offset(-44);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44);
    }];
    UIView *lineView5 = UIView.new;
    lineView5.backgroundColor = RGB(240, 240, 240);
    [buttonView addSubview:lineView5];
    [lineView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.top);
        make.left.equalTo(buttonView.left).offset(0);
        make.right.equalTo(buttonView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    UILabel *yingful = UILabel.new;
    yingful.textAlignment = NSTextAlignmentLeft;
    yingful.textColor = RGB(153, 153, 153);
    yingful.font = [UIFont systemFontOfSize:13.0f];
    yingful.text = @"应付金额: ";
    [buttonView addSubview:yingful];
    [yingful makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.top).offset(15);
        make.left.equalTo(buttonView.left).offset(15);
    }];
    UILabel *yingfuv = UILabel.new;
    yingfuv.textAlignment = NSTextAlignmentLeft;
    yingfuv.textColor = MAIN_COLOR;
    yingfuv.font = [UIFont systemFontOfSize:13.0f];
    yingfuv.text = @"￥187.65";
    [buttonView addSubview:yingfuv];
    [yingfuv makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.top).offset(15);
        make.left.equalTo(yingful.right).offset(4);
    }];
    
    _payBtn = UIButton.new;
    _payBtn.backgroundColor = MAIN_COLOR;
    [_payBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_payBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    _payBtn.selected = NO;
    [buttonView addSubview:_payBtn];
    [_payBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonView.top);
        make.right.equalTo(buttonView.right);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(44);
    }];
    
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(youhuiquanView.bottom).offset(60);
//        make.height.mas_equalTo(2000);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goYouhuiyuan{
    
}

-(void)pay{
    
}

-(void)check1{
    
}

-(void)check2{
    
}

-(void)check3{
    
}

-(void)check4{
    
}

-(void)check5{
    
}
@end
