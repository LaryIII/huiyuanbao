//
//  HYBQueryBalance.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define QUERY_BALANCE @"recharge/queryBalacne"
@interface HYBQueryBalance : CXResource
@property (nonatomic, strong) NSString *balance;//系统余额
@property (nonatomic, strong) NSString *interest;//昨日返利
@property (nonatomic, strong) NSString *wholebalance;//账户总余额
@property (nonatomic, strong) NSString *pkmuser;//商户主键
@property (nonatomic, strong) NSString *userId;//用户主键
@property (nonatomic, strong) NSString *point;//总积分
@end
