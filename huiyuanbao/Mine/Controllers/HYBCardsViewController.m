//
//  HYBCardsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCardsViewController.h"
#import "masonry.h"
#import "HYBCardCell.h"
#import "HYBCard.h"
#import "HYBCardList.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBHuiyuanbaoViewController.h"
#import "HYBQueryBalance.h"

@interface HYBCardsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBCardCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) HYBCardList *cardlist;

@property (nonatomic, strong) HYBQueryBalance *querybalance;

@end


@implementation HYBCardsViewController
- (void) dealloc{
    [_cardlist removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_querybalance removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"卡包";
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
    
    [_collectionView registerClass:[HYBCardCell class] forCellWithReuseIdentifier:@"HYBCardCell"];
    
    self.cardlist = [[HYBCardList alloc] initWithBaseURL:HYB_API_BASE_URL path:CARD_LIST cachePolicyType:kCachePolicyTypeNone];
    
    [self.cardlist addObserver:self
                 forKeyPath:kResourceLoadingStatusKeyPath
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    
    self.querybalance = [[HYBQueryBalance alloc] initWithBaseURL:HYB_API_BASE_URL path:QUERY_BALANCE cachePolicyType:kCachePolicyTypeNone];
    
    [self.querybalance addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    HYBCardList *cards = HYBCardList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBCard *o1 = HYBCard.new;
//    HYBCard *o2 = HYBCard.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    cards.cards = arr;
//    [_dataArray[0] addObjectsFromArray:cards.cards];
}

- (void) refreshData{
    [self showLoadingView];
    [self.querybalance loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
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
        if (object == _cardlist) {
            if (_cardlist.isLoaded) {
                [self hideLoadingView];
                HYBCard *huiyuanbaoCard = HYBCard.new;
                huiyuanbaoCard.merchant_rechage = @"";
                huiyuanbaoCard.interest = _querybalance.interest;
                huiyuanbaoCard.merchant_total = _querybalance.wholebalance;
                huiyuanbaoCard.merchant_img = @"hui";
                huiyuanbaoCard.merchant_name = @"惠员包";
                huiyuanbaoCard.pkmuser = _querybalance.pkmuser;
                huiyuanbaoCard.merchant_id = _querybalance.pkmuser;
                huiyuanbaoCard.logocheck = @"2";
                huiyuanbaoCard.merchant_blance = _querybalance.balance;
                [_cardlist.cards insertObject:huiyuanbaoCard atIndex:0];
                [self.dataArray addObject:_cardlist.cards];
                
                [_collectionView reloadData];
            }
            else if (_cardlist.error) {
                [self showErrorMessage:[_cardlist.error localizedFailureReason]];
            }
        }
        if (object == _querybalance) {
            if (_querybalance.isLoaded) {
                [self hideLoadingView];
                
                [self.cardlist loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                                    @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                                    
                                                                                                    @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                                    @"pageLength":@"10",
                                                                                                    @"current":@"0",
                                                                                                    @"muname":@""
                                                                                                    }];
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
    if([obj isKindOfClass:[HYBCard class]]){
        HYBCardCell *cardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCardCell" forIndexPath:indexPath];
        HYBCard *temp = (HYBCard *)obj;
        cardCell.card = temp;
        cardCell.delegate = self;
        return cardCell;
    }else{
        HYBCardCell *cardCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCardCell" forIndexPath:indexPath];
        HYBCard *temp = (HYBCard *)obj;
        cardCell.card = temp;
        cardCell.delegate = self;
        return cardCell;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)search{
    
}

-(void) gotoCardDetail:(HYBCardCell *)cell withCard:(HYBCard *)card{
    if([card.merchant_img isEqualToString:@"hui"]){
        HYBHuiyuanbaoViewController *pushController = [[HYBHuiyuanbaoViewController alloc] init];
        [self.navigationController pushViewController:pushController animated:YES];
    }
}


@end
