//
//  HYBHomeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHomeViewController.h"
#import "ZButton.h"
#import "RDVTabBarController.h"
#import "HYBAdvertisement.h"
#import "HYBBannersCell.h"
#import "HYBFirstStoreCell.h"
#import "HYBFirstStore.h"
#import "HYBStore.h"
#import "HYBStoreCell.h"
#import "HYBSelectCityViewController.h"
#import "HYBQRCodeViewController.h"
#import "QRCodeReader.h"
#import "QRCodeReaderViewController.h"
#import "HYBStoreDetailViewController.h"
#import "HYBHomeData.h"
#import "CocoaSecurity.h"
#import "HYBStoreHeaderReusableView.h"
#import "HYBFirstStoreHeaderReusableView.h"
#import "GVUserDefaults+HYBProperties.h"

#import "INTULocationManager.h"

//#import "MKReverseGeocoder.h"
#import <CoreLocation/CoreLocation.h>

#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>


@interface HYBHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBBannersCellDelegate,HYBFirstStoreCellDelegate,HYBStoreCellDelegate, QRCodeReaderDelegate,CLLocationManagerDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) QRCodeReaderViewController *vc;
@property (nonatomic, strong) HYBHomeData *homedata;

//@property (nonatomic, strong) BMKLocationService *locService;
@property(nonatomic,strong) CLGeocoder *geocoder;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, strong) BMKGeoCodeSearch *searcher;
@property (nonatomic, strong) BMKLocationService *locService;
@end

static const CGFloat heightWidthRatio = 7.0f / 16.0f;
@implementation HYBHomeViewController
{
    HYBBannersCell     *_bannerCell;
}

- (void) dealloc{
    [_homedata removeObserver:self forKeyPath:kResourceLoadingStatusKeyPath];
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
    [_collectionView registerClass:[HYBStoreHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYBStoreHeaderReusableView"];
    [_collectionView registerClass:[HYBFirstStoreHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYBFirstStoreHeaderReusableView"];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    NSMutableArray *bannerList = [[NSMutableArray alloc] init];
//    HYBAdvertisement *ad = [[HYBAdvertisement alloc] init];
//    ad.adurl = @"http://7xidpx.com2.z0.glb.qiniucdn.com/partner.png";
//    [bannerList addObject:ad];
//    [self.dataArray[0] addObject:bannerList];
//    
//    [self.dataArray addObject:[NSMutableArray array]];
//    NSMutableArray *firstList = [[NSMutableArray alloc] init];
//    HYBFirstStore *firstStore = HYBFirstStore.new;
//    [firstList addObject:firstStore];
//    [self.dataArray[1] addObject:firstList];
//    
//    [self.dataArray addObject:[NSMutableArray array]];
//    NSMutableArray *storeList = [[NSMutableArray alloc] init];
//    HYBStore *store = HYBStore.new;
//    [storeList addObject:store];
//    [self.dataArray[2] addObject:storeList];
    
    
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    // Instantiate the view controller
    _vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    // Set the presentation style
    _vc.modalPresentationStyle = UIModalPresentationFormSheet;
    // Define the delegate receiver
    _vc.delegate = self;
    // Or use blocks
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
    }];
    
    self.homedata = [[HYBHomeData alloc] initWithBaseURL:HYB_API_BASE_URL path:HOME_DATA cachePolicyType:kCachePolicyTypeNone];
    
    [self.homedata addObserver:self
                 forKeyPath:kResourceLoadingStatusKeyPath
                    options:NSKeyValueObservingOptionNew
                    context:nil];
    
    [self geocode];
}

-(void)geocode{
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= [GVUserDefaults standardUserDefaults].cityname;
    geoCodeSearchOption.address = [GVUserDefaults standardUserDefaults].cityname;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    //    [geoCodeSearchOption release];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

-(void)reversegeocode{
    //发起反向地理编码检索
    float lon = [[GVUserDefaults standardUserDefaults].longitude floatValue];
    float lat = [[GVUserDefaults standardUserDefaults].latitude floatValue];
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lon, lat};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
//    [reverseGeoCodeSearchOption release];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}



- (void) refreshData{
    [self showLoadingView];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    [_locService setDistanceFilter:100];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    //定位管理器
//    _locationManager=[[CLLocationManager alloc]init];
//    
//    if (![CLLocationManager locationServicesEnabled]) {
//        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
//        return;
//    }
//    
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue] > 8.0)
//    {
//        //设置定位权限 仅ios8有意义
//        [_locationManager requestWhenInUseAuthorization];// 前台定位
//        
//        //  [locationManager requestAlwaysAuthorization];// 前后台同时定位
//    }
//    
//    //如果没有授权则请求用户授权
//    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
//        [_locationManager requestWhenInUseAuthorization];
//    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
//        //设置代理
//        _locationManager.delegate=self;
//        //设置定位精度
//        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
//        //定位频率,每隔多少米定位一次
//        CLLocationDistance distance=10.0;//十米定位一次
//        _locationManager.distanceFilter=distance;
//        //启动跟踪定位
//        [_locationManager startUpdatingLocation];
//    }
    
//    INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//    [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyHouse
//                                       timeout:10.0
//                          delayUntilAuthorized:YES  // This parameter is optional, defaults to NO if omitted
//                                         block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//                                             if (status == INTULocationStatusSuccess) {
//                                                 [self.homedata loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
//                                                                                                                                     @"userId":[GVUserDefaults standardUserDefaults].userId,
//                                                                                                                                     @"longitude":[NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude],
//                                                                                                                                     @"latitude":[NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude],
//                                                                                                                                     @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
//                                                                                                                                     @"pageLength":@"10",
//                                                                                                                                     @"current":@"0"
//                                                                                                                                     }];
//                                                 
//                                                 CLLocation *location=[[CLLocation alloc]initWithLatitude:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
//                                                 //2.反地理编码
//                                                 [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//                                                     if (error||placemarks.count==0) {
////                                                         self.reverdeDetailAddressLabel.text=@"你输入的地址没找到，可能在月球上";
//                                                     }else//编码成功
//                                                     {
//                                                         //显示最前面的地标信息
//                                                         CLPlacemark *firstPlacemark=[placemarks firstObject];
//                                                         NSLog(@"%@%@",firstPlacemark.name, firstPlacemark);
//                                                     }
//                                                 }];
//                                             }
//                                             else if (status == INTULocationStatusTimedOut) {
//                                            }
//                                             else {
//                                            }
//                                         }];
    
}

-(void)requestData{
    [self.homedata loadDataWithRequestMethodType:kHttpRequestMethodTypeGet parameters:@{
                                                                                                                                                                                                                             @"userId":[GVUserDefaults standardUserDefaults].userId,
                                                                                                                                                                                                                             @"longitude":[GVUserDefaults standardUserDefaults].longitude,
                                                                                                                                                                                                                             @"latitude":[GVUserDefaults standardUserDefaults].latitude,
                                                                                                                                                                                                                             @"phoneno":[GVUserDefaults standardUserDefaults].phoneno,
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
        if (object == _homedata) {
            if (_homedata.isLoaded) {
                [self hideLoadingView];
                [self.dataArray removeAllObjects];
                [self.dataArray addObject:[NSMutableArray array]];
                [self.dataArray[0] addObject:_homedata.ads];
                
//                [self.dataArray addObject:[NSMutableArray array]];
                [self.dataArray addObject:_homedata.firstStores];
                
//                [self.dataArray addObject:[NSMutableArray array]];
                [self.dataArray addObject:_homedata.stores];
                
                [_collectionView reloadData];
            }
            else if (_homedata.error) {
                [self showErrorMessage:[_homedata.error localizedFailureReason]];
            }
        }
    }
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
    ZButton *leftButton=[[ZButton alloc ] initWithFrame : CGRectMake (0, 31, 200, 44)];
    [leftButton setTitle : [GVUserDefaults standardUserDefaults].cityname forState : UIControlStateNormal];
    [leftButton setImage :[ UIImage imageNamed:@"city_arrow"] forState : UIControlStateNormal];
    [leftButton setTitleColor :RGB(255, 255, 255) forState : UIControlStateNormal];
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(2, 14, 5, 9)];
    [leftButton addTarget:self action:@selector(leftButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.navigationBar addSubview :rightButton];
    [self.navigationBar setLeftButton:leftButton];
}

- (void)leftButtonTapped:(id)sender
{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBSelectCityViewController *pushController = [[HYBSelectCityViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

- (void)rightButtonTapped:(id)sender
{
//    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//    HYBQRCodeViewController *pushController = [[HYBQRCodeViewController alloc] init];
//    [self.navigationController pushViewController:pushController animated:YES];
    
    [self presentViewController:_vc animated:YES completion:NULL];
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


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 1) {
            HYBFirstStoreHeaderReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYBFirstStoreHeaderReusableView" forIndexPath:indexPath];
            
            return headView;
        }
        else if (indexPath.section == 2) {
            HYBStoreHeaderReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HYBStoreHeaderReusableView" forIndexPath:indexPath];
            
            return headView;
        }
        else {
            return nil;
        }
    }
    else {
        return nil;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataArray[indexPath.section];
    id obj;
    if([array count]>0){
        obj = array[indexPath.row];
    }
    
    if([obj isKindOfClass:[NSArray class]]){
        id object = obj[0];
        if([object isKindOfClass:[HYBAdvertisement class]])
        {
            
            if(!_bannerCell)
            {
                _bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBBannersCell" forIndexPath:indexPath];
            }
            _bannerCell.delegate = self;
            [_bannerCell.cycleScrollView setPlaceHolderImage:@"banner_default"];
            
            _bannerCell.banners = obj;
            return _bannerCell;
        }else{
            return nil;
        }
    }
    else if([obj isKindOfClass:[HYBFirstStore class]]){
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


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = self.dataArray[indexPath.section];
    
    CGFloat width = CGRectGetWidth(collectionView.bounds);
    
    id obj;
    if([array count]>0){
        obj = array[indexPath.row];
    }
    if([obj isKindOfClass:[HYBAdvertisement class]])
    {
        CGSize size = CGSizeMake(width, width * heightWidthRatio);
        return size;
    }else if([obj isKindOfClass:[HYBFirstStore class]]){
        CGSize size = CGSizeMake(width, 118.0f);
        return size;
    }else if([obj isKindOfClass:[HYBStore class]]){
        CGSize size = CGSizeMake(width, 108.0f);
        return size;
    }
    else
    {
        CGFloat heig = 0;
        if([obj count] > 4)
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
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0F, 0.0F, 0.0F, 0.0F);
}

// 定义headview的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 1 && [_dataArray[1] count]>0) {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40.5f);
    }else if(section == 2){
        return CGSizeMake(CGRectGetWidth(collectionView.bounds), 40.5f);
    }
    else {
        return CGSizeZero;
    }
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
    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    self.navigationBar.leftButton.titleLabel.text = [GVUserDefaults standardUserDefaults].cityname;
    [self refreshData];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void) gotoStoreDetail:(HYBStoreCell *)cell withStore:(HYBStore *)store{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBStoreDetailViewController *pushController = [[HYBStoreDetailViewController alloc] initWithStore:store];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void) gotoFirstStoreDetail:(HYBFirstStoreCell *)cell withStore:(HYBFirstStore *)store{
    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    HYBStoreDetailViewController *pushController = [[HYBStoreDetailViewController alloc] initWithFirstStore:store];
    [self.navigationController pushViewController:pushController animated:YES];
}

//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        [GVUserDefaults standardUserDefaults].longitude = [NSString stringWithFormat:@"%f", result.location.longitude];
        [GVUserDefaults standardUserDefaults].latitude = [NSString stringWithFormat:@"%f", result.location.latitude];
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      self.navigationBar.leftButton.titleLabel.text = result.addressDetail.city;
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}

//不使用时将delegate设置为 nil
-(void)viewWillDisappear:(BOOL)animated
{
    _searcher.delegate = nil;
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [GVUserDefaults standardUserDefaults].longitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude];
    [GVUserDefaults standardUserDefaults].latitude = [NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude];

    [self reversegeocode];
    
    [self requestData];
    
    [_locationManager stopUpdatingLocation];
}

@end
