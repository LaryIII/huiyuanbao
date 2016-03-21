//
//  HYBHuiChargeRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define HUICHARGE_RECORD @"recharge/queryRechargeSystem"
@interface HYBHuiChargeRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *huiChargeRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
