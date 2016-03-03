//
//  HYBXiaofeiRecordsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/3.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBXiaofeiRecordsViewController.h"
#import "masonry.h"

@interface HYBXiaofeiRecordsViewController ()
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;
@end

@implementation HYBXiaofeiRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"消费记录";
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
    [_btn1 setTitle:@"惠员包" forState:UIControlStateNormal];
    [_btn1 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn1 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(huiyuanbao) forControlEvents:UIControlEventTouchUpInside];
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
    [_btn2 setTitle:@"商户" forState:UIControlStateNormal];
    [_btn2 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn2 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn2 addTarget:self action:@selector(shanghu) forControlEvents:UIControlEventTouchUpInside];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)huiyuanbao{
    _scrollView1.hidden = NO;
    _scrollView2.hidden = YES;
    _btn1.selected = YES;
    _btn2.selected = NO;
}

-(void)shanghu{
    _scrollView1.hidden = YES;
    _scrollView2.hidden = NO;
    _btn1.selected = NO;
    _btn2.selected = YES;
}

@end
