//
//  HYBOrderRecordsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBOrderRecordsViewController.h"
#import "masonry.h"
#import "HYBOrderRecordCell.h"
#import "HYBOrderRecord.h"
#import "HYBOrderRecordList.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBOrderDetailViewController.h"

@interface HYBOrderRecordsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBOrderRecordCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) HYBOrderRecordList *orderlist;
@end

@implementation HYBOrderRecordsViewController
- (void) dealloc{
    [_orderlist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"预订记录";
    self.view.backgroundColor = RGB(240, 240, 240);
    
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
    [self.view addSubview:searchBtn];
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
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+46, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-46) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBOrderRecordCell class] forCellWithReuseIdentifier:@"HYBOrderRecordCell"];
    self.orderlist = [[HYBOrderRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:ORDER_LIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.orderlist addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    HYBOrderRecordList *orderRecords = HYBOrderRecordList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBOrderRecord *o1 = HYBOrderRecord.new;
//    HYBOrderRecord *o2 = HYBOrderRecord.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    orderRecords.orderRecords = arr;
//    [_dataArray[0] addObjectsFromArray:orderRecords.orderRecords];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) refreshData{
    [self showLoadingView];
    [self.orderlist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
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
        if (object == _orderlist) {
            if (_orderlist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray addObject:_orderlist.orderRecords];
                
                [_collectionView reloadData];
            }
            else if (_orderlist.error) {
                [self showErrorMessage:[_orderlist.error localizedFailureReason]];
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
    if([obj isKindOfClass:[HYBOrderRecord class]]){
        HYBOrderRecordCell *orderRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBOrderRecordCell" forIndexPath:indexPath];
        HYBOrderRecord *temp = (HYBOrderRecord *)obj;
        orderRecordCell.orderRecord = temp;
        orderRecordCell.delegate = self;
        return orderRecordCell;
    }else{
        HYBOrderRecordCell *orderRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBOrderRecordCell" forIndexPath:indexPath];
        HYBOrderRecord *temp = (HYBOrderRecord *)obj;
        orderRecordCell.orderRecord = temp;
        orderRecordCell.delegate = self;
        return orderRecordCell;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(width, 80.0f);
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

- (void)search{
    
}

-(void) gotoOrderRecordDetail:(HYBOrderRecordCell *)cell withOrderRecord:(HYBOrderRecord *)orderRecord{
    HYBOrderDetailViewController *pushController = [[HYBOrderDetailViewController alloc] initWithOrder:orderRecord];
    [self.navigationController pushViewController:pushController animated:YES];
}


@end
