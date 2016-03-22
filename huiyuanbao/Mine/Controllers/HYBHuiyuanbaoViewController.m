//
//  HYBHuiyuanbaoViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHuiyuanbaoViewController.h"
#import "masonry.h"
#import "HYBHuiTradeRecordCell.h"
#import "HYBHuiTradeRecord.h"
#import "HYBHuiTradeRecordList.h"
#import "HYBHuiChargeRecordCell.h"
#import "HYBHuiChargeRecord.h"
#import "HYBHuiChargeRecordList.h"
#import "HYBHuiTixianRecordCell.h"
#import "HYBHuiTixianRecord.h"
#import "HYBHuiTixianRecordList.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBTixianViewController.h"
#import "HYBQueryBalance.h"

@interface HYBHuiyuanbaoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBHuiTradeRecordCellDelegate,HYBHuiChargeRecordCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIButton *btn3;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;

@property (nonatomic, strong) HYBHuiTradeRecordList *huitradelist;
@property (nonatomic, strong) HYBHuiChargeRecordList *huichargelist;
@property (nonatomic, strong) HYBHuiTixianRecordList *huitixianlist;

@property (nonatomic, strong) HYBQueryBalance *querybalance;

@property (nonatomic, strong) UIButton *tixianBtn;

@property (nonatomic, strong) UILabel *zhanghuValue;
@property (nonatomic, strong) UILabel *zhangliValue;
@property (nonatomic, strong) UILabel *xiaofeiValue;
@end

@implementation HYBHuiyuanbaoViewController
- (void) dealloc{
    [_huitradelist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_huichargelist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_huitixianlist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_querybalance removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"惠员包记录";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    UIButton *board = UIButton.new;
    [board setBackgroundImage:[UIImage imageNamed:@"bao_record_bg"] forState:UIControlStateNormal];
    [self.view addSubview:board];
    [board makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(120);
    }];
    
    _zhanghuValue = UILabel.new;
    _zhanghuValue.textAlignment = NSTextAlignmentCenter;
    _zhanghuValue.textColor = RGB(255, 255, 255);
    _zhanghuValue.font = [UIFont systemFontOfSize:22.0f];
    _zhanghuValue.text = @"1200";
    [board addSubview:_zhanghuValue];
    [_zhanghuValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(36);
        make.left.equalTo(board.left);
        make.width.mas_equalTo(width/3);
    }];
    
    UILabel *zhanghuKey = UILabel.new;
    zhanghuKey.textAlignment = NSTextAlignmentCenter;
    zhanghuKey.textColor = RGB(255, 255, 255);
    zhanghuKey.font = [UIFont systemFontOfSize:11.0f];
    zhanghuKey.text = @"可用余额";
    [board addSubview:zhanghuKey];
    [zhanghuKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(66);
        make.left.equalTo(board.left);
        make.width.mas_equalTo(width/3);
    }];
    
    _zhangliValue = UILabel.new;
    _zhangliValue.textAlignment = NSTextAlignmentCenter;
    _zhangliValue.textColor = RGB(255, 255, 255);
    _zhangliValue.font = [UIFont systemFontOfSize:22.0f];
    _zhangliValue.text = @"0.02";
    [board addSubview:_zhangliValue];
    [_zhangliValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(36);
        make.left.equalTo(_zhanghuValue.right);
        make.width.mas_equalTo(width/3);
    }];
    
    UILabel *zhangliKey = UILabel.new;
    zhangliKey.textAlignment = NSTextAlignmentCenter;
    zhangliKey.textColor = RGB(255, 255, 255);
    zhangliKey.font = [UIFont systemFontOfSize:11.0f];
    zhangliKey.text = @"昨日涨利";
    [board addSubview:zhangliKey];
    [zhangliKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(66);
        make.left.equalTo(zhanghuKey.right);
        make.width.mas_equalTo(width/3);
    }];
    
    _xiaofeiValue = UILabel.new;
    _xiaofeiValue.textAlignment = NSTextAlignmentCenter;
    _xiaofeiValue.textColor = RGB(255, 255, 255);
    _xiaofeiValue.font = [UIFont systemFontOfSize:22.0f];
    _xiaofeiValue.text = @"800";
    [board addSubview:_xiaofeiValue];
    [_xiaofeiValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(36);
        make.left.equalTo(_zhangliValue.right);
        make.width.mas_equalTo(width/3);
    }];
    
    UILabel *xiaofeiKey = UILabel.new;
    xiaofeiKey.textAlignment = NSTextAlignmentCenter;
    xiaofeiKey.textColor = RGB(255, 255, 255);
    xiaofeiKey.font = [UIFont systemFontOfSize:11.0f];
    xiaofeiKey.text = @"账户余额";
    [board addSubview:xiaofeiKey];
    [xiaofeiKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(66);
        make.left.equalTo(zhangliKey.right);
        make.width.mas_equalTo(width/3);
    }];
    
    
    UIView *segView = UIView.new;
    segView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segView];
    [segView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    _btn1 = UIButton.new;
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn1 setTitle:@"交易记录" forState:UIControlStateNormal];
    [_btn1 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn1 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(jiaoyi) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn1];
    _btn1.selected = YES;
    [_btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(segView.left);
        make.width.mas_equalTo(width/3);
        make.height.mas_equalTo(44);
    }];
    
    _btn2 = UIButton.new;
    _btn2.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn2 setTitle:@"充值记录" forState:UIControlStateNormal];
    [_btn2 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn2 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn2 addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn2];
    _btn2.selected = NO;
    [_btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(_btn1.right);
        make.width.mas_equalTo(width/3);
        make.height.mas_equalTo(44);
    }];
    
    _btn3 = UIButton.new;
    _btn3.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn3 setTitle:@"提现记录" forState:UIControlStateNormal];
    [_btn3 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn3 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn3 addTarget:self action:@selector(tixian) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn3];
    _btn3.selected = NO;
    [_btn3 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(_btn2.right);
        make.width.mas_equalTo(width/3);
        make.height.mas_equalTo(44);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+44+120, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-44-120) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBHuiTradeRecordCell class] forCellWithReuseIdentifier:@"HYBHuiTradeRecordCell"];
    [_collectionView registerClass:[HYBHuiChargeRecordCell class] forCellWithReuseIdentifier:@"HYBHuiChargeRecordCell"];
    self.huitradelist = [[HYBHuiTradeRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:HUITRADE_RECORD cachePolicyType:kCachePolicyTypeNone];
    self.huichargelist = [[HYBHuiChargeRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:HUICHARGE_RECORD cachePolicyType:kCachePolicyTypeNone];
    self.huitixianlist = [[HYBHuiTixianRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:HUITIXIAN_LIST cachePolicyType:kCachePolicyTypeNone];
    self.querybalance = [[HYBQueryBalance alloc] initWithBaseURL:HYB_API_BASE_URL path:QUERY_BALANCE cachePolicyType:kCachePolicyTypeNone];
    
    [self.huitradelist addObserver:self
                     forKeyPath:kResourceLoadingStatusKeyPath
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    [self.huichargelist addObserver:self
                        forKeyPath:kResourceLoadingStatusKeyPath
                           options:NSKeyValueObservingOptionNew
                           context:nil];
    [self.huitixianlist addObserver:self
                         forKeyPath:kResourceLoadingStatusKeyPath
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    [self.querybalance addObserver:self
                         forKeyPath:kResourceLoadingStatusKeyPath
                            options:NSKeyValueObservingOptionNew
                            context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
    
    _tixianBtn = UIButton.new;
    _tixianBtn.backgroundColor = MAIN_COLOR;
    [_tixianBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [_tixianBtn setTitle:@"余额提现" forState:UIControlStateNormal];
    _tixianBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [_tixianBtn addTarget:self action:@selector(tixians) forControlEvents:UIControlEventTouchUpInside];
    _tixianBtn.selected = NO;
    [self.view addSubview:_tixianBtn];
    [_tixianBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    [self.querybalance loadDataWithRequestMethodType:kHttpRequestMethodTypePost parameters:@{
                                                                                             @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                             
                                                                                             @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                             @"pageLength":@"10",
                                                                                             @"current":@"0"
                                                                                             }];
}
- (void) refreshData{
    [self showLoadingView];
    [self.huitradelist loadDataWithRequestMethodType:kHttpRequestMethodTypePost parameters:@{
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
        if (object == _huitradelist) {
            if (_huitradelist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:_huitradelist.huiTradeRecords];
                
                [_collectionView reloadData];
            }
            else if (_huitradelist.error) {
                [self showErrorMessage:[_huitradelist.error localizedFailureReason]];
            }
        }else if (object == _huichargelist) {
            if (_huichargelist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:_huichargelist.huiChargeRecords];
                
                [_collectionView reloadData];
            }
            else if (_huichargelist.error) {
                [self showErrorMessage:[_huichargelist.error localizedFailureReason]];
            }
        }
        else if (object == _huitixianlist) {
            if (_huitixianlist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:_huitixianlist.huiTixianRecords];
                
                [_collectionView reloadData];
            }
            else if (_huitixianlist.error) {
                [self showErrorMessage:[_huitixianlist.error localizedFailureReason]];
            }
        }else if (object == _querybalance) {
            if (_querybalance.isLoaded) {
                [self hideLoadingView];
                _zhanghuValue.text = _querybalance.balance;
                _zhangliValue.text = _querybalance.interest;
                _xiaofeiValue.text = _querybalance.wholebalance;
            }
            else if (_querybalance.error) {
                [self showErrorMessage:[_querybalance.error localizedFailureReason]];
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
    if([obj isKindOfClass:[HYBHuiTradeRecord class]]){
        HYBHuiTradeRecordCell *huiTradeRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBHuiTradeRecordCell" forIndexPath:indexPath];
        HYBHuiTradeRecord *temp = (HYBHuiTradeRecord *)obj;
        huiTradeRecordCell.huiTradeRecord = temp;
        huiTradeRecordCell.delegate = self;
        return huiTradeRecordCell;
    }else if([obj isKindOfClass:[HYBHuiChargeRecord class]]){
        HYBHuiChargeRecordCell *huiChargeRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBHuiChargeRecordCell" forIndexPath:indexPath];
        HYBHuiChargeRecord *temp = (HYBHuiChargeRecord *)obj;
        huiChargeRecordCell.huiChargeRecord = temp;
        huiChargeRecordCell.delegate = self;
        return huiChargeRecordCell;
    }else if([obj isKindOfClass:[HYBHuiTixianRecord class]]){
        HYBHuiTixianRecordCell *huiTixianRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBHuiTixianRecordCell" forIndexPath:indexPath];
        HYBHuiTixianRecord *temp = (HYBHuiTixianRecord *)obj;
        huiTixianRecordCell.huiTixianRecord = temp;
        huiTixianRecordCell.delegate = self;
        return huiTixianRecordCell;
    }else{
        HYBHuiTradeRecordCell *huiTradeRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBHuiTradeRecordCell" forIndexPath:indexPath];
        HYBHuiTradeRecord *temp = (HYBHuiTradeRecord *)obj;
        huiTradeRecordCell.huiTradeRecord = temp;
        huiTradeRecordCell.delegate = self;
        return huiTradeRecordCell;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

-(void)jiaoyi{
    _btn1.selected = YES;
    _btn2.selected = NO;
    _btn3.selected = NO;
    [self refreshData];
}

-(void)chongzhi{
    _btn1.selected = NO;
    _btn2.selected = YES;
    _btn3.selected = NO;
    [self showLoadingView];
    [self.huichargelist loadDataWithRequestMethodType:kHttpRequestMethodTypePost parameters:@{
                                                                                             @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                             
                                                                                             @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                             @"pageLength":@"10",
                                                                                             @"current":@"0"
                                                                                             }];
}
-(void)tixian{
    _btn1.selected = NO;
    _btn2.selected = NO;
    _btn3.selected = YES;
    [self showLoadingView];
    [self.huitixianlist loadDataWithRequestMethodType:kHttpRequestMethodTypePost parameters:@{
                                                                                              @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                              
                                                                                              @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                              @"pageLength":@"10",
                                                                                              @"current":@"0"
                                                                                              }];
}

-(void)tixians{
    HYBTixianViewController *pushController = [[HYBTixianViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

@end
