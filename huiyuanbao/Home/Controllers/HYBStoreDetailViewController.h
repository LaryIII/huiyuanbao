//
//  HYBStoreDetailViewController.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXNavigationBarController.h"
#import "HYBStore.h"
#import "HYBFirstStore.h"

@interface HYBStoreDetailViewController : CXNavigationBarController
- (instancetype)initWithStore:(HYBStore *)store;
- (instancetype)initWithFirstStore:(HYBFirstStore *)store;
@end
