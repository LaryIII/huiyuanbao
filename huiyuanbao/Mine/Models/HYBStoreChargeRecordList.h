//
//  HYBStoreChargeRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define STORE_CHARGELIST @"recharge/selectRecharge"
@interface HYBStoreChargeRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *storeChargeRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
