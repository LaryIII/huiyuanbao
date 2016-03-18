//
//  HYBOrderProductViewController.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXNavigationBarController.h"
#import "HYBStoreProduct.h"
#import "HYBStore.h"

@interface HYBOrderProductViewController : CXNavigationBarController
- (instancetype)initWithProduct:(HYBStoreProduct *)product withStore:(HYBStore *)store;
@end
