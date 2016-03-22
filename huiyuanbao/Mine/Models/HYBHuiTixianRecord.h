//
//  HYBHuiTixianRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBHuiTixianRecord : CXResource
@property (nonatomic, strong) NSString *bankuserphone;//手机号
@property (nonatomic, strong) NSString *amount;//提现金额
@property (nonatomic, strong) NSString *balance;//
@property (nonatomic, strong) NSString *bankusername;//姓名
@property (nonatomic, strong) NSString *apply_time;//提现时间
@property (nonatomic, strong) NSString *bankname;//银行
@property (nonatomic, strong) NSString *checker;
@property (nonatomic, strong) NSString *bankcardno;//银行卡号
@property (nonatomic, strong) NSString *status;//1：提现中，2是完成，3是取消
@property (nonatomic, strong) NSString *check_time;
@end
