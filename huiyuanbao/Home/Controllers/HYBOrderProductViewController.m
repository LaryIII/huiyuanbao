//
//  HYBOrderProductViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBOrderProductViewController.h"
#import "masonry.h"
#import "HYBOrderProduct.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBStoreProduct.h"
#import "HYBStore.h"

@interface HYBOrderProductViewController ()
@property (nonatomic, strong) UIButton *orderBtn;

@property (nonatomic, strong) UIButton *minusBtn;
@property (nonatomic, strong) UIButton *numBtn;
@property (nonatomic, strong) UIButton *plusBtn;
@property (nonatomic, strong) UIButton *arrowBtn;

@property (nonatomic, strong) UILabel *timeValue;
@property (nonatomic, strong) UITextView *remark;

@property (nonatomic, assign) int num;

@property (nonatomic, strong) UIDatePicker *datePicker;

@property (nonatomic, strong) HYBOrderProduct *orderproduct;

@property (nonatomic, strong) HYBStoreProduct *product;
@property (nonatomic, strong) HYBStore *store;
@end

@implementation HYBOrderProductViewController
- (void) dealloc{
    [_orderproduct removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (instancetype)initWithProduct:(HYBStoreProduct *)product withStore:(HYBStore *)store {
    self = [super init];
    if (self) {
        self.product = product;
        self.store = store;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _num = 1;
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.navigationBar.title = @"提交订单";
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
        make.height.mas_equalTo(44*5);
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
    
    UILabel *productName = UILabel.new;
    productName.textAlignment = NSTextAlignmentLeft;
    productName.textColor = RGB(51, 51, 51);
    productName.font = [UIFont systemFontOfSize:16.0f];
    productName.text = _product.productName;//@"一品牛腩煲";
    [infoView addSubview:productName];
    [productName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.left.equalTo(infoView.left).offset(15);
    }];
    
    UILabel *price = UILabel.new;
    price.textAlignment = NSTextAlignmentLeft;
    price.textColor = MAIN_COLOR;
    price.font = [UIFont systemFontOfSize:18.0f];
    price.text = [NSString stringWithFormat:@"%@",_product.productPrice];//@"￥89.00";
    [infoView addSubview:price];
    [price makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.right.equalTo(infoView.right).offset(-15);
    }];
    
    UIView *lineview = UIView.new;
    lineview.backgroundColor = RGB(243, 183, 179);
    [infoView addSubview:lineview];
    [lineview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.bottom);
        make.left.equalTo(infoView.left).offset(15);
        make.right.equalTo(infoView.right);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *numView = UIView.new;
    numView.backgroundColor = [UIColor whiteColor];
    [form addSubview:numView];
    [numView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *numLabel = UILabel.new;
    numLabel.textAlignment = NSTextAlignmentLeft;
    numLabel.textColor = RGB(153, 153, 153);
    numLabel.font = [UIFont systemFontOfSize:15.0f];
    numLabel.text = @"数量";
    [numView addSubview:numLabel];
    [numLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numView.top).offset(15);
        make.left.equalTo(numView.left).offset(15);
    }];
    
    UIView *numComponent = UIView.new;
    numComponent.backgroundColor = [UIColor whiteColor];
    [numView addSubview:numComponent];
    [numComponent makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numView.top).offset(6);
        make.right.equalTo(numView.right).offset(-15);
        make.width.mas_equalTo(108);
        make.height.mas_equalTo(30);
    }];
    
    _minusBtn = UIButton.new;
    _minusBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_minusBtn setImage:[UIImage imageNamed:@"minus_normal"] forState:UIControlStateNormal];
    [_minusBtn setImage:[UIImage imageNamed:@"minus_disabled"] forState:UIControlStateDisabled];
    [_minusBtn addTarget:self action:@selector(minus) forControlEvents:UIControlEventTouchUpInside];
    _minusBtn.enabled = NO;
    [numComponent addSubview:_minusBtn];
    [_minusBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numComponent.top);
        make.left.equalTo(numComponent.left);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(30);
    }];
    
    _numBtn = UIButton.new;
    _numBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [_numBtn setTitle:@"1" forState:UIControlStateNormal];
    [_numBtn setTitleColor:RGB(110, 110, 110) forState:UIControlStateNormal];
    [_numBtn setBackgroundImage:[UIImage imageNamed:@"num_area"] forState:UIControlStateNormal];
    [_numBtn setBackgroundImage:[UIImage imageNamed:@"num_area"] forState:UIControlStateDisabled];
    _numBtn.enabled = NO;
    [numComponent addSubview:_numBtn];
    [_numBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numComponent.top);
        make.left.equalTo(_minusBtn.right).offset(1);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(30);
    }];
    
     _plusBtn = UIButton.new;
     _plusBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
     [_plusBtn setImage:[UIImage imageNamed:@"plus_normal"] forState:UIControlStateNormal];
     [_plusBtn setImage:[UIImage imageNamed:@"plus_selected"] forState:UIControlStateDisabled];
     [_plusBtn addTarget:self action:@selector(plus) forControlEvents:UIControlEventTouchUpInside];
     _plusBtn.enabled = YES;
     [numComponent addSubview:_plusBtn];
     [_plusBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numComponent.top);
        make.left.equalTo(_numBtn.right).offset(1);
        make.width.mas_equalTo(33);
        make.height.mas_equalTo(30);
     }];
    
    UIView *timeView = UIView.new;
    timeView.backgroundColor = [UIColor whiteColor];
    [form addSubview:timeView];
    [timeView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(numView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *timeLabel = UILabel.new;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = RGB(153, 153, 153);
    timeLabel.font = [UIFont systemFontOfSize:15.0f];
    timeLabel.text = @"时间";
    [timeView addSubview:timeLabel];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(15);
        make.left.equalTo(timeView.left).offset(15);
    }];
    
    UIView *timeComponent = UIView.new;
    timeComponent.backgroundColor = [UIColor whiteColor];
    [timeView addSubview:timeComponent];
    [timeComponent makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(6);
        make.right.equalTo(timeView.right).offset(-15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
    
    _arrowBtn = UIButton.new;
    [_arrowBtn setImage:[UIImage imageNamed:@"filter_arrow"] forState:UIControlStateNormal];
    [_arrowBtn setImage:[UIImage imageNamed:@"filter_arrow"] forState:UIControlStateDisabled];
    [_arrowBtn addTarget:self action:@selector(selecttime) forControlEvents:UIControlEventTouchUpInside];
//    _arrowBtn.enabled = NO;
    [timeComponent addSubview:_arrowBtn];
    [_arrowBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeComponent.top).offset(11);
        make.right.equalTo(timeComponent.right);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    _timeValue = UILabel.new;
    _timeValue.textAlignment = NSTextAlignmentRight;
    _timeValue.textColor = RGB(153, 153, 153);
    _timeValue.font = [UIFont systemFontOfSize:15.0f];
    NSDate * date = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd k:mm";
    NSString * dateStr = [dateFormatter stringFromDate:date];
    _timeValue.text = dateStr;
    [timeComponent addSubview:_timeValue];
    [_timeValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(15);
        make.right.equalTo(_arrowBtn.left).offset(-4);
    }];
    
    
    UIView *remarkView = UIView.new;
    remarkView.backgroundColor = [UIColor whiteColor];
    [form addSubview:remarkView];
    [remarkView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *remarkLabel = UILabel.new;
    remarkLabel.textAlignment = NSTextAlignmentLeft;
    remarkLabel.textColor = RGB(153, 153, 153);
    remarkLabel.font = [UIFont systemFontOfSize:15.0f];
    remarkLabel.text = @"备注";
    [remarkView addSubview:remarkLabel];
    [remarkLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkView.top).offset(15);
        make.left.equalTo(numView.left).offset(15);
    }];
    
    _remark = UITextView.new;
    [remarkView addSubview:_remark];
    [_remark makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkView.top).offset(15);
        make.left.equalTo(remarkLabel.right).offset(15);
        make.right.equalTo(remarkView.right).offset(-15);
        make.height.mas_equalTo(68);
    }];
    
    _orderBtn = UIButton.new;
    _orderBtn.backgroundColor = MAIN_COLOR;
    _orderBtn.layer.cornerRadius = 5.0f;
    [_orderBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
    _orderBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_orderBtn addTarget:self action:@selector(order) forControlEvents:UIControlEventTouchUpInside];
//    _orderBtn.selected = NO;
    [self.view addSubview:_orderBtn];
    [_orderBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(form.bottom).offset(15);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    UIView *tips = UIView.new;
    tips.backgroundColor = [UIColor clearColor];
    [self.view addSubview:tips];
    [tips makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderBtn.bottom).offset(40);
        make.left.equalTo(superview.left).offset(15);
        make.right.equalTo(superview.right).offset(-15);
    }];
    UILabel *tipsTitle = UILabel.new;
    tipsTitle.textAlignment = NSTextAlignmentLeft;
    tipsTitle.textColor = RGB(102, 102, 102);
    tipsTitle.font = [UIFont systemFontOfSize:15.0f];
    tipsTitle.text = @"温馨提示";
    [tips addSubview:tipsTitle];
    [tipsTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips.top);
        make.left.equalTo(tips.left);
    }];
    
    UILabel *tips1 = UILabel.new;
    tips1.textAlignment = NSTextAlignmentLeft;
    tips1.textColor = RGB(153, 153, 153);
    tips1.font = [UIFont systemFontOfSize:12.0f];
    tips1.text = @"1.预订可在我的账户查看预订记录与退订";
    [tips addSubview:tips1];
    [tips1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsTitle.bottom).offset(6);
        make.left.equalTo(tips.left);
    }];
    
    UILabel *tips2 = UILabel.new;
    tips2.textAlignment = NSTextAlignmentLeft;
    tips2.textColor = RGB(153, 153, 153);
    tips2.font = [UIFont systemFontOfSize:12.0f];
    tips2.text = @"2.如不需要请及时退订";
    [tips addSubview:tips2];
    [tips2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tips1.bottom).offset(6);
        make.left.equalTo(tips.left);
    }];
    
    UIDatePicker *datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 162)];
    datePicker.datePickerMode=UIDatePickerModeDate;
    datePicker.date=[NSDate date];
    datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview: datePicker];
    self.datePicker=datePicker;
    
    [self.datePicker addTarget:self action:@selector(selectDate:) forControlEvents:      UIControlEventValueChanged];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    self.orderproduct = [[HYBOrderProduct alloc] initWithBaseURL:HYB_API_BASE_URL path:ORDER_PRODUCT cachePolicyType:kCachePolicyTypeNone];
    
    [self.orderproduct addObserver:self
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
        if (object == _orderproduct) {
            if (_orderproduct.isLoaded) {
                [self hideLoadingView];
                // 跳支付？
                
            }
            else if (_orderproduct.error) {
                [self showErrorMessage:[_orderproduct.error localizedFailureReason]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)minus{
    if(_minusBtn.enabled){
        _num--;
        _numBtn.titleLabel.text = [NSString stringWithFormat:@"%i",_num];
        if(_num==1){
            _minusBtn.enabled = NO;
        }
        if(_num<99){
            _plusBtn.enabled = YES;
        }
    }
}

-(void)plus{
    if(_plusBtn.enabled){
        _num++;
        _numBtn.titleLabel.text = [NSString stringWithFormat:@"%i",_num];
        if(_num==99){
            _plusBtn.enabled = NO;
        }
        if(_num>1){
            _minusBtn.enabled = YES;
        }
    }
}

-(void)selectDate:(id)sender
{
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd k:mm"];
    NSString *str=[outputFormatter stringFromDate:self.datePicker.date];
    _timeValue.text = str;
    
}

-(void)selecttime{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    _datePicker.center=CGPointMake(width/4, -44*6/2+self.navigationBarHeight+44+46);
    _datePicker.center = CGPointMake(width/2,height - 162/2);
    [UIView commitAnimations];
}

- (void)dismissDatePicker {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //    _datePicker.center=CGPointMake(width/4, -44*6/2+self.navigationBarHeight+44+46);
    _datePicker.center = CGPointMake(width/2,height+162/2);
    [UIView commitAnimations];
}

- (void)hideKeyBoard{
    [self.view endEditing:YES];
    [self dismissDatePicker];
}

-(void)order{
    [self showLoadingView];
    [self.orderproduct loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                        @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                        @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                        @"pkporduct":_product.pkproduct,//
                                                                                        @"pkmuser":_store.shopsid,//
                                                                                        @"orderTime":_timeValue.text,
                                                                                        @"orderCount":_numBtn.titleLabel.text,
                                                                                        @"remark":_remark.text,
                                                                                        @"productPrice":_product.vipPrice,
                                                                                        @"productTolprice":_product.productPrice,
                                                                                        @"discount":[_store.vipdiscount substringWithRange:NSMakeRange(0,1)],//@"5",//_store.vipdiscount,
                                                                                        @"isdefault":@"",
                                                                                        @"orderPrice":_product.vipPrice,
                                                                                        @"earnestmoney":_product.earnestmoney
                                                                                        }];
}
@end
