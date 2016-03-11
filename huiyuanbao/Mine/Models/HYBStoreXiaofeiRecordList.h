//
//  HYBStoreXiaofeiRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define STORE_XIAOFEILIST @"recharge/selectConsume"
@interface HYBStoreXiaofeiRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *storeXiaofeiRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
