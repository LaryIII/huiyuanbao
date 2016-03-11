//
//  HYBChargeRecordsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBChargeRecordsViewController.h"
#import "masonry.h"
#import "HYBChargeRecordCell.h"
#import "HYBChargeRecord.h"
#import "HYBChargeRecordList.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBStoreChargeRecordList.h"
#import "HYBStoreChargeRecordCell.h"
#import "HYBStoreChargeRecord.h"

@interface HYBChargeRecordsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBChargeRecordCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;

@property (nonatomic, strong) HYBChargeRecordList *chargelist;
@property (nonatomic, strong) HYBStoreChargeRecordList *storechargelist;
@end

@implementation HYBChargeRecordsViewController
- (void) dealloc{
    [_chargelist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_storechargelist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"充值记录";
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
    
    [_collectionView registerClass:[HYBChargeRecordCell class] forCellWithReuseIdentifier:@"HYBChargeRecordCell"];
    [_collectionView registerClass:[HYBStoreChargeRecordCell class] forCellWithReuseIdentifier:@"HYBStoreChargeRecordCell"];
    
    self.chargelist = [[HYBChargeRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:CHARGE_LIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.chargelist addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    self.storechargelist = [[HYBStoreChargeRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:STORE_CHARGELIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.storechargelist addObserver:self
                      forKeyPath:kResourceLoadingStatusKeyPath
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    HYBChargeRecordList *chargeRecords = HYBChargeRecordList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBChargeRecord *o1 = HYBChargeRecord.new;
//    HYBChargeRecord *o2 = HYBChargeRecord.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    chargeRecords.chargeRecords = arr;
//    [_dataArray[0] addObjectsFromArray:chargeRecords.chargeRecords];
    [self refreshData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshData{
    [self showLoadingView];
    [self.chargelist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                        @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                        
                                                                                        @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                        @"pageLength":@"10",
                                                                                        @"current":@"0",
                                                                                        @"muname":@""
                                                                                        }];
}

#pragma mark Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
        if (object == _chargelist) {
            if (_chargelist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:_chargelist.chargeRecords];
                
                [_collectionView reloadData];
            }
            else if (_chargelist.error) {
                [self showErrorMessage:[_chargelist.error localizedFailureReason]];
            }
        }else if (object == _storechargelist) {
            if (_storechargelist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:_storechargelist.storeChargeRecords];
                
                [_collectionView reloadData];
            }
            else if (_storechargelist.error) {
                [self showErrorMessage:[_storechargelist.error localizedFailureReason]];
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
    if([obj isKindOfClass:[HYBChargeRecord class]]){
        HYBChargeRecordCell *chargeRecordCellCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBChargeRecordCell" forIndexPath:indexPath];
        HYBChargeRecord *temp = (HYBChargeRecord *)obj;
        chargeRecordCellCell.chargeRecord = temp;
        chargeRecordCellCell.delegate = self;
        return chargeRecordCellCell;
    }else if([obj isKindOfClass:[HYBStoreChargeRecord class]]){
        HYBStoreChargeRecordCell *storeChargeRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreChargeRecordCell" forIndexPath:indexPath];
        HYBStoreChargeRecord *temp = (HYBStoreChargeRecord *)obj;
        storeChargeRecordCell.storeChargeRecord = temp;
        storeChargeRecordCell.delegate = self;
        return storeChargeRecordCell;
    }else{
        HYBChargeRecordCell *chargeRecordCellCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBChargeRecordCell" forIndexPath:indexPath];
        HYBChargeRecord *temp = (HYBChargeRecord *)obj;
        chargeRecordCellCell.chargeRecord = temp;
        chargeRecordCellCell.delegate = self;
        return chargeRecordCellCell;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(width, 75.0f);
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
    _btn1.selected = YES;
    _btn2.selected = NO;
    [self refreshData];
}

-(void)shanghu{
    _btn1.selected = NO;
    _btn2.selected = YES;
    [self showLoadingView];
    [self.storechargelist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                          @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                          
                                                                                          @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                          @"pageLength":@"10",
                                                                                          @"current":@"0",
                                                                                          @"muname":@""
                                                                                          }];
}

@end
