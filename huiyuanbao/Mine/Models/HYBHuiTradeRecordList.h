//
//  HYBHuiTradeRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define HUITRADE_RECORD @"of/recharge/queryLifeOrder"
@interface HYBHuiTradeRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *huiTradeRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
