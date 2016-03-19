//
//  HYBOrderDetailViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBOrderDetailViewController.h"
#import "masonry.h"
#import "HYBOrderRecord.h"
#import "HYBPayViewController.h"

@interface HYBOrderDetailViewController ()
@property (nonatomic, strong) UIButton *payBtn;
@property (nonatomic, strong) HYBOrderRecord *order;
@end

@implementation HYBOrderDetailViewController
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
    [self.view addSubview: title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
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
    [self.view addSubview:form];
    [form makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
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
    orderName.text = @"订单名称";
    [infoView addSubview:orderName];
    [orderName makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoView.top).offset(15);
        make.left.equalTo(infoView.left).offset(15);
    }];
    
    UILabel *orderNameValue = UILabel.new;
    orderNameValue.textAlignment = NSTextAlignmentRight;
    orderNameValue.textColor = RGB(153, 153, 153);
    orderNameValue.font = [UIFont systemFontOfSize:15.0f];
    orderNameValue.text = _order.product_name;//[NSString stringWithFormat:@"%@",@"牛肉水饺"];//@"￥89.00";
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
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *timeLabel = UILabel.new;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.textColor = RGB(153, 153, 153);
    timeLabel.font = [UIFont systemFontOfSize:15.0f];
    timeLabel.text = @"预订时间";
    [timeView addSubview:timeLabel];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeView.top).offset(15);
        make.left.equalTo(timeView.left).offset(15);
    }];
    
    UILabel *timeValue = UILabel.new;
    timeValue.textAlignment = NSTextAlignmentRight;
    timeValue.textColor = RGB(153, 153, 153);
    timeValue.font = [UIFont systemFontOfSize:15.0f];
    timeValue.text = _order.reserve_time;//[NSString stringWithFormat:@"%@",@"2016-03-19 17:20"];//@"￥89.00";
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
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *orderNoLabel = UILabel.new;
    orderNoLabel.textAlignment = NSTextAlignmentLeft;
    orderNoLabel.textColor = RGB(153, 153, 153);
    orderNoLabel.font = [UIFont systemFontOfSize:15.0f];
    orderNoLabel.text = @"订单号";
    [orderNo addSubview:orderNoLabel];
    [orderNoLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderNo.top).offset(15);
        make.left.equalTo(orderNo.left).offset(15);
    }];
    
    UILabel *orderNoValue = UILabel.new;
    orderNoValue.textAlignment = NSTextAlignmentRight;
    orderNoValue.textColor = RGB(153, 153, 153);
    orderNoValue.font = [UIFont systemFontOfSize:15.0f];
    orderNoValue.text = _order.orderid;//[NSString stringWithFormat:@"%@",@"201312312213132"];//@"￥89.00";
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
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44.0f);
    }];
    
    UILabel *orderTimeLabel = UILabel.new;
    orderTimeLabel.textAlignment = NSTextAlignmentLeft;
    orderTimeLabel.textColor = RGB(153, 153, 153);
    orderTimeLabel.font = [UIFont systemFontOfSize:15.0f];
    orderTimeLabel.text = @"下单时间";
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
    
    
    UIView *title2 = UIView.new;
    title2.backgroundColor = RGB(235,235,235);
    [self.view addSubview: title2];
    [title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(form.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title2 = UILabel.new;
    t_title2.textAlignment = NSTextAlignmentCenter;
    t_title2.textColor = RGB(136, 136, 136);
    t_title2.font = [UIFont systemFontOfSize:14.0f];
    t_title2.text = @"商家信息";
    [title2 addSubview:t_title2];
    [t_title2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title2.top).offset(7);
        make.left.equalTo(title2.left).offset(15);
    }];
    
    UIView *firstView = UIView.new;
    firstView.backgroundColor = RGB(240, 240, 240);
    firstView.layer.masksToBounds = YES;
    [self.view addSubview:firstView];
    
    [firstView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(t_title2.bottom);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.bottom.equalTo(superview.bottom).offset(-10);
    }];
    
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = [UIColor whiteColor];
    [firstView addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.top).offset(0);
        make.left.equalTo(firstView.left).offset(0);
        make.right.equalTo(firstView.right).offset(0);
        make.bottom.equalTo(firstView.bottom).offset(0);
    }];
    
    UIImageView *storeImageView = UIImageView.new;
    UIImage *storeImg = [UIImage imageNamed:@"store_default"];
    [storeImageView setImage:storeImg];
//    if(_storeBaseInfo.merchant_img && ![_storeBaseInfo.merchant_img isEqualToString:@""]){
//        [[CXImageLoader sharedImageLoader] loadImageForURL:[NSURL URLWithString:[IMG_PREFIX stringByAppendingString:_storeBaseInfo.merchant_img]] image:^(UIImage *image, NSError *error) {
//            storeImageView.image = image;
//        }];
//    }
    [bottomView addSubview:storeImageView];
    [storeImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding);
        make.left.equalTo(bottomView.left).offset(padding);
        make.width.mas_equalTo(83);
        make.height.mas_equalTo(83);
    }];
    
    
    UILabel *storeTitle = UILabel.new;
    storeTitle.textAlignment = NSTextAlignmentLeft;
    storeTitle.textColor = RGB(51, 51, 51);
    storeTitle.font = [UIFont systemFontOfSize:14.0f];
    storeTitle.text = _order.merchant_name;//@"猫空咖啡(时代广场店)";
    [bottomView addSubview:storeTitle];
    [storeTitle makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding+2);
        make.left.equalTo(storeImageView.right).offset(15);
    }];
    
    
    UIImageView *RMBicon = UIImageView.new;
    UIImage *rmb = [UIImage imageNamed:@"store"];
    [RMBicon setImage:rmb];
    [bottomView addSubview:RMBicon];
    [RMBicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding+2);
        make.left.equalTo(storeTitle.right).offset(4);
    }];
    
    UIImageView *vipicon = UIImageView.new;
    UIImage *vip = [UIImage imageNamed:@"vip"];
    [vipicon setImage:vip];
    [bottomView addSubview:vipicon];
    [vipicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top).offset(padding);
        make.left.equalTo(RMBicon.right).offset(4);
    }];
    
    UIView *ratingView = UIView.new;
    [bottomView addSubview:ratingView];
    [ratingView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(22);
        make.left.equalTo(storeImageView.right).offset(15);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(14);
    }];
    for (int i=0; i<5; i++) {
        UIImageView *star = UIImageView.new;
        if(i<4){
            [star setImage:[UIImage imageNamed:@"star"]];
            [ratingView addSubview:star];
        }else{
            [star setImage:[UIImage imageNamed:@"star_gray"]];
            [ratingView addSubview:star];
        }
        [star makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ratingView.top).offset(0);
            make.left.mas_equalTo(i*14+3*i);
        }];
    }
    
    UILabel *score = UILabel.new;
    score.textAlignment = NSTextAlignmentLeft;
    score.textColor = RGB(250, 155, 59);
    score.font = [UIFont systemFontOfSize:12.0f];
    score.text = @"4.0分";
    [bottomView addSubview:score];
    [score makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTitle.bottom).offset(22);
        make.left.equalTo(ratingView.right).offset(5);
    }];
    
    
    UILabel *info1 = UILabel.new;
    info1.textAlignment = NSTextAlignmentLeft;
    info1.textColor = MAIN_COLOR;
    info1.font = [UIFont systemFontOfSize:11.0f];
    info1.text = _order.discount;//@"0.5";
    [bottomView addSubview:info1];
    [info1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingView.bottom).offset(20);
        make.left.equalTo(storeImageView.right).offset(15);
    }];
    
    UILabel *info2 = UILabel.new;
    info2.textAlignment = NSTextAlignmentLeft;
    info2.textColor = RGB(204, 204, 204);
    info2.font = [UIFont systemFontOfSize:11.0f];
    info2.text = @"折起";
    [bottomView addSubview:info2];
    [info2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingView.bottom).offset(20);
        make.left.equalTo(info1.right).offset(0);
    }];
    
    
    UIView *lineView = UIView.new;
    lineView.backgroundColor = RGB(240, 240, 240);
    [bottomView addSubview:lineView];
    [lineView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeImageView.bottom).offset(8);
        make.left.equalTo(bottomView.left).offset(0);
        make.right.equalTo(bottomView.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *zhuyingview = UIView.new;
    zhuyingview.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:zhuyingview];
    [zhuyingview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *zhuying = UILabel.new;
    zhuying.textAlignment = NSTextAlignmentLeft;
    zhuying.textColor = RGB(102, 102, 102);
    zhuying.font = [UIFont systemFontOfSize:12.0f];
    zhuying.text = [NSString stringWithFormat:@"联系方式:%@",_order.merchant_phone]; //@"";
    [zhuyingview addSubview:zhuying];
    [zhuying makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhuyingview.top).offset(15);
        make.left.equalTo(zhuyingview.left).offset(15);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = RGB(240, 240, 240);
    [zhuyingview addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(zhuyingview.bottom).offset(-0.5);
        make.left.equalTo(zhuyingview.left).offset(0);
        make.right.equalTo(zhuyingview.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UIView *addressview = UIView.new;
    addressview.backgroundColor = [UIColor whiteColor];
    [bottomView addSubview:addressview];
    [addressview makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *address = UILabel.new;
    address.textAlignment = NSTextAlignmentLeft;
    address.textColor = RGB(102, 102, 102);
    address.font = [UIFont systemFontOfSize:12.0f];
    address.text = [NSString stringWithFormat:@"地址: %@",_order.merchant_adress];//@"地址: 南京市鼓楼区丰台南路129号";
    [addressview addSubview:address];
    [address makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.top).offset(15);
        make.left.equalTo(addressview.left).offset(15);
    }];
    
    UIImageView *loc = UIImageView.new;
    [loc setImage:[UIImage imageNamed:@"d_loc"]];
    [addressview addSubview:loc];
    [loc makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.top).offset(12);
        make.right.equalTo(addressview.right).offset(-15);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView3 = UIView.new;
    lineView3.backgroundColor = RGB(240, 240, 240);
    [zhuyingview addSubview:lineView3];
    [lineView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressview.bottom).offset(-0.5);
        make.left.equalTo(addressview.left).offset(0);
        make.right.equalTo(addressview.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];

    
    
    _payBtn = UIButton.new;
    _payBtn.backgroundColor = MAIN_COLOR;
    [_payBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_payBtn setTitle:@"支付定金" forState:UIControlStateNormal];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [_payBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    _payBtn.selected = NO;
    [self.view addSubview:_payBtn];
    [_payBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.bottom).offset(-44);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(44);
    }];
    
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lineView3.bottom);
    }];
    
//    self.joinmerchant = [[HYBJoinMerchant alloc] initWithBaseURL:HYB_API_BASE_URL path:JOIN_SHOP cachePolicyType:kCachePolicyTypeNone];
//    
//    [self.joinmerchant addObserver:self
//                        forKeyPath:kResourceLoadingStatusKeyPath
//                           options:NSKeyValueObservingOptionNew
//                           context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pay{
    HYBPayViewController *pushController = [[HYBPayViewController alloc] initWithOrder:_order];
    [self.navigationController pushViewController:pushController animated:YES];
}

@end
