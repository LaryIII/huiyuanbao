//
//  HYBOrderRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBOrderRecord : CXResource
@property (nonatomic, strong) NSString *orderid;//订单id
@property (nonatomic, strong) NSString *merchant_img;//商家logo
@property (nonatomic, strong) NSString *merchant_name;//商家名称
@property (nonatomic, strong) NSString *discount;//折扣
@property (nonatomic, strong) NSString *remark;//备注
@property (nonatomic, strong) NSString *product_price;//商品价格
@property (nonatomic, strong) NSString *order_time;//下单时间
@property (nonatomic, strong) NSString *merchant_phone;//商户电话
@property (nonatomic, strong) NSString *logocheck;
@property (nonatomic, strong) NSString *product_name;//商品名称
@property (nonatomic, strong) NSString *product_number;//商品数量
@property (nonatomic, strong) NSString *earnestmoney;//定金
@property (nonatomic, strong) NSString *reserve_time;//预约时间
@property (nonatomic, strong) NSString *product_id;//产品id
@property (nonatomic, strong) NSString *yuding_order_id;//预约单号
@property (nonatomic, strong) NSString *disable_time;//失效时间
@property (nonatomic, strong) NSString *pkmuser;//商户主键
@property (nonatomic, strong) NSString *isdefault;//1：折扣2优惠
@property (nonatomic, strong) NSString *merchant_adress;//商家地址
@property (nonatomic, strong) NSString *product_total;//商品原价
@property (nonatomic, strong) NSString *status;//订单状态  1.2：预约成功   3：已取消   4：已失效5：预约中    6.8: 去支付  7：商品售罄   9:退款中    10：退款成功   11：拒绝退款
@end
