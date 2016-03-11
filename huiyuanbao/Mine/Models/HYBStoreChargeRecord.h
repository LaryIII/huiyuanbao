//
//  HYBStoreChargeRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBStoreChargeRecord : CXResource
@property (nonatomic, strong) NSString *createtime;//充值时间
@property (nonatomic, strong) NSString *balance;//充值金额
@property (nonatomic, strong) NSString *muname;//商家名称
@property (nonatomic, strong) NSString *rechargecode;//1 支付宝 2 财付通 3 百度钱包 4 网银 5余额支付 6 微信支付 7现金支付  8 其他支付
@property (nonatomic, strong) NSString *logo;//商家Logo
@property (nonatomic, strong) NSString *pkmuser;//商户主键
@property (nonatomic, strong) NSString *rechargetype;//充值方式
@property (nonatomic, strong) NSString *pkrecharge;//充值编号
@property (nonatomic, strong) NSString *userId;//用户主键
@property (nonatomic, strong) NSString *phoneno;//用户名
@property (nonatomic, strong) NSString *status;//0 未完成 1 已完成 2 充值异常 3 充值失败
@property (nonatomic, strong) NSString *cashback;//充值返红包
@end
