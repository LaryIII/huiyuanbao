//
//  HYBStoreDetailViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreDetailViewController.h"
#import "masonry.h"
#import "CXCycleScrollView.h"
#import "HYBAdvertisement.h"
#import "HYBStoreBaseInfoCell.h"
#import "HYBStoreBaseInfo.h"
#import "HYBStoreProduct.h"
#import "HYBStoreProductCell.h"
#import "HYBStoreProductList.h"
#import "HYBStore.h"
#import "HYBShopDetail.h"
#import "GVUserDefaults+HYBProperties.h"
#import "HYBJoinShopViewController.h"
#import "HYBOrderProductViewController.h"
#import "HYBTradeRecordCell.h"
#import "HYBHeadCell.h"
#import "HYBTradeRecord.h"

static const CGFloat heightWidthRatio = 7.0f / 16.0f;

@interface HYBStoreDetailViewController ()<CXCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,HYBStoreBaseInfoCellDelegate,HYBStoreProductCellDelegate>
@property (nonatomic, strong) CXCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) HYBStore *store;

@property(strong, nonatomic) UIButton *btn1;
@property(strong, nonatomic) UIButton *btn2;
@property(strong, nonatomic) UICollectionView *collectionView1;
@property(strong, nonatomic) UICollectionView *collectionView2;
@property (nonatomic, strong) NSMutableArray *dataArray1;
@property (nonatomic, strong) NSMutableArray *dataArray2;

@property (nonatomic, strong) HYBShopDetail *shopdetail;
@property (nonatomic, strong) HYBTradeRecord *traderecord;
@end

@implementation HYBStoreDetailViewController

- (void) dealloc{
    [_shopdetail removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
    [_traderecord removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
}
- (instancetype)initWithStore:(HYBStore *)store {
    self = [super init];
    if (self) {
        self.store = store;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    self.navigationBar.title = _store.shopsname;//@"大娘水饺";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    UICollectionViewFlowLayout *collectionViewFlowLayout2 = [[UICollectionViewFlowLayout alloc]init];
    _collectionView2 = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+44+width*heightWidthRatio, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-44-width*heightWidthRatio) collectionViewLayout:collectionViewFlowLayout2];
    _collectionView2.alwaysBounceVertical = YES;
    _collectionView2.delegate = self;
    _collectionView2.dataSource = self;
    _collectionView2.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView2.backgroundColor = RGB(240, 240, 240);
    _collectionView2.tag = 10002;
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView2];
    
    [_collectionView2 registerClass:[HYBHeadCell class] forCellWithReuseIdentifier:@"HYBHeadCell"];
    [_collectionView2 registerClass:[HYBTradeRecordCell class] forCellWithReuseIdentifier:@"HYBTradeRecordCell"];
    
    //test data
    self.dataArray2 = [NSMutableArray array];
    [self.dataArray2 addObject:[NSMutableArray array]];
    [_dataArray2[0] addObject:@[]];
    [self.dataArray2 addObject:[NSMutableArray array]];
//    HYBTradeRecord *tradeRecord = HYBTradeRecord.new;
//    [_dataArray2[1] addObject:tradeRecord];
    
    // 请求数据，获得商家详情
    self.shopdetail = [[HYBShopDetail alloc] initWithBaseURL:HYB_API_BASE_URL path:SHOP_DETAIL cachePolicyType:kCachePolicyTypeNone];
    
    [self.shopdetail addObserver:self
                    forKeyPath:kResourceLoadingStatusKeyPath
                       options:NSKeyValueObservingOptionNew
                       context:nil];
    
    // 商家交易记录
    self.traderecord = [[HYBTradeRecord alloc] initWithBaseURL:HYB_API_BASE_URL path:TRADE_RECORD cachePolicyType:kCachePolicyTypeNone];
    
    [self.traderecord addObserver:self
                      forKeyPath:kResourceLoadingStatusKeyPath
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    
}

-(void)refreshData{
    [self showLoadingView];
    [self.shopdetail loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                          @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                          @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                          @"pkmuser":_store.shopsid
                                                                                          }];
}

- (void)setBanners:(NSArray *)banners
{
    _banners = banners;
    
    if ([self.banners count] == 1) {
        HYBAdvertisement *advertisement = self.banners[0];
        self.cycleScrollView.imageURLArray = @[[IMG_PREFIX stringByAppendingString: advertisement.adurl]];
    }
    else if ([self.banners count] > 1) {
        //        AJAdvertisement *fristAd = self.banners.firstObject;
        //        AJAdvertisement *lastAd = self.banners.lastObject;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (HYBAdvertisement *advertisement in self.banners) {
            [array addObject:[IMG_PREFIX stringByAppendingString: advertisement.adurl]];
        }
        //        [array addObject:fristAd.bannerUrl];
        self.cycleScrollView.imageURLArray = array;
    }
    else {
        self.cycleScrollView.imageURLArray = @[];
    }
    _cycleScrollView.showDot = YES;
}

#pragma mark Key-value observing
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kResourceLoadingStatusKeyPath]) {
        if (object == _shopdetail) {
            if (_shopdetail.isLoaded) {
                [self hideLoadingView];
                [self loadData];
            }
            else if (_shopdetail.error) {
                [self showErrorMessage:[_shopdetail.error localizedFailureReason]];
            }
        }else if(object == _traderecord){
            if(_traderecord.isLoaded){
                [self hideLoadingView];
                [_collectionView2 reloadData];
            }else if (_traderecord.error) {
                [self showErrorMessage:[_traderecord.error localizedFailureReason]];
            }
        }
    }
}

-(void)loadData{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    UIView *ssuperview = self.view;
    
    _cycleScrollView = [[CXCycleScrollView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, width, width*heightWidthRatio)];
    _cycleScrollView.showDot = YES;
    _cycleScrollView.delegate = self;
    [self.view addSubview:_cycleScrollView];
    
//    NSMutableArray *bannerList = [[NSMutableArray alloc] init];
//    HYBAdvertisement *ad = [[HYBAdvertisement alloc] init];
//    ad.adurl = @"http://7xidpx.com2.z0.glb.qiniucdn.com/partner.png";
//    //    ad.position = 0;
//    [bannerList addObject:ad];
    
    [self setBanners:_shopdetail.merAd];
    
    // tab
    UIView *segView = UIView.new;
    segView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:segView];
    [segView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(width*heightWidthRatio);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    _btn1 = UIButton.new;
    _btn1.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [_btn1 setTitle:@"商家信息" forState:UIControlStateNormal];
    [_btn1 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn1 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(shangjiaxinxi) forControlEvents:UIControlEventTouchUpInside];
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
    [_btn2 setTitle:@"交易记录" forState:UIControlStateNormal];
    [_btn2 setTitleColor:MAIN_COLOR forState:UIControlStateSelected];
    [_btn2 setTitleColor:RGB(82, 82, 82) forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_default"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"tab_current"] forState:UIControlStateSelected];
    [_btn2 addTarget:self action:@selector(jiaoyijilu) forControlEvents:UIControlEventTouchUpInside];
    [segView addSubview:_btn2];
    _btn2.selected = NO;
    [_btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(segView.top);
        make.left.equalTo(_btn1.right);
        make.width.mas_equalTo(width/2);
        make.height.mas_equalTo(44);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView1 = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+44+width*heightWidthRatio, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-44-width*heightWidthRatio) collectionViewLayout:collectionViewFlowLayout];
    _collectionView1.alwaysBounceVertical = YES;
    _collectionView1.delegate = self;
    _collectionView1.dataSource = self;
    _collectionView1.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView1.backgroundColor = RGB(240, 240, 240);
    _collectionView1.tag = 10001;
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView1];
    
    [_collectionView1 registerClass:[HYBStoreBaseInfoCell class] forCellWithReuseIdentifier:@"HYBStoreBaseInfoCell"];
    [_collectionView1 registerClass:[HYBStoreProductCell class] forCellWithReuseIdentifier:@"HYBStoreProductCell"];
    
    //test data
    self.dataArray1 = [NSMutableArray array];
    [self.dataArray1 addObject:[NSMutableArray array]];
//    HYBStoreBaseInfo *baseinfo = HYBStoreBaseInfo.new;
    _shopdetail.isvip = _store.isvip;
    [_dataArray1[0] addObject:_shopdetail];
    
    [self.dataArray1 addObject:[NSMutableArray array]];
//    HYBStoreProductList *products = HYBStoreProductList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBStoreProduct *o1 = HYBStoreProduct.new;
//    HYBStoreProduct *o2 = HYBStoreProduct.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    products.products = arr;
    [_dataArray1[1] addObjectsFromArray:_shopdetail.productList];
    
    
    //    _scrollView2 = UIScrollView.new;
    //    _scrollView2.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:_scrollView2];
    //    _scrollView2.hidden = YES;
    //    [_scrollView2 makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(ssuperview).with.insets(UIEdgeInsetsMake(self.navigationBarHeight+44,0,0,0));
    //    }];
    //
    //    UIView *container2 = [UIView new];
    //    [_scrollView2 addSubview:container2];
    //    [container2 makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.equalTo(_scrollView2);
    //        make.width.equalTo(_scrollView2.width);
    //    }];
    
    
    
    
    // 底部按钮
    UIButton *bottomBtn1 = UIButton.new;
    bottomBtn1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [bottomBtn1 setTitle:@"025-84005821" forState:UIControlStateNormal];
    [bottomBtn1 setTitle:@"025-84005821" forState:UIControlStateDisabled];
    [bottomBtn1 setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    [bottomBtn1 setImage:[UIImage imageNamed:@"d_tel"] forState:UIControlStateNormal];
    [bottomBtn1 setImageEdgeInsets:UIEdgeInsetsMake(0,-40,0,10)];
    [bottomBtn1 setTitleEdgeInsets:UIEdgeInsetsMake(0,-30,0,0)];
    [bottomBtn1 addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn1];
    bottomBtn1.backgroundColor = [UIColor whiteColor];
    
    [bottomBtn1 makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width-110);
        make.left.equalTo(ssuperview.left);
        make.bottom.equalTo(ssuperview.bottom);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *bottomBtn2 = UIButton.new;
    bottomBtn2.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    // 如果非商家会员
    if([_store.isvip isEqualToString:@"N"]){
        [bottomBtn2 setTitle:@"加入会员" forState:UIControlStateNormal];
        [bottomBtn2 setTitle:@"加入会员" forState:UIControlStateDisabled];
        [bottomBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn2 addTarget:self action:@selector(join) forControlEvents:UIControlEventTouchUpInside];
    }else if([_store.isvip isEqualToString:@"Y"]){
        [bottomBtn2 setTitle:@"立即充值" forState:UIControlStateNormal];
        [bottomBtn2 setTitle:@"立即充值" forState:UIControlStateDisabled];
        [bottomBtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn2 addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:bottomBtn2];
    bottomBtn2.backgroundColor = MAIN_COLOR;
    
    [bottomBtn2 makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110);
        make.right.equalTo(ssuperview.right);
        make.bottom.equalTo(ssuperview.bottom);
        make.height.mas_equalTo(40);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)shangjiaxinxi{
    _collectionView1.hidden = NO;
    _collectionView2.hidden = YES;
    _btn1.selected = YES;
    _btn2.selected = NO;
}

-(void)jiaoyijilu{
    [self showLoadingView];
    [self.traderecord loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                          @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                          @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
                                                                                          @"pkmuser":_store.shopsid,
                                                                                          @"current":@"0",
                                                                                          @"pageLength":@"10"
                                                                                          }];
    _collectionView1.hidden = YES;
    _collectionView2.hidden = NO;
    _btn1.selected = NO;
    _btn2.selected = YES;
}

#pragma mark  UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if(collectionView.tag == 10001){
        return [self.dataArray1 count];
    }else if(collectionView.tag == 10002){
        return [self.dataArray2 count];
    }else{
        return 0;
    }
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 10001){
        NSArray *array = self.dataArray1[section];
        return [array count];
    }else{
        NSArray *array = self.dataArray2[section];
        return [array count];
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 10001){
        NSArray *array = self.dataArray1[indexPath.section];
        id obj;
        if([array count]>0){
            obj = array[indexPath.row];
        }
        if([obj isKindOfClass:[HYBShopDetail class]]){
            HYBStoreBaseInfoCell *baseinfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreBaseInfoCell" forIndexPath:indexPath];
            HYBShopDetail *temp = (HYBShopDetail *)obj;
            baseinfoCell.storeBaseInfo = temp;
            baseinfoCell.delegate = self;
            return baseinfoCell;
        }else if([obj isKindOfClass:[HYBStoreProduct class]]){
            HYBStoreProductCell *productCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreProductCell" forIndexPath:indexPath];
            HYBStoreProduct *temp = (HYBStoreProduct *)obj;
            productCell.product = temp;
            productCell.delegate = self;
            return productCell;
        }else{
            HYBStoreBaseInfoCell *baseinfoCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreBaseInfoCell" forIndexPath:indexPath];
            HYBShopDetail *temp = (HYBShopDetail *)obj;
            baseinfoCell.storeBaseInfo = temp;
            baseinfoCell.delegate = self;
            return baseinfoCell;
        }
    }else if(collectionView.tag == 10002){
        NSArray *array = self.dataArray2[indexPath.section];
        id obj;
        if([array count]>0){
            obj = array[indexPath.row];
        }
        if([obj isKindOfClass:[HYBTradeRecord class]]){
            HYBTradeRecordCell *tradeRecordCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBTradeRecordCell" forIndexPath:indexPath];
            HYBTradeRecord *temp = (HYBTradeRecord *)obj;
            tradeRecordCell.tradeRecord = temp;
            tradeRecordCell.delegate = self;
            return tradeRecordCell;
        }else{
            HYBHeadCell *headCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBHeadCell" forIndexPath:indexPath];
            return headCell;
        }
    }
    return nil;
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(collectionView.tag == 10001){
        NSArray *array = self.dataArray1[indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.bounds);
        
        id obj;
        if([array count]>0){
            obj = array[indexPath.row];
        }
        if([obj isKindOfClass:[HYBShopDetail class]])
        {
            CGSize size = CGSizeMake(width, 197.0f);
            return size;
        }else if([obj isKindOfClass:[HYBStoreProduct class]]){
            CGSize size = CGSizeMake(width, 89.0f);
            return size;
        }
    }else if(collectionView.tag == 10002){
        NSArray *array = self.dataArray2[indexPath.section];
        
        CGFloat width = CGRectGetWidth(collectionView.bounds);
        
        id obj;
        if([array count]>0){
            obj = array[indexPath.row];
        }
        if([obj isKindOfClass:[HYBTradeRecord class]])
        {
            CGSize size = CGSizeMake(width, 70.0f);
            return size;
        }else{
            CGSize size = CGSizeMake(width, 30.0f);
            return size;
        }
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
//    NSMutableArray *array = self.dataArray1[indexPath.section];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    [self refreshData];
}

-(void)join{
    HYBJoinShopViewController *pushController = [[HYBJoinShopViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)charge{
    
}

-(void) gotoProductDetail:(HYBStoreProductCell *)cell withProduct:(HYBStoreProduct *)product{
    
}
-(void) orderProduct:(HYBStoreProductCell *)cell withProduct:(HYBStoreProduct *)product{
    HYBOrderProductViewController *pushController = [[HYBOrderProductViewController alloc] initWithProduct:product withStore:_store];
    [self.navigationController pushViewController:pushController animated:YES];
}


@end
