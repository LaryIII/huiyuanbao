//
//  HYBSearchCityViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBSearchCityViewController.h"
#import "masonry.h"
#import "HYBCityCell.h"
#import "HYBCity.h"
#import "HYBCityList.h"
#import "HYBCities.h"
#import "ChineseStringForCity.h"
#import "HYBCityNameList.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#import "GVUserDefaults+HYBProperties.h"

@interface HYBSearchCityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBCityCellDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITextField *cityinput;
@property (nonatomic, strong) HYBCities *cities;
@property (nonatomic, strong) NSMutableArray *sortCitiesArr;

@property (nonatomic, strong) NSArray *citiesx;

@end

@implementation HYBSearchCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(255, 255, 255);
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UIView *searchBox = UIView.new;
    searchBox.backgroundColor = MAIN_COLOR;
    [self.view addSubview:searchBox];
    [searchBox makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navigationBar.bottom).offset(-46);
        make.left.equalTo(self.view.left).offset(0);
        make.right.equalTo(self.view.right).offset(0);
        make.height.mas_equalTo(46);
    }];
    
    UIButton *cancelBtn = UIButton.new;
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    cancelBtn.backgroundColor = [UIColor clearColor];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBox.top).offset(8);
        make.right.equalTo(searchBox.right).offset(-7);
    }];
    
    UIButton *searchBtn = UIButton.new;
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.cornerRadius = 5.0f;
    [self.view addSubview:searchBtn];
    [searchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBox.top).offset(8);
        make.left.equalTo(searchBox.left).offset(8);
        make.right.equalTo(searchBox.right).offset(-45);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *searchicon = UIImageView.new;
    [searchicon setImage:[UIImage imageNamed:@"search"]];
    [searchBtn addSubview:searchicon];
    [searchicon makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.top).offset(8);
        make.left.equalTo(searchBtn.left).offset(8);
        make.width.mas_equalTo(13.0f);
        make.height.mas_equalTo(14.0f);
    }];
    
    _cityinput = UITextField.new;
    [_cityinput setClearButtonMode:UITextFieldViewModeWhileEditing];//右侧删除按钮
    _cityinput.leftViewMode=UITextFieldViewModeAlways;
    _cityinput.placeholder=@"城市首字母/名称";//默认显示的字
    _cityinput.keyboardType=UIKeyboardTypeDefault;//设置键盘类型为默认的
    _cityinput.returnKeyType=UIReturnKeyDone;//返回键的类型
    _cityinput.font = [UIFont systemFontOfSize:12.0f];
    _cityinput.textColor = RGB(102, 102, 102);
    _cityinput.delegate=self;//设置委托
    _cityinput.tag = 30002;
    [_cityinput addTarget:self action:@selector(searchBegin) forControlEvents: UIControlEventTouchDown];
    [_cityinput addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [searchBtn addSubview:_cityinput];
    [_cityinput makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.top).offset(6);
        make.left.equalTo(searchicon.right).offset(6);
        make.right.equalTo(searchBtn.right).offset(2);
        
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBCityCell class] forCellWithReuseIdentifier:@"HYBCityCell"];
    
    //test data
    self.dataArray = [NSMutableArray array];
//    [self.dataArray addObject:[NSMutableArray array]];
//    HYBCityList *cities = HYBCityList.new;
//    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    HYBCity *o1 = HYBCity.new;
//    HYBCity *o2 = HYBCity.new;
//    [arr addObject:o1];
//    [arr addObject:o2];
//    cities.cities = arr;
//    [_dataArray[0] addObjectsFromArray:cities.cities];
    
    // 字母和联系人是重复可添加的，参照小金库的controller来
    self.cities = [[HYBCities alloc] init];
    //    [self.contacts addPeople];
    NSMutableArray *citiesx = [self.cities getCities];
    NSArray *cityArr = [citiesx mutableCopy];
    NSMutableArray * array = [ChineseStringForCity IndexArray:cityArr];
    NSMutableArray *letterResultArr = [ChineseStringForCity LetterSortArray:cityArr];
    self.sortCitiesArr = letterResultArr;
    
    [_collectionView registerClass:[HYBCityCell class] forCellWithReuseIdentifier:@"HYBCityCell"];
    
    self.dataSource = [NSMutableArray array];
    
//        NSArray *arr = @[];
//        [self.dataArray addObject:arr];
//
    [self.dataSource addObject:[NSMutableArray array]];
    for(HYBCityNameList * obj in self.sortCitiesArr){
        [self.dataSource[0] addObjectsFromArray:obj.cities];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if([obj isKindOfClass:[HYBCityName class]]){
        HYBCityCell *cityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCityCell" forIndexPath:indexPath];
        HYBCityName *temp = (HYBCityName *)obj;
        cityCell.city = temp;
        cityCell.delegate = self;
        return cityCell;
    }else{
        HYBCityCell *cityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCityCell" forIndexPath:indexPath];
        HYBCity *temp = (HYBCity *)obj;
        cityCell.city = temp;
        cityCell.delegate = self;
        return cityCell;
    }
}


#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    return CGSizeMake(width, 44.0f);
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [[self rdv_tabBarController] setTabBarHidden:NO animated:NO];
    //    [self refreshData];
}

-(void)cancel{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)valueChanged:(id)sender{
//    [self.array removeAllObjects];
    [self.dataArray removeAllObjects];
    NSLog(@"dataArray1:%@",self.dataArray);
//    NSLog(@"tempDataArray1:%@",self.tempDataArray);
    if (_cityinput.text.length>0) {
        for (int i=0; i<self.dataSource.count; i++) {
//            if(i%2 == 1){
                NSMutableArray *innerArray = self.dataSource[i];
                NSMutableArray *tempInnerArray = [[NSMutableArray alloc]init];
                for (int j=0; j<innerArray.count; j++) {
                    NSString *keyStr = @"";
                    if([innerArray[j] isKindOfClass:[HYBCityName class]]){
                        HYBCityName *temp = innerArray[j];
                        keyStr = temp.name;
                    }else{
                        keyStr = innerArray[j];
                    }
                    if (![ChineseInclude isIncludeChineseInString:_cityinput.text]){
                        if ([ChineseInclude isIncludeChineseInString:keyStr]) {
                            NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:keyStr];
                            NSRange titleResult=[tempPinYinStr rangeOfString:_cityinput.text options:NSCaseInsensitiveSearch];
                            if (titleResult.length>0) {
                                [tempInnerArray addObject:innerArray[j]];
                            }
                        }
                        else {
                            NSRange titleResult=[keyStr rangeOfString:_cityinput.text options:NSCaseInsensitiveSearch];
                            if (titleResult.length>0) {
                                [tempInnerArray addObject:innerArray[j]];
                            }
                        }
                    }else{
                        NSRange titleResult=[keyStr rangeOfString:_cityinput.text options:NSLiteralSearch];
                        if (titleResult.length>0) {
                            [tempInnerArray addObject:innerArray[j]];
                        }
                    }
                    
                }
                if(tempInnerArray.count > 0){
//                    [self.dataArray addObject:self.dataSource[i-1]];
//                    [self.array addObject:self.tempDataArray[i-1][0]];
                    [self.dataArray addObject:tempInnerArray];
                }
            }
        
//        }
    }
    NSLog(@"dataArray2:%@",self.dataArray);
//    NSLog(@"tempDataArray2:%@",self.tempDataArray);
    [self.collectionView reloadData];
}

-(void)searchBegin{
    
}

-(void) gotoCity:(HYBCityCell *)cell withCity:(HYBCityName *)city{
    [GVUserDefaults standardUserDefaults].citycode = city.code;
    [GVUserDefaults standardUserDefaults].cityname = city.name;
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
