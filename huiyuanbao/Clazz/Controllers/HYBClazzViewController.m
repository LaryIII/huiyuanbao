//
//  HYBClazzViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/24.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBClazzViewController.h"
#import "ZButton.h"
#import "HYBStore2.h"
#import "HYBStore2Cell.h"
#import "masonry.h"

@interface HYBClazzViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,HYBStore2CellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HYBClazzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"分类";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    [self addLeftNavigatorButton];
    
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
    
    UIView *filterbar = UIView.new;
    filterbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filterbar];
    [filterbar makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchBox.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *btn1 = UIButton.new;
    btn1.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn1 setTitle:@"全部" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btn1.layer.borderColor = RGB(232, 232, 232).CGColor;
    btn1.layer.borderWidth = 0.5;
    [btn1 addTarget:self action:@selector(denys) forControlEvents:UIControlEventTouchUpInside];
    [filterbar addSubview:btn1];
    btn1.backgroundColor = [UIColor whiteColor];
    
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(filterbar.left);
        make.width.mas_equalTo(width/2);
        make.bottom.equalTo(filterbar.bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *arrow1 = UIImageView.new;
    [arrow1 setImage:[UIImage imageNamed:@"filter_arrow"]];
    [btn1 addSubview:arrow1];
    [arrow1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.top).offset(15);
        make.right.equalTo(btn1.right).offset(-8);
    }];

    UIButton *btn2 = UIButton.new;
    btn2.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [btn2 setTitle:@"智能排序" forState:UIControlStateNormal];
    [btn2 setTitleColor:RGB(0, 0, 0) forState:UIControlStateNormal];
    btn2.layer.borderColor = RGB(232, 232, 232).CGColor;
    btn2.layer.borderWidth = 0.5;
    [btn2 addTarget:self action:@selector(accepts) forControlEvents:UIControlEventTouchUpInside];
    [filterbar addSubview:btn2];
    btn2.backgroundColor = [UIColor whiteColor];
    
    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.right);
        make.width.mas_equalTo(width/2);
        make.bottom.equalTo(filterbar.bottom);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *arrow2 = UIImageView.new;
    [arrow2 setImage:[UIImage imageNamed:@"filter_arrow"]];
    [btn2 addSubview:arrow2];
    [arrow2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn2.top).offset(15);
        make.right.equalTo(btn2.right).offset(-8);
    }];
    
    
    UIView *lineView1 = UIView.new;
    lineView1.backgroundColor = RGB(204, 204, 204);
    [filterbar addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterbar.top);
        make.left.equalTo(filterbar.left).offset(width/2);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(44);
    }];
    
    UIView *lineView2 = UIView.new;
    lineView2.backgroundColor = RGB(204, 204, 204);
    [filterbar addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(filterbar.bottom).offset(-0.5);
        make.left.equalTo(filterbar.left).offset(0);
        make.right.equalTo(filterbar.right).offset(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight+46+44, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight-46-44) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = RGB(240, 240, 240);
    //    [_collectionView setBackgroundColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:213/255.0 alpha:1]];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[HYBStore2Cell class] forCellWithReuseIdentifier:@"HYBStore2Cell"];
    
    //test data
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:[NSMutableArray array]];
    NSMutableArray *storeList = [[NSMutableArray alloc] init];
    HYBStore2 *store = HYBStore2.new;
    [storeList addObject:store];
    [self.dataArray[0] addObject:storeList];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)leftButtonTapped:(id)sender
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
        
        if([obj isKindOfClass:[HYBStore2 class]]){
            HYBStore2Cell *storeCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBStore2Cell" forIndexPath:indexPath];
            HYBStore2 *temp = (HYBStore2 *)obj;
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
            
            if([obj isKindOfClass:[HYBStore2 class]]){
                CGSize size = CGSizeMake(width, 108.0f);
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

