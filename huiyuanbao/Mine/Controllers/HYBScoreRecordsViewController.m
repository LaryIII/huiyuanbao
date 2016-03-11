//
//  HYBScoreRecordsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBScoreRecordsViewController.h"
#import "masonry.h"
#import "HYBScoreRecordCell.h"
#import "HYBScoreRecord.h"
#import "HYBScoreRecordList.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBScoreRecordsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBScoreRecordCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UIScrollView *scrollView1;
@property(strong, nonatomic) UIScrollView *scrollView2;

@property (nonatomic, strong) HYBScoreRecordList *scorelist;
@end

@implementation HYBScoreRecordsViewController
- (void) dealloc{
    [_scorelist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"积分记录";
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
    
    UILabel *zhanghuValue = UILabel.new;
    zhanghuValue.textAlignment = NSTextAlignmentCenter;
    zhanghuValue.textColor = RGB(255, 255, 255);
    zhanghuValue.font = [UIFont systemFontOfSize:22.0f];
    zhanghuValue.text = @"1200";
    [board addSubview:zhanghuValue];
    [zhanghuValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(36);
        make.left.equalTo(board.left);
        make.width.mas_equalTo(width/2);
    }];
    
    UILabel *zhanghuKey = UILabel.new;
    zhanghuKey.textAlignment = NSTextAlignmentCenter;
    zhanghuKey.textColor = RGB(255, 255, 255);
    zhanghuKey.font = [UIFont systemFontOfSize:11.0f];
    zhanghuKey.text = @"账户积分";
    [board addSubview:zhanghuKey];
    [zhanghuKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(66);
        make.left.equalTo(board.left);
        make.width.mas_equalTo(width/2);
    }];
    
    UILabel *xiaofeiValue = UILabel.new;
    xiaofeiValue.textAlignment = NSTextAlignmentCenter;
    xiaofeiValue.textColor = RGB(255, 255, 255);
    xiaofeiValue.font = [UIFont systemFontOfSize:22.0f];
    xiaofeiValue.text = @"800";
    [board addSubview:xiaofeiValue];
    [xiaofeiValue makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(36);
        make.left.equalTo(zhanghuValue.right);
        make.width.mas_equalTo(width/2);
    }];
    
    UILabel *xiaofeiKey = UILabel.new;
    xiaofeiKey.textAlignment = NSTextAlignmentCenter;
    xiaofeiKey.textColor = RGB(255, 255, 255);
    xiaofeiKey.font = [UIFont systemFontOfSize:11.0f];
    xiaofeiKey.text = @"已消费积分";
    [board addSubview:xiaofeiKey];
    [xiaofeiKey makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(board.top).offset(66);
        make.left.equalTo(zhanghuKey.right);
        make.width.mas_equalTo(width/2);
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
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+44+120, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-44-120) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBScoreRecordCell class] forCellWithReuseIdentifier:@"HYBScoreRecordCell"];
    self.scorelist = [[HYBScoreRecordList alloc] initWithBaseURL:HYB_API_BASE_URL path:SCORE_LIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.scorelist addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
}
- (void) refreshData{
    [self showLoadingView];
    [self.scorelist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                        @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                        
                                                                                        @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                        @"pageLength":@"10",
                                                                                        @"current":@"0",
                                                                                        @"muname":@""
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
        if (object == _scorelist) {
            if (_scorelist.isLoaded) {
                [self hideLoadingView];
                [self.dataArray addObject:_scorelist.scoreRecords];
                
                [_collectionView reloadData];
            }
            else if (_scorelist.error) {
                [self showErrorMessage:[_scorelist.error localizedFailureReason]];
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
    if([obj isKindOfClass:[HYBScoreRecord class]]){
        HYBScoreRecordCell *scoreRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBScoreRecordCell" forIndexPath:indexPath];
        HYBScoreRecord *temp = (HYBScoreRecord *)obj;
        scoreRecordCell.scoreRecord = temp;
        scoreRecordCell.delegate = self;
        return scoreRecordCell;
    }else{
        HYBScoreRecordCell *scoreRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBScoreRecordCell" forIndexPath:indexPath];
        HYBScoreRecord *temp = (HYBScoreRecord *)obj;
        scoreRecordCell.scoreRecord = temp;
        scoreRecordCell.delegate = self;
        return scoreRecordCell;
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
}

-(void)shanghu{
    _btn1.selected = NO;
    _btn2.selected = YES;
}

@end
