//
//  HYBClazzViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBClazzViewController.h"
#import "ZButton.h"
#import "RDVTabBarController.h"
#import "HYBStore2.h"
#import "HYBStore2Cell.h"
#import "masonry.h"
#import "HYBStoreDetailViewController.h"
#import "HYBSelectCityViewController.h"
#import "HYBStore2List.h"
#import "HYBCategorys.h"
#import "HYBCategoryInfo.h"
#import "HYBCategoryInfo2.h"

@interface HYBClazzViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBStore2CellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIView *sortArea;
@property (nonatomic, assign) BOOL isSortAreaDisplay;
@property (nonatomic, strong) NSString *selectedSort;

@property (nonatomic, strong) UIView *searchBox;
@property (nonatomic, strong) UIView *filterbar;

@property (nonatomic, strong) UIScrollView *filterArea;
@property (nonatomic, strong) UIScrollView *level2menu;
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *container2;
@property (nonatomic, assign) BOOL isFilterAreaDisplay;

@property (nonatomic, strong) NSString *selectedFilter;

@property (nonatomic, strong) HYBStore2List *store2list;
@property (nonatomic, strong) HYBCategorys *categorys;
@end

@implementation HYBClazzViewController
- (void) dealloc{
    [_store2list removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_categorys removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"分类";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    [self addLeftNavigatorButton];
    
    UIView *searchBox = UIView.new;
    searchBox.backgroundColor = MAIN_COLOR;
    [self.view addSubview:searchBox];
    [searchBox makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(0);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.height.mas_equalTo(46);
    }];
    UIButton *searchBtn = UIButton.new;
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.cornerRadius = 5.0f;
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [searchBox addSubview:searchBtn];
    [searchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBox.top).offset(8);
        make.left.equalTo(searchBox.left).offset(8);
        make.right.equalTo(searchBox.right).offset(-8);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *searchicon = UIImageView.new;
    [searchicon setImage:[UIImage imageNamed:@"search"]];
    [searchBtn addSubview:searchicon];
    [searchicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.top).offset(8);
        make.left.equalTo(searchBtn.left).offset(8);
    }];
    
    UILabel *placeholder = UILabel.new;
    placeholder.textAlignment = NSTextAlignmentLeft;
    placeholder.textColor = RGB(102, 102, 102);
    placeholder.font = [UIFont systemFontOfSize:12.0f];
    placeholder.text = @"分类 / 商品 / 店铺";
    [searchBtn addSubview:placeholder];
    [placeholder makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.top).offset(8);
        make.left.equalTo(searchicon.right).offset(6);
    }];
    
    UIView *filterbar = UIView.new;
    filterbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filterbar];
    [filterbar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBox.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *btn1 = UIButton.new;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn1 setTitle:@"全部" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btn1.layer.borderColor = RGB(232, 232, 232).CGColor;
    btn1.layer.borderWidth = 0.5;
    [btn1 addTarget:self action:@selector(filters) forControlEvents:UIControlEventTouchUpInside];
    [filterbar addSubview:btn1];
    btn1.backgroundColor = [UIColor whiteColor];
    
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterbar.left);
        make.width.mas_equalTo(width/2);
        make.bottom.equalTo(filterbar.bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *arrow1 = UIImageView.new;
    [arrow1 setImage:[UIImage imageNamed:@"filter_arrow"]];
    [btn1 addSubview:arrow1];
    [arrow1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.top).offset(15);
        make.right.equalTo(btn1.right).offset(-8);
    }];

    UIButton *btn2 = UIButton.new;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn2 setTitle:@"智能排序" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btn2.layer.borderColor = RGB(232, 232, 232).CGColor;
    btn2.layer.borderWidth = 0.5;
    [btn2 addTarget:self action:@selector(sorts) forControlEvents:UIControlEventTouchUpInside];
    [filterbar addSubview:btn2];
    btn2.backgroundColor = [UIColor whiteColor];
    
    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.right);
        make.width.mas_equalTo(width/2);
        make.bottom.equalTo(filterbar.bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *arrow2 = UIImageView.new;
    [arrow2 setImage:[UIImage imageNamed:@"filter_arrow"]];
    [btn2 addSubview:arrow2];
    [arrow2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.top).offset(15);
        make.right.equalTo(btn2.right).offset(-8);
    }];
    
    
    UIView *lineView1 = UIView.new;
    lineView1.backgroundColor = RGB(204, 204, 204);
    [filterbar addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterbar.top);
        make.left.equalTo(filterbar.left).offset(width/2);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(44);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = RGB(204, 204, 204);
    [filterbar addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterbar.bottom).offset(-0.5);
        make.left.equalTo(filterbar.left).offset(0);
        make.right.equalTo(filterbar.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+46+44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-46-44) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBStore2Cell class] forCellWithReuseIdentifier:@"HYBStore2Cell"];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    NSMutableArray *storeList = [[NSMutableArray alloc] init];
//    HYBStore2 *store = HYBStore2.new;
//    [storeList addObject:store];
//    [self.dataArray[0] addObject:storeList];
    self.store2list = [[HYBStore2List alloc] initWithBaseURL:HYB_API_BASE_URL path:STORE_LIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.store2list addObserver:self
                      forKeyPath:kResourceLoadingStatusKeyPath
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    self.categorys = [[HYBCategorys alloc] initWithBaseURL:HYB_API_BASE_URL path:CATEGORY_INFO cachePolicyType:kCachePolicyTypeNone];
    
    [self.categorys addObserver:self
                      forKeyPath:kResourceLoadingStatusKeyPath
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    [self addSelectSort];
    [self addSelectFilter];
    [self.view bringSubviewToFront:self.navigationBar];
    [self.view bringSubviewToFront:searchBox];
    [self.view bringSubviewToFront:filterbar];
    
    
}

- (void) refreshData{
    [self showLoadingView];
    [self.categorys loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                          @"userId":@"",
                                                                                          @"phoneno":@"",
                                                                                          @"mtcode":@"320100"
                                                                                          }];
    
    [self.store2list loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                        @"userId":@"",
                                                                                        @"longitude":@"116.322886",
                                                                                        @"latitude":@"39.892176",
                                                                                        @"phoneno":@"",
                                                                                        @"pageLength":@"10",
                                                                                        @"current":@"0"
                                                                                        }];
}

#pragma mark Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
        if (object == _store2list) {
            if (_store2list.isLoaded) {
                [self hideLoadingView];
                [self.dataArray addObject:_store2list.stores];
                
                [_collectionView reloadData];
            }
            else if (_store2list.error) {
                [self showErrorMessage:[_store2list.error localizedFailureReason]];
            }
        }else if(object == _categorys){
            if (_categorys.isLoaded) {
                [self hideLoadingView];
                // TODO 添加筛选条件
                [self refreshSelectFilter];
            }
            else if (_categorys.error) {
                [self showErrorMessage:[_categorys.error localizedFailureReason]];
            }
        }
    }
}

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

- (void)addSelectSort{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.sortArea = [[UIView alloc ]initWithFrame:CGRectMake(0.0f, self.navigationBarHeight-132.0f-44.0f-46.0f, width, 132.0f)];
    self.sortArea.backgroundColor = [UIColor whiteColor];
    
    NSArray *citys = @[@"智能排序",@"离我最近",@"人气最高"];
    for (int i=0; i<citys.count; i++) {
        UIButton *btn = UIButton.new;
        btn.backgroundColor = [UIColor whiteColor];
        btn.layer.borderColor = RGB(207, 207, 207).CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:citys[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
//        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn addTarget:self action:@selector(gotoSort:) forControlEvents:UIControlEventTouchUpInside];
        [self.sortArea addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_sortArea.top).offset(44*i);
            make.left.equalTo(_sortArea.left);
            make.right.equalTo(_sortArea.right);
            make.height.mas_equalTo(44);
        }];
    }
    
    [self.view addSubview:self.sortArea];
}

- (void)addSelectFilter{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.filterArea = [[UIScrollView alloc ]initWithFrame:CGRectMake(0.0f, self.navigationBarHeight-44.0f*6-44.0f-46.0f, width/2, 44.0f*6)];
    self.filterArea.backgroundColor = [UIColor whiteColor];
    _container = UIView.new;
    [self.filterArea addSubview:_container];
    [_container makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.filterArea);
        make.width.equalTo(self.filterArea.width);
    }];
    
    self.level2menu = [[UIScrollView alloc ]initWithFrame:CGRectMake(width/2, self.navigationBarHeight-44.0f*6-44.0f-46.0f, width/2, 44.0f*6)];
    self.level2menu.backgroundColor = RGB(240, 240, 240);
    _container2 = UIView.new;
    [self.level2menu addSubview:_container2];
    [_container2 makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.level2menu);
        make.width.equalTo(self.level2menu.width);
    }];
    
    [self.view addSubview:self.filterArea];
    [self.view addSubview:self.level2menu];
//    NSArray *citys = @[@"全部",@"美食",@"酒店",@"电影",@"购物",@"汽车"];
    

}

- (void)refreshSelectFilter{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    for (int i=0; i<_categorys.categorys.count; i++) {
        UIButton *btn = UIButton.new;
        btn.backgroundColor = [UIColor whiteColor];
        HYBCategoryInfo *category1 = _categorys.categorys[i];
        [btn setTitle:category1.mtname forState:UIControlStateNormal];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.tag = 10001+[category1.mtcode integerValue];
        [btn addTarget:self action:@selector(gotolevel2:) forControlEvents:UIControlEventTouchUpInside];
        [_container addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_filterArea.top).offset(44*i);
            make.left.equalTo(_filterArea.left);
            make.width.mas_equalTo(width/2);
            make.height.mas_equalTo(44);
        }];
        if(i==_categorys.categorys.count-1){
            [_container makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(btn.bottom);
            }];
        }
    }
}

-(void) gotolevel2:(id)sender{
    while (self.container2.subviews.count) {
        UIView *child = self.container2.subviews.lastObject;
        [child removeFromSuperview];
    }
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIButton *btn = (UIButton *)sender;
    long code = btn.tag - 10001;
    for (int i=0; i<_categorys.categorys.count; i++) {
        HYBCategoryInfo *category1 = _categorys.categorys[i];
        if(code == [category1.mtcode integerValue]){
            for (int j=0; j<category1.subList.count; j++) {
                HYBCategoryInfo2 *category2 = category1.subList[j];
                UIButton *btn = UIButton.new;
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitle:category2.mtname forState:UIControlStateNormal];
                [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
                [btn.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
                //        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.tag = 20001+[category2.mtcode integerValue];
                [btn addTarget:self action:@selector(gotoFilter:) forControlEvents:UIControlEventTouchUpInside];
                [self.container2 addSubview:btn];
                [btn makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_level2menu.top).offset(44*j);
                    make.left.equalTo(_level2menu.left);
                    make.width.mas_equalTo(width/2);
                    make.height.mas_equalTo(44);
                }];
                if(j==category1.subList.count-1){
                    [_container2 makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(btn.bottom);
                    }];
                }
            }
        }
    }
}

-(void)gotoSort:(id)sender{
    // TODO:
    [self pushSortArea];
}

-(void)gotoFilter:(id)sender{
    // TODO:
    [self pushFilterArea];
}

- (void) pullSortArea{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.sortArea.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.4];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(stopAnimating)];
    self.sortArea.center=CGPointMake(width/2, 66+self.navigationBarHeight+44+46);
    [UIView commitAnimations];
    
    self.isSortAreaDisplay =YES;
}

- (void) pushSortArea{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.sortArea.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.4];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(stopAnimating)];
    self.sortArea.center=CGPointMake(width/2, -66+self.navigationBarHeight+44+46);
    [UIView commitAnimations];
    
    self.isSortAreaDisplay = NO;
}

- (void) pullFilterArea{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.filterArea.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.4];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(stopAnimating)];
    self.filterArea.center=CGPointMake(width/4, 44*6/2+self.navigationBarHeight+44+46);
    self.level2menu.center=CGPointMake(3*width/4, 44*6/2+self.navigationBarHeight+44+46);
    [UIView commitAnimations];
    
    self.isFilterAreaDisplay =YES;
}

- (void) pushFilterArea{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    //打印动画块的位置
    NSLog(@"动画执行之前的位置：%@",NSStringFromCGPoint(self.filterArea.center));
    //首尾式动画
    [UIView beginAnimations:nil context:nil];
    //执行动画
    //设置动画执行时间
    [UIView setAnimationDuration:0.4];
    //设置代理
    [UIView setAnimationDelegate:self];
    //设置动画执行完毕调用的事件
    [UIView setAnimationDidStopSelector:@selector(stopAnimating)];
    self.filterArea.center=CGPointMake(width/4, -44*6/2+self.navigationBarHeight+44+46);
    self.level2menu.center=CGPointMake(3*width/4, -44*6/2+self.navigationBarHeight+44+46);
    [UIView commitAnimations];
    
    self.isFilterAreaDisplay = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftButtonTapped:(id)sender
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBSelectCityViewController *pushController = [[HYBSelectCityViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

#pragma mark  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.dataArray count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return [array count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataArray[indexPath.section];
    
    id obj;
    if([array count]>0){
        obj = array[indexPath.row];
    }
    if([obj isKindOfClass:[HYBStore2 class]]){
        HYBStore2Cell *storeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStore2Cell" forIndexPath:indexPath];
        HYBStore2 *temp = (HYBStore2 *)obj;
        storeCell.store = temp;
        storeCell.delegate = self;
        return storeCell;
    }else{
        return nil;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.dataArray[indexPath.section];
    
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    
    id obj;
    if([array count]>0){
        obj = array[indexPath.row];
    }
    
    if([obj isKindOfClass:[HYBStore2 class]]){
        CGSize size = CGSizeMake(width, 108.0f);
        return size;
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0F, 0.0F, 0.0F, 0.0F);
}

// 定义headview的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

// 定义footerView的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0F;
}

// 定义左右cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0F;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array = self.dataArray[indexPath.section];
    id object = array[indexPath.row];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    [self refreshData];
}

- (void)search{
    
}

- (void)filters{
    if(self.isFilterAreaDisplay){
        [self pushFilterArea];
    }else{
        [self pullFilterArea];
    }
}

-(void)sorts{
    if(self.isSortAreaDisplay){
        [self pushSortArea];
    }else{
        [self pullSortArea];
    }
}

-(void) gotoStoreDetail:(HYBStore2Cell *)cell withStore:(HYBStore2 *)store{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBStoreDetailViewController *pushController = [[HYBStoreDetailViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}


@end

