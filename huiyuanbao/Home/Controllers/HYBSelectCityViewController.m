//
//  HYBSelectCityViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/28.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBSelectCityViewController.h"
#import "masonry.h"
#import "HYBSearchCityViewController.h"
#import "HYBCityNameCell.h"
#import "HYBCityName.h"
#import "HYBCityLetterCell.h"
#import "HYBCityNameList.h"
#import "ChineseStringForCity.h"
#import "HYBCities.h"

@interface HYBSelectCityViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, HYBCityNameCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HYBCities *cities;
@property (nonatomic, strong) NSMutableArray *letterArr;
@property (nonatomic, strong) NSMutableArray *sortCitiesArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) NSMutableArray *letterCellsIndexPath;

@end

@implementation HYBSelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"选择城市 - 南京";
    self.view.backgroundColor = RGB(240, 240, 240);
    
//    [self addLeftNavigatorButton];
    
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
    placeholder.text = @"城市首字母/名称";
    [searchBtn addSubview:placeholder];
    [placeholder makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBtn.top).offset(8);
        make.left.equalTo(searchicon.right).offset(6);
    }];
    
    UIView *title1 = UIView.new;
    title1.backgroundColor = RGB(235,235,235);
    [self.view addSubview: title1];
    [title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(self.navigationBarHeight+46.0f);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *t_title1 = UILabel.new;
    t_title1.textAlignment = NSTextAlignmentCenter;
    t_title1.textColor = RGB(136, 136, 136);
    t_title1.font = [UIFont systemFontOfSize:14.0f];
    t_title1.text = @"热门城市";
    [title1 addSubview:t_title1];
    [t_title1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.top).offset(7);
        make.left.equalTo(title1.left).offset(15);
    }];
    
    UIView *btn1s = UIView.new;
    btn1s.backgroundColor = [UIColor clearColor];
    [self.view addSubview:btn1s];
    [btn1s makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title1.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(15*5+37*4);
    }];
    
    NSArray *cities = @[@{@"name":@"北京",@"id":@1},@{@"name":@"重庆",@"id":@2},@{@"name":@"广州",@"id":@3},@{@"name":@"成都",@"id":@4},@{@"name":@"南京",@"id":@5},@{@"name":@"杭州",@"id":@6},@{@"name":@"上海",@"id":@7},@{@"name":@"深圳",@"id":@8},@{@"name":@"天津",@"id":@9},@{@"name":@"武汉",@"id":@10},@{@"name":@"西安",@"id":@11},@{@"name":@"阜阳",@"id":@12}];
    for(int i=0;i<cities.count;i++){
        UIButton *btn = UIButton.new;
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitle:[cities[i] objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(51,51,51) forState:UIControlStateNormal];
        btn.layer.borderColor = RGB(216, 216, 216).CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 2.0;
        btn.tag = 10001+i;
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(btn1clicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn1s addSubview:btn];
        int btnw = (width-30-30)/3;
        if(i<3){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15);
                make.left.mas_equalTo((btnw+15)*i+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(37);
            }];
        }else if(i>=3 && i<6){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15*2+37);
                make.left.mas_equalTo((btnw+15)*(i-3)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(37);
            }];
        }else if(i>=6 && i<9){
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15*3+37*2);
                make.left.mas_equalTo((btnw+15)*(i-6)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(37);
            }];
        }else{
            [btn makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(btn1s.top).offset(15*4+37*3);
                make.left.mas_equalTo((btnw+15)*(i-9)+15);
                make.width.mas_equalTo(btnw);
                make.height.mas_equalTo(37);
            }];
        }
        
        UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+30+15*5+37*4, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-30-(15*5+37*4)) collectionViewLayout:collectionViewFlowLayout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _collectionView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_collectionView];
        
        // 字母和联系人是重复可添加的，参照小金库的controller来
        self.cities = [[HYBCities alloc] init];
        //    [self.contacts addPeople];
        NSMutableArray *cities = [self.cities getCities];
        NSArray *cityArr = [cities mutableCopy];
        NSMutableArray * array = [ChineseStringForCity IndexArray:cityArr];
        NSMutableArray *letterResultArr = [ChineseStringForCity LetterSortArray:cityArr];
        self.letterArr = array;
        self.sortCitiesArr = letterResultArr;
        
        [_collectionView registerClass:[HYBCityLetterCell class] forCellWithReuseIdentifier:@"HYBCityLetterCell"];
        [_collectionView registerClass:[HYBCityNameCell class] forCellWithReuseIdentifier:@"HYBCityNameCell"];
        
        _dataArray = [NSMutableArray array];
        
        //    NSArray *arr = @[@0];
        //    [self.dataArray addObject:arr];
        
        for(HYBCityNameList * obj in self.sortCitiesArr){
            NSArray *t = [NSArray arrayWithObject:obj.pinYin];
            [self.dataArray addObject:t];
            [self.dataArray addObject:obj.cities];
        }
        
        // 增加字母索引侧边栏
        CGFloat width = CGRectGetWidth(self.collectionView.bounds);
        CGFloat height = CGRectGetHeight(self.collectionView.bounds);
        UIView *letterBar = [[UIView alloc] initWithFrame:CGRectMake(width-30.0f, 150.0f, 30.0f, height-150.0f)];
        NSUInteger count = array.count;
        for(int i=0; i<count;i++){
            UIButton *l = [[UIButton alloc] initWithFrame:CGRectMake(0, i*20.0f, 30.0f, 20.0f)];
            [l setTitleColor:[UIColor colorWithRed:0.55f green:0.55f blue:0.57f alpha:1.0] forState:UIControlStateNormal];
            l.titleLabel.font = [UIFont systemFontOfSize: 14.0];
            NSString *s = [array objectAtIndex:i];
            [l setTitle:s forState:UIControlStateNormal];
            [l addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            l.tag = i;
            [letterBar addSubview:l];
        }
        [self.view addSubview:letterBar];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)search{
    HYBSearchCityViewController *pushController = [[HYBSearchCityViewController alloc] init];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(void)btn1clicked:(id)sender{
    
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
    id object = array[indexPath.row];
    
    if ([object isKindOfClass:[HYBCityName class]]) {
        HYBCityNameCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCityNameCell" forIndexPath:indexPath];
        HYBCityName *temp =(HYBCityName *)object;
        cell.city = temp;
        cell.delegate = self;
        return cell;
        
    }else if([object isKindOfClass:[NSString class]]){
        HYBCityLetterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBCityLetterCell" forIndexPath:indexPath];
        [self.letterCellsIndexPath addObject:indexPath];
        NSString *temp =(NSString *)object;
        cell.letter = temp;
        return cell;
    }else{
        return nil;
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
// 定义cell的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = CGRectGetWidth(self.collectionView.bounds);
    if(indexPath.section%2 == 0) {
        return CGSizeMake(width, 25);
    }else{
        return CGSizeMake(width, 40);
    }
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0F, 0.0F, 0.0F, 0.0F);
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
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

@end

