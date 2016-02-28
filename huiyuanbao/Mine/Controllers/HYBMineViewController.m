//
//  HYBMineViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBMineViewController.h"
#import "RDVTabBarController.h"
#import "masonry.h"
#import "ZButton.h"
#import "HYBSetPasswordViewController.h"

@interface HYBMineViewController ()

@end

@implementation HYBMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.navigationBar.title = @"我的";
    self.view.backgroundColor = RGB(240, 240, 240);
    // Do any additional setup after loading the view.
    
    [self addRightNavigatorButton];
    [self addLeftNavigatorButton];
    
    UIView *baseInfo = UIView.new;
    baseInfo.backgroundColor = MAIN_COLOR;
    [self.view addSubview:baseInfo];
    [baseInfo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(0);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.height.mas_equalTo(142);
    }];
    
    UIImageView *avater = UIImageView.new;
    [avater setImage:[UIImage imageNamed:@"store_default"]];
    avater.layer.cornerRadius = 30.0f;
    avater.layer.borderWidth = 1.0f;
    avater.layer.borderColor = [RGB(255, 255, 255) CGColor];
    avater.backgroundColor = [UIColor whiteColor];
    avater.layer.masksToBounds = YES;
    [baseInfo addSubview:avater];
    [avater makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseInfo.top).offset(8);
        make.left.equalTo(baseInfo.left).offset((width-60)/2);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *phoneLabel = UILabel.new;
    phoneLabel.textAlignment = NSTextAlignmentCenter;
    phoneLabel.textColor = RGB(255, 255, 255);
    phoneLabel.font = [UIFont systemFontOfSize:14.0f];
    phoneLabel.text = @"13236567035";
    [baseInfo addSubview:phoneLabel];
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avater.bottom).offset(10);
        make.left.equalTo(baseInfo.left);
        make.width.mas_equalTo(width);
    }];
    
    UIButton *editBtn = UIButton.new;
    [editBtn setBackgroundImage:[UIImage imageNamed:@"edit_avater"] forState:UIControlStateNormal];
    editBtn.titleLabel.font = [UIFont systemFontOfSize:9.0f];
    [editBtn setTitle:@"编辑头像" forState:UIControlStateNormal];
    [editBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editAvater) forControlEvents:UIControlEventTouchUpInside];
    [baseInfo addSubview:editBtn];
    [editBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.bottom).offset(12);
        make.left.equalTo(baseInfo.left).offset((width-60)/2);
        make.width.mas_equalTo(60);
    }];
    
    CGFloat l = (width-1)/3;
    
    UIButton *card = UIButton.new;
    [card addTarget:self action:@selector(card) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:card];
    card.backgroundColor = [UIColor whiteColor];
    [card makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseInfo.bottom);
        make.left.equalTo(self.view.left);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *cardView = UIImageView.new;
    [cardView setImage:[UIImage imageNamed:@"card"]];
    [card addSubview:cardView];
    [cardView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(card.top).offset(10);
        make.left.equalTo(card.left).offset((l-50)/2);
    }];
    
    UILabel *cardLabel = UILabel.new;
    cardLabel.textAlignment = NSTextAlignmentCenter;
    cardLabel.textColor = RGB(51, 51, 51);
    cardLabel.font = [UIFont systemFontOfSize:14.0f];
    cardLabel.text = @"卡包";
    [card addSubview:cardLabel];
    [cardLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView.bottom).offset(15);
        make.left.equalTo(card.left);
        make.width.mas_equalTo(l);
    }];
    
    UIButton *quan = UIButton.new;
    [quan addTarget:self action:@selector(quan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:quan];
    quan.backgroundColor = [UIColor whiteColor];
    [quan makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseInfo.bottom);
        make.left.equalTo(self.view.left).offset(l+0.5);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *quanView = UIImageView.new;
    [quanView setImage:[UIImage imageNamed:@"quan"]];
    [quan addSubview:quanView];
    [quanView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quan.top).offset(10);
        make.left.equalTo(quan.left).offset((l-50)/2);
    }];
    
    UILabel *quanLabel = UILabel.new;
    quanLabel.textAlignment = NSTextAlignmentCenter;
    quanLabel.textColor = RGB(51, 51, 51);
    quanLabel.font = [UIFont systemFontOfSize:14.0f];
    quanLabel.text = @"优惠券";
    [quan addSubview:quanLabel];
    [quanLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quanView.bottom).offset(15);
        make.left.equalTo(quan.left);
        make.width.mas_equalTo(l);
    }];
    
    UIButton *msg = UIButton.new;
    [msg addTarget:self action:@selector(msg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msg];
    msg.backgroundColor = [UIColor whiteColor];
    [msg makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseInfo.bottom);
        make.left.equalTo(self.view.left).offset(2*l+1);
        make.width.mas_equalTo(l);
        make.height.mas_equalTo(l);
    }];
    
    UIImageView *msgView = UIImageView.new;
    [msgView setImage:[UIImage imageNamed:@"msg"]];
    [msg addSubview:msgView];
    [msgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(msg.top).offset(10);
        make.left.equalTo(msg.left).offset((l-50)/2);
    }];
    
    UILabel *msgLabel = UILabel.new;
    msgLabel.textAlignment = NSTextAlignmentCenter;
    msgLabel.textColor = RGB(51, 51, 51);
    msgLabel.font = [UIFont systemFontOfSize:14.0f];
    msgLabel.text = @"优惠券";
    [msg addSubview:msgLabel];
    [msgLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(msgView.bottom).offset(15);
        make.left.equalTo(msg.left);
        make.width.mas_equalTo(l);
    }];
    
    CGFloat top = self.navigationBarHeight+142+l;
    
    UIScrollView *scrollView = UIScrollView.new;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(top,0,0,0));
    }];
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView.width);
    }];
    
    UIView *superview = container;
    int topHeight = 200;
    int bottomHeight = 150;
    
    UIView *topView = UIView.new;
    topView.backgroundColor = [UIColor whiteColor];
    [container addSubview:topView];
    [topView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.top).offset(8);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(topHeight);
    }];
    
    UIView *bottomView = UIView.new;
    bottomView.backgroundColor = [UIColor whiteColor];
    [container addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.bottom).offset(8);
        make.left.equalTo(superview.left);
        make.right.equalTo(superview.right);
        make.height.mas_equalTo(bottomHeight);
    }];
    
    // 菜单 预订记录 消费记录 充值记录 积分记录
    UIView *view1 = UIView.new;
    UITapGestureRecognizer* singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(orderRecords)];
    [view1 addGestureRecognizer:singleTap1];
    [topView addSubview:view1];
    [view1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.top);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(topHeight/4);
    }];
    UIView *view2 = UIView.new;
    UITapGestureRecognizer* singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiaofeiRecords)];
    [view2 addGestureRecognizer:singleTap2];
    [topView addSubview:view2];
    [view2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(topHeight/4);
    }];
    UIView *view3 = UIView.new;
    UITapGestureRecognizer* singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chargeRecords)];
    [view3 addGestureRecognizer:singleTap3];
    [topView addSubview:view3];
    [view3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(topHeight/4);
    }];
    UIView *view4 = UIView.new;
    UITapGestureRecognizer* singleTap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scoreRecords)];
    [view4 addGestureRecognizer:singleTap4];
    [topView addSubview:view4];
    [view4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(topHeight/4);
    }];
    
    UIView *hLineView1 = UIView.new;
    hLineView1.backgroundColor = RGB(201, 201, 201);
    [topView addSubview:hLineView1];
    UIView *hLineView2 = UIView.new;
    hLineView2.backgroundColor = RGB(201, 201, 201);
    [topView addSubview:hLineView2];
    UIView *hLineView3 = UIView.new;
    hLineView3.backgroundColor = RGB(201, 201, 201);
    [topView addSubview:hLineView3];
    
    [hLineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(0.5);
    }];
    [hLineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(0.5);
    }];
    [hLineView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.bottom);
        make.left.equalTo(topView.left);
        make.right.equalTo(topView.right);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *imageView1 = UIImageView.new;
    imageView1.image = [UIImage imageNamed:@"order_record"];
    [view1 addSubview:imageView1];
    UIImageView *imageView2 = UIImageView.new;
    imageView2.image = [UIImage imageNamed:@"xiaofei_record"];
    [view2 addSubview:imageView2];
    UIImageView *imageView3 = UIImageView.new;
    imageView3.image = [UIImage imageNamed:@"charge_record"];
    [view3 addSubview:imageView3];
    UIImageView *imageView4 = UIImageView.new;
    imageView4.image = [UIImage imageNamed:@"score_record"];
    [view4 addSubview:imageView4];
    
    [imageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.top).offset((topHeight/4-30)/2);
        make.left.equalTo(view1.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [imageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.top).offset((topHeight/4-30)/2);
        make.left.equalTo(view2.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [imageView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.top).offset((topHeight/4-30)/2);
        make.left.equalTo(view3.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [imageView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.top).offset((topHeight/4-30)/2);
        make.left.equalTo(view4.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *label1 = UILabel.new;
    label1.textAlignment = NSTextAlignmentLeft;
    label1.text = @"预订记录";
    label1.textColor = RGB(51, 51, 51);
    label1.font = [UIFont systemFontOfSize:15.0f];
    [view1 addSubview:label1];
    UILabel *label2 = UILabel.new;
    label2.textAlignment = NSTextAlignmentLeft;
    label2.text = @"消费记录";
    label2.textColor = RGB(51, 51, 51);
    label2.font = [UIFont systemFontOfSize:15.0f];
    [view2 addSubview:label2];
    UILabel *label3 = UILabel.new;
    label3.textAlignment = NSTextAlignmentLeft;
    label3.text = @"充值记录";
    label3.textColor = RGB(51, 51, 51);
    label3.font = [UIFont systemFontOfSize:15.0f];
    [view1 addSubview:label3];
    UILabel *label4 = UILabel.new;
    label4.textAlignment = NSTextAlignmentLeft;
    label4.text = @"积分记录";
    label4.textColor = RGB(51, 51, 51);
    label4.font = [UIFont systemFontOfSize:15.0f];
    [view4 addSubview:label4];
    
    [label1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.top).offset((topHeight/4-20)/2);
        make.left.equalTo(imageView1.right).offset(20);
    }];
    [label2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.top).offset((topHeight/4-20)/2);
        make.left.equalTo(imageView2.right).offset(20);
    }];
    [label3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.top).offset((topHeight/4-20)/2);
        make.left.equalTo(imageView3.right).offset(20);
    }];
    [label4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.top).offset((topHeight/4-20)/2);
        make.left.equalTo(imageView4.right).offset(20);
    }];
    
    UIImageView *aimageView1 = UIImageView.new;
    aimageView1.image = [UIImage imageNamed:@"arrow_r"];
    [view1 addSubview:aimageView1];
    UIImageView *aimageView2 = UIImageView.new;
    aimageView2.image = [UIImage imageNamed:@"arrow_r"];
    [view3 addSubview:aimageView2];
    UIImageView *aimageView3 = UIImageView.new;
    aimageView3.image = [UIImage imageNamed:@"arrow_r"];
    [view3 addSubview:aimageView3];
    UIImageView *aimageView4 = UIImageView.new;
    aimageView4.image = [UIImage imageNamed:@"arrow_r"];
    [view4 addSubview:aimageView4];
    
    [aimageView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.top).offset((topHeight/4-20)/2);
        make.right.equalTo(view1.right).offset(-15);
    }];
    [aimageView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.top).offset((topHeight/4-20)/2);
        make.right.equalTo(view2.right).offset(-15);
    }];
    [aimageView3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.top).offset((topHeight/4-20)/2);
        make.right.equalTo(view3.right).offset(-15);
    }];
    [aimageView4 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view4.top).offset((topHeight/4-20)/2);
        make.right.equalTo(view4.right).offset(-15);
    }];
    
    
    // 菜单 设置支付密码 在线客服 意见反馈
    UIView *view5 = UIView.new;
    UITapGestureRecognizer* singleTap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setPassword)];
    [view5 addGestureRecognizer:singleTap5];
    [bottomView addSubview:view5];
    [view5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.top);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(bottomHeight/3);
    }];
    UIView *view6 = UIView.new;
    UITapGestureRecognizer* singleTap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kefu)];
    [view6 addGestureRecognizer:singleTap6];
    [bottomView addSubview:view6];
    [view6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(bottomHeight/3);
    }];
    UIView *view7 = UIView.new;
    UITapGestureRecognizer* singleTap7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedback)];
    [view7 addGestureRecognizer:singleTap7];
    [bottomView addSubview:view7];
    [view7 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(bottomHeight/3);
    }];
    
    UIView *hLineView5 = UIView.new;
    hLineView5.backgroundColor = RGB(201, 201, 201);
    [bottomView addSubview:hLineView5];
    UIView *hLineView6 = UIView.new;
    hLineView6.backgroundColor = RGB(201, 201, 201);
    [bottomView addSubview:hLineView6];
    UIView *hLineView7 = UIView.new;
    hLineView7.backgroundColor = RGB(201, 201, 201);
    [bottomView addSubview:hLineView7];
    
    [hLineView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(0.5);
    }];
    [hLineView6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(0.5);
    }];
    [hLineView7 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view7.bottom);
        make.left.equalTo(bottomView.left);
        make.right.equalTo(bottomView.right);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *imageView5 = UIImageView.new;
    imageView5.image = [UIImage imageNamed:@"password"];
    [view5 addSubview:imageView5];
    UIImageView *imageView6 = UIImageView.new;
    imageView6.image = [UIImage imageNamed:@"kefu"];
    [view6 addSubview:imageView6];
    UIImageView *imageView7 = UIImageView.new;
    imageView7.image = [UIImage imageNamed:@"feedback"];
    [view7 addSubview:imageView7];
    
    [imageView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.top).offset((bottomHeight/3-30)/2);
        make.left.equalTo(view5.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [imageView6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.top).offset((bottomHeight/3-30)/2);
        make.left.equalTo(view6.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [imageView7 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view7.top).offset((bottomHeight/3-30)/2);
        make.left.equalTo(view7.left).offset(13);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *label5 = UILabel.new;
    label5.textAlignment = NSTextAlignmentLeft;
    label5.text = @"设置支付密码";
    label5.textColor = RGB(51, 51, 51);
    label5.font = [UIFont systemFontOfSize:15.0f];
    [view5 addSubview:label5];
    UILabel *label6 = UILabel.new;
    label6.textAlignment = NSTextAlignmentLeft;
    label6.text = @"在线客服";
    label6.textColor = RGB(51, 51, 51);
    label6.font = [UIFont systemFontOfSize:15.0f];
    [view6 addSubview:label6];
    UILabel *label7 = UILabel.new;
    label7.textAlignment = NSTextAlignmentLeft;
    label7.text = @"意见反馈";
    label7.textColor = RGB(51, 51, 51);
    label7.font = [UIFont systemFontOfSize:15.0f];
    [view7 addSubview:label7];
    
    [label5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.top).offset((bottomHeight/3-20)/2);
        make.left.equalTo(imageView5.right).offset(20);
    }];
    [label6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.top).offset((bottomHeight/3-20)/2);
        make.left.equalTo(imageView6.right).offset(20);
    }];
    [label7 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view7.top).offset((bottomHeight/3-20)/2);
        make.left.equalTo(imageView7.right).offset(20);
    }];
    
    UIImageView *aimageView5 = UIImageView.new;
    aimageView5.image = [UIImage imageNamed:@"arrow_r"];
    [view5 addSubview:aimageView5];
    UIImageView *aimageView6 = UIImageView.new;
    aimageView6.image = [UIImage imageNamed:@"arrow_r"];
    [view6 addSubview:aimageView6];
    UIImageView *aimageView7 = UIImageView.new;
    aimageView7.image = [UIImage imageNamed:@"arrow_r"];
    [view7 addSubview:aimageView7];
    
    [aimageView5 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view5.top).offset((bottomHeight/3-20)/2);
        make.right.equalTo(view5.right).offset(-15);
    }];
    [aimageView6 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view6.top).offset((bottomHeight/3-20)/2);
        make.right.equalTo(view6.right).offset(-15);
    }];
    [aimageView7 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view7.top).offset((bottomHeight/3-20)/2);
        make.right.equalTo(view7.right).offset(-15);
    }];
    
    UIButton *btn = UIButton.new;
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    btn.layer.cornerRadius = 5.0f;
    [btn setTitle:@"退出系统" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(logouts) forControlEvents:UIControlEventTouchUpInside];
    [container addSubview:btn];
    btn.backgroundColor = MAIN_COLOR;
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.bottom).offset(13);
        make.left.equalTo(container.left).offset(13);
        make.right.equalTo(container.right).offset(-13);
        make.height.mas_equalTo(44);
    }];
    
    [container makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view7.bottom).offset(70);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightNavigatorButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 48, 10, 48, 32)];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateHighlighted];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(2, 14, 5, 9)];
    [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar setRightButton:rightButton];}

- (void)addLeftNavigatorButton
{
    ZButton *leftButton=[[ZButton alloc ] initWithFrame : CGRectMake (0, 31, 100, 44)];
    [leftButton setTitle : @"南京" forState : UIControlStateNormal];
    [leftButton setImage :[ UIImage imageNamed:@"city_arrow"] forState : UIControlStateNormal];
    [leftButton setTitleColor :RGB(255, 255, 255) forState : UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationBar addSubview :rightButton];
    [self.navigationBar setLeftButton:leftButton];
}

- (void)leftButtonTapped:(id)sender
{
    //TODO
}

- (void)rightButtonTapped:(id)sender
{
    //TODO
}

- (void)editAvater{
    
}

-(void)card{
    
}

-(void)quan{
    
}

-(void)msg{
    
}

-(void)orderRecords{
    
}

-(void)xiaofeiRecords{
    
}

-(void)chargeRecords{
    
}

-(void)scoreRecords{
    
}

-(void)setPassword{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBSetPasswordViewController *pushController = [[HYBSetPasswordViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)kefu{
    
}

-(void)feedback{
    
}

-(void)logouts{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    //    [self refreshData];
}

@end
