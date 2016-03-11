//
//  HYBStoreXiaofeiRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBStoreXiaofeiRecord : CXResource
@property (nonatomic, strong) NSString *order_no;//预约订单编号
@property (nonatomic, strong) NSString *amount;//总金额
@property (nonatomic, strong) NSString *couponpay;//优惠券支付金额
@property (nonatomic, strong) NSString *amounttime;//消费时间
@property (nonatomic, strong) NSString *wealpay;//红包支付金额
@property (nonatomic, strong) NSString *userId;//用户主键
@property (nonatomic, strong) NSString *phoneno;//用户手机号
@property (nonatomic, strong) NSString *point;//消费使用积分
@property (nonatomic, strong) NSString *amounttype;//消费类型 1 余额支付，0 非余额支付
@property (nonatomic, strong) NSString *balancepay;//余额支付金额
@property (nonatomic, strong) NSString *muname;//商家名称
@property (nonatomic, strong) NSString *trade_typename;//消费项目
@property (nonatomic, strong) NSString *logo;//商家logo
@property (nonatomic, strong) NSString *pkmuser;//商家主键
@property (nonatomic, strong) NSString *amountstatus;//1 已支付2 未支付3 支付失败4 支付取消 5 支付异常
@property (nonatomic, strong) NSString *payment;//1 支付宝 2 财付通 3 百度钱包 4 网银 5余额支付 6 微信支付 7现金支付  8 其他支付

@end
