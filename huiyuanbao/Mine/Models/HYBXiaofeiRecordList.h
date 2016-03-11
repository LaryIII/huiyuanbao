//
//  HYBXiaofeiRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define HUIYUANBAO_XIAOFEILIST @"of/recharge/queryLifeOrder"
@interface HYBXiaofeiRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *xiaofeiRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
