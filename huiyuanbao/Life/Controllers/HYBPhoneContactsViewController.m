//
//  HYBPhoneContactsViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/11.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBPhoneContactsViewController.h"
#import "HYBPhoneContactsCell.h"
#import "HYBContactLetterCell.h"
#import "HYBContacts.h"
#import "ChineseString.h"
#import "HYBPhoneContactList.h"
#import "HYBPhoneContact.h"


@interface HYBPhoneContactsViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, HYBPhoneContactsCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) HYBContacts *contacts;
@property (nonatomic, strong) NSMutableArray *letterArr;
@property (nonatomic, strong) NSMutableArray *sortContactsArr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *okButton;

@property (nonatomic, strong) NSMutableArray *selectedContacts;
@property (nonatomic, strong) NSMutableArray *selectedContactCells;

@property (nonatomic, strong) NSMutableArray *letterCellsIndexPath;

@end

@implementation HYBPhoneContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(250, 250, 250);
    
    self.navigationBar.title = @"其他号码";
    self.selectedContacts = [[NSMutableArray alloc] init];
    self.selectedContactCells = [[NSMutableArray alloc] init];
    self.letterCellsIndexPath = [[NSMutableArray alloc] init];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0.0f, self.navigationBarHeight, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - self.navigationBarHeight) collectionViewLayout:collectionViewFlowLayout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_collectionView];
    
    // 字母和联系人是重复可添加的，参照小金库的controller来
    self.contacts = [[HYBContacts alloc] init];
    //    [self.contacts addPeople];
    NSMutableArray *contact = [self.contacts getAddress];
    NSArray *contactArr = [contact mutableCopy];
    NSMutableArray * array = [ChineseString IndexArray:contactArr];
    NSMutableArray *letterResultArr = [ChineseString LetterSortArray:contactArr];
    self.letterArr = array;
    self.sortContactsArr = letterResultArr;
    
    [_collectionView registerClass:[HYBContactLetterCell class] forCellWithReuseIdentifier:@"HYBContactLetterCell"];
    [_collectionView registerClass:[HYBPhoneContactsCell class] forCellWithReuseIdentifier:@"HYBPhoneContactsCell"];
    
    _dataArray = [NSMutableArray array];
    
//    NSArray *arr = @[@0];
//    [self.dataArray addObject:arr];
    
    for(HYBPhoneContactList * obj in self.sortContactsArr){
        NSArray *t = [NSArray arrayWithObject:obj.pinYin];
        [self.dataArray addObject:t];
        [self.dataArray addObject:obj.contacts];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self hideLoadingView];
}

- (void)clickAction:(UIButton *)sender{
    // 滚动到相应位置
    //    NSLog(@"当前按钮所在的cell，在表中的位置为第%ld区，第%ld行，tag为%d",(long)indexPath.section,(long)indexPath.row, sender.tag);
    [self.collectionView scrollToItemAtIndexPath:[self.letterCellsIndexPath objectAtIndex:sender.tag]
                                atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                        animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)dealloc
{
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
    
    if ([object isKindOfClass:[HYBPhoneContact class]]) {
        HYBPhoneContactsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBPhoneContactsCell" forIndexPath:indexPath];
        HYBPhoneContact *temp =(HYBPhoneContact *)object;
        cell.contact = temp;
        cell.delegate = self;
        return cell;
        
    }else if([object isKindOfClass:[NSString class]]){
        HYBContactLetterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HYBContactLetterCell" forIndexPath:indexPath];
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

