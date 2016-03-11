//
//  HYBOrderRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define ORDER_LIST @"merchant/getOrderList"
@interface HYBOrderRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *orderRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
