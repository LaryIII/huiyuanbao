//
//  HYBHomeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHomeViewController.h"
#import "ZButton.h"
#import "HYBAdvertisement.h"
#import "HYBBannersCell.h"
#import "HYBFirstStoreCell.h"
#import "HYBFirstStore.h"
#import "HYBStore.h"
#import "HYBStoreCell.h"

@interface HYBHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBBannersCellDelegate,HYBFirstStoreCellDelegate,HYBStoreCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

static const CGFloat heightWidthRatio = 7.0f / 16.0f;

@implementation HYBHomeViewController
{
    HYBBannersCell     *_bannerCell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.title = @"惠员包";
    self.view.backgroundColor = RGB(240, 240, 240);
    // Do any additional setup after loading the view.
    
    [self addRightNavigatorButton];
    [self addLeftNavigatorButton];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBBannersCell class] forCellWithReuseIdentifier:@"HYBBannersCell"];
    [_collectionView registerClass:[HYBFirstStoreCell class] forCellWithReuseIdentifier:@"HYBFirstStoreCell"];
    [_collectionView registerClass:[HYBStoreCell class] forCellWithReuseIdentifier:@"HYBStoreCell"];
    
    //test data
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:[NSMutableArray array]];
    NSMutableArray *bannerList = [[NSMutableArray alloc] init];
    HYBAdvertisement *ad = [[HYBAdvertisement alloc] init];
    ad.bannerUrl = @"http://7xidpx.com2.z0.glb.qiniucdn.com/partner.png";
    ad.jumpUrl = @"http://www.baidu.com";
    ad.logon = @"no";
    ad.position = 0;
    [bannerList addObject:ad];
    [self.dataArray[0] addObject:bannerList];
    
    [self.dataArray addObject:[NSMutableArray array]];
    NSMutableArray *firstList = [[NSMutableArray alloc] init];
    HYBFirstStore *firstStore = HYBFirstStore.new;
    [firstList addObject:firstStore];
    [self.dataArray[1] addObject:firstList];
    
    [self.dataArray addObject:[NSMutableArray array]];
    NSMutableArray *storeList = [[NSMutableArray alloc] init];
    HYBStore *store = HYBStore.new;
    [storeList addObject:store];
    [self.dataArray[2] addObject:storeList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightNavigatorButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.bounds) - 48, 10, 48, 32)];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"qrcode"]  forState:UIControlStateHighlighted];
    [rightButton setImageEdgeInsets:UIEdgeInsetsMake(2, 14, 5, 9)];
    [rightButton addTarget:self action:@selector(rightButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBar setRightButton:rightButton];}

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

- (void)leftButtonTapped:(id)sender
{
    //TODO
}

- (void)rightButtonTapped:(id)sender
{
    //TODO
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


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    //    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//    //        if (indexPath.section == 2) {
//    //            AJCompositeHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AJCompositeHeaderView" forIndexPath:indexPath];
//    //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleRecommendComposite:)];
//    //            singleTap.delaysTouchesBegan = YES;
//    //            singleTap.numberOfTapsRequired = 1;
//    //            [headView addGestureRecognizer:singleTap];
//    //
//    //            return headView;
//    //        }
//    //        else if (indexPath.section == 3) {
//    //            AJSummaryHeaderReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AJSummaryHeaderReusableView" forIndexPath:indexPath];
//    //            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleMoreSingles:)];
//    //            singleTap.delaysTouchesBegan = YES;
//    //            singleTap.numberOfTapsRequired = 1;
//    //            [headView addGestureRecognizer:singleTap];
//    //
//    //            return headView;
//    //        }
//    //        else {
//    //            return nil;
//    //        }
//    //    }
//    //    else {
//    return nil;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataArray[indexPath.section];
    
    id object = array[indexPath.row];
    if([object isKindOfClass:[NSArray class]])
    {
        id obj = object[0];
        
        if([obj isKindOfClass:[HYBAdvertisement class]])
        {
            
            if(!_bannerCell)
            {
                _bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBBannersCell" forIndexPath:indexPath];
            }
            _bannerCell.delegate = self;
            [_bannerCell.cycleScrollView setPlaceHolderImage:@"banner_default"];
            
            _bannerCell.banners = object;
            return _bannerCell;
        }else if([obj isKindOfClass:[HYBFirstStore class]]){
            HYBFirstStoreCell *firstStoreCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBFirstStoreCell" forIndexPath:indexPath];
            HYBFirstStore *temp = (HYBFirstStore *)obj;
            firstStoreCell.store = temp;
            firstStoreCell.delegate = self;
            return firstStoreCell;
        }else if([obj isKindOfClass:[HYBStore class]]){
            HYBStoreCell *storeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStoreCell" forIndexPath:indexPath];
            HYBStore *temp = (HYBStore *)obj;
            storeCell.store = temp;
            storeCell.delegate = self;
            return storeCell;
        }else{
            return nil;
        }
        
    }
    else{
        return nil;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.dataArray[indexPath.section];
    
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    
    id object = array[indexPath.row];
    
    if([object isKindOfClass:[NSArray class]])
    {
        if(object)
        {
            id obj = object[0];
            
            if([obj isKindOfClass:[HYBAdvertisement class]])
            {
                CGSize size = CGSizeMake(width, width * heightWidthRatio);
                return size;
            }else if([obj isKindOfClass:[HYBFirstStore class]]){
                CGSize size = CGSizeMake(width, 158.0f);
                return size;
            }else if([obj isKindOfClass:[HYBStore class]]){
                CGSize size = CGSizeMake(width, 148.0f);
                return size;
            }
            else
            {
                CGFloat heig = 0;
                if([object count] > 4)
                {
                    heig = 150.0;
                }
                else
                {
                    heig = 75.0f;
                }
                CGSize size = CGSizeMake(CGRectGetWidth(collectionView.bounds), heig);
                return size;
            }
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
//    if (section == 2 ) {
//        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 52.0f);
//    }
//    else {
        return CGSizeZero;
//    }
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


@end
