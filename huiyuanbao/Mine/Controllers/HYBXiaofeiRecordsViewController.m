//
//  HYBXiaofeiRecordsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/3.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBXiaofeiRecordsViewController.h"
#import "masonry.h"
#import "HYBXiaofeiRecordCell.h"
#import "HYBXiaofeiRecord.h"
#import "HYBXiaofeiRecordList.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBStoreXiaofeiRecordList.h"
#import "HYBStoreXiaofeiRecordCell.h"
#import "HYBStoreXiaofeiRecord.h"

@interface HYBXiaofeiRecordsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBXiaofeiRecordCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;

@property (nonatomic, strong) HYBXiaofeiRecordList *xiaofeilist;
@property (nonatomic, strong) HYBStoreXiaofeiRecordList *storexiaofeilist;
@end

@implementation HYBXiaofeiRecordsViewController
- (void) dealloc{
    [_xiaofeilist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_storexiaofeilist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
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
    
    
    UIView *title1 = UIView.new;
    title1.backgroundColor = RGB(235,235,235);
    [self.view addSubview: title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight+44.0f);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title1 = UILabel.new;
    t_title1.textAlignment = NSTextAlignmentCenter;
    t_title1.textColor = RGB(136, 136, 136);
    t_title1.font = [UIFont systemFontOfSize:14.0f];
    t_title1.text = @"本月";
    [title1 addSubview:t_title1];
    [t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+44+30, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-44-30) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBXiaofeiRecordCell class] forCellWithReuseIdentifier:@"HYBXiaofeiRecordCell"];
    [_collectionView registerClass:[HYBStoreXiaofeiRecordCell class] forCellWithReuseIdentifier:@"HYBStoreXiaofeiRecordCell"];
    
    self.xiaofeilist = [[HYBXiaofeiRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:HUIYUANBAO_XIAOFEILIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.xiaofeilist addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    self.storexiaofeilist = [[HYBStoreXiaofeiRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:STORE_XIAOFEILIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.storexiaofeilist addObserver:self
                       forKeyPath:kResourceLoadingStatusKeyPath
                          options:NSKeyValueObservingOptionNew
                          context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    HYBXiaofeiRecordList *xiaofeiRecords = HYBXiaofeiRecordList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBXiaofeiRecord *o1 = HYBXiaofeiRecord.new;
//    HYBXiaofeiRecord *o2 = HYBXiaofeiRecord.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    xiaofeiRecords.xiaofeiRecords = arr;
//    [_dataArray[0] addObjectsFromArray:xiaofeiRecords.xiaofeiRecords];
}
- (void) refreshData{
    [self showLoadingView];
    [self.xiaofeilist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                        @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                        
                                                                                        @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                        @"pageLength":@"10",
                                                                                        @"current":@"0"
                                                                                        }];
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
        if (object == _xiaofeilist) {
            if (_xiaofeilist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray addObject:_xiaofeilist.xiaofeiRecords];
                
                [_collectionView reloadData];
            }
            else if (_xiaofeilist.error) {
                [self showErrorMessage:[_xiaofeilist.error localizedFailureReason]];
            }
        }else if (object == _storexiaofeilist) {
            if (_storexiaofeilist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray addObject:_storexiaofeilist.storeXiaofeiRecords];
                
                [_collectionView reloadData];
            }
            else if (_storexiaofeilist.error) {
                [self showErrorMessage:[_storexiaofeilist.error localizedFailureReason]];
            }
        }
    }
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
    if([obj isKindOfClass:[HYBXiaofeiRecord class]]){
        HYBXiaofeiRecordCell *xiaofeiRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBXiaofeiRecordCell" forIndexPath:indexPath];
        HYBXiaofeiRecord *temp = (HYBXiaofeiRecord *)obj;
        xiaofeiRecordCell.xiaofeiRecord = temp;
        xiaofeiRecordCell.delegate = self;
        return xiaofeiRecordCell;
    }else if([obj isKindOfClass:[HYBStoreXiaofeiRecord class]]){
        HYBStoreXiaofeiRecordCell *storeXiaofeiRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreXiaofeiRecordCell" forIndexPath:indexPath];
        HYBStoreXiaofeiRecord *temp = (HYBStoreXiaofeiRecord *)obj;
        storeXiaofeiRecordCell.storeXiaofeiRecord = temp;
        storeXiaofeiRecordCell.delegate = self;
        return storeXiaofeiRecordCell;
    }else{
        HYBXiaofeiRecordCell *xiaofeiRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBXiaofeiRecordCell" forIndexPath:indexPath];
        HYBXiaofeiRecord *temp = (HYBXiaofeiRecord *)obj;
        xiaofeiRecordCell.xiaofeiRecord = temp;
        xiaofeiRecordCell.delegate = self;
        return xiaofeiRecordCell;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(width, 70.0f);
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
    [self refreshData];
}


-(void)huiyuanbao{
    _scrollView1.hidden = NO;
    _scrollView2.hidden = YES;
    _btn1.selected = YES;
    _btn2.selected = NO;
    [self refreshData];
}

-(void)shanghu{
    _scrollView1.hidden = YES;
    _scrollView2.hidden = NO;
    _btn1.selected = NO;
    _btn2.selected = YES;
    [self showLoadingView];
    [self.storexiaofeilist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                           @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                           
                                                                                           @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                           @"pageLength":@"10",
                                                                                           @"current":@"0"
                                                                                           }];
}

@end

