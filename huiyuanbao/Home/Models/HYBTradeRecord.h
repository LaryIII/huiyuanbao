//
//  HYBTradeRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define TRADE_RECORD @"merchant/getMerchantTrade"
@interface HYBTradeRecord : CXResource
@property (nonatomic, strong) NSString *balancepay;//交易金额
@property (nonatomic, strong) NSString *createtime;//交易时间
@property (nonatomic, strong) NSString *rechargestatus;// 1,
@property (nonatomic, strong) NSString *couponpay;//优惠券支付
@property (nonatomic, strong) NSString *wealmoney;//消费充值返红包
@property (nonatomic, strong) NSString *rechargecode;//   status=2(充值) 0 未完成 1 已完成 2 充值异常 3 充值失败 4 充值取消status=1(消费) 1 已支付2 未支付3 支付失败4 支付取消 5 支付异常


@property (nonatomic, strong) NSString *wealpay;//红包支付
@property (nonatomic, strong) NSString *status;//1：消费  2：充值
@end
