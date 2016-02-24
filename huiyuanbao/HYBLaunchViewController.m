//
//  HYBLaunchViewController.m
//  haidaowan
//
//  Created by zhouhai on 15/12/30.
//  Copyright © 2015年 haidaowan. All rights reserved.
//

#import "HYBLaunchViewController.h"
#import "HYBSplashViewController.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBLaunchViewController ()<UIScrollViewDelegate>
@property(nonatomic, assign) BOOL isOut;
@property(nonatomic, strong) UIScrollView *scrollView;
@end

@implementation HYBLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _isOut = NO;
    [self makeLaunchView];
//    NSArray *arr = [[UIApplication sharedApplication] windows];
//    UIWindow *mainWindow = [arr objectAtIndex:0];
//    [mainWindow setRootViewController: self.navigationController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)makeLaunchView{
    NSArray *arr=[NSArray arrayWithObjects:@"boot1",@"boot2",@"boot3",nil];//数组内存放的是我要显示的假引导页面图片
    //通过scrollView 将这些图片添加在上面，从而达到滚动这些图片
    _scrollView=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize=CGSizeMake(320*arr.count, self.view.frame.size.height);
    _scrollView.pagingEnabled=YES;
    _scrollView.tag=7000;
    _scrollView.delegate=self;
    [self.view addSubview:_scrollView];
    for (int i=0; i<arr.count; i++) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*320, 0, 320, self.view.frame.size.height)];
        img.image=[UIImage imageNamed:arr[i]];
        if(i==2){
            [img setUserInteractionEnabled:YES];
            UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoMain)];
            [img addGestureRecognizer:singleTap];
        }
        [_scrollView addSubview:img];
    }
}
#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑了30 的时候就做下一个动作
    if (scrollView.contentOffset.x>2*width+30) {
        
        _isOut=YES;
        
    }
}
//停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断isout为真 就要进入主界面了
    if (_isOut) {
        [self gotoMain];//进入主界面
    }
    
}

- (void) gotoMain{
    [UIView animateWithDuration:0.5 animations:^{
        _scrollView.alpha=0;//让scrollview 渐变消失
        
    }completion:^(BOOL finished) {
        [_scrollView  removeFromSuperview];//将scrollView移除
        [GVUserDefaults standardUserDefaults].isFirst = @"NO";
        HYBSplashViewController *splashViewController = [[HYBSplashViewController alloc] init];
        NSArray *arr = [[UIApplication sharedApplication] windows];
        UIWindow *mainWindow = [arr objectAtIndex:0];
        [mainWindow setRootViewController: splashViewController];
        
    } ];
    
}


@end
