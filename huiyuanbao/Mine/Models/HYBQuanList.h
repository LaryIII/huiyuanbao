//
//  HYBQuanList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define QUAN_LIST @"recharge/selectWealOrCoupon"
@interface HYBQuanList : CXResource
@property (nonatomic, strong) NSMutableArray *quans;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
