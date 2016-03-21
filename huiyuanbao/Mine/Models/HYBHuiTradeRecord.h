//
//  HYBHuiTradeRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
@interface HYBHuiTradeRecord : CXResource
@property (nonatomic, strong) NSString *pk_hyb_of_order_id;//订单id
@property (nonatomic, strong) NSString *pkregister;//订单号
@property (nonatomic, strong) NSString *mobile;//手机号
@property (nonatomic, strong) NSString *rebate_money;//返现
@property (nonatomic, strong) NSString *order_time;//下单时间
@property (nonatomic, strong) NSString *realmoney;//实际金额
@property (nonatomic, strong) NSString *game_name;//消费名称
@property (nonatomic, strong) NSString *consume_child_type;//0：手机充值；1：中石油；2中石化
@property (nonatomic, strong) NSString *rate;//返利比例：100:1
@property (nonatomic, strong) NSString *consume_type;//消费类型 1 手机充值 2 油卡充值   3 固话 4 QQ服务 5 流量充值
@property (nonatomic, strong) NSString *total_money;//消费金额
@property (nonatomic, strong) NSString *gascard_code;//OF订单号
@property (nonatomic, strong) NSString *status;//订单状态：0处理中；1成功 ；9：澈消(充值失败)；-1找不到此订单-1；2订单异常
@end
