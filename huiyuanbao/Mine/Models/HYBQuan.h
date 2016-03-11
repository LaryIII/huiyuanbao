//
//  HYBQuan.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBQuan : CXResource
@property (nonatomic, strong) NSString *wealmoney;
@property (nonatomic, strong) NSString *endtime;//过期时间
@property (nonatomic, strong) NSString *starttime;//发送时间
@property (nonatomic, strong) NSString *title;//优惠劵标题
@property (nonatomic, strong) NSString *userId;//用户id
@property (nonatomic, strong) NSString *phoneno;//用户手机号
@property (nonatomic, strong) NSString *wealstatus;//0不可用，1未消费 2已消费
@property (nonatomic, strong) NSString *phone;//商户手机号
@property (nonatomic, strong) NSString *muname;//商家名称
@property (nonatomic, strong) NSString *expirestatus;//1未过期 2 已过期
@property (nonatomic, strong) NSString *logo;//商户logo
@property (nonatomic, strong) NSString *mzmoney;//满消费额度后可用
@property (nonatomic, strong) NSString *pkmuser;//商户id
@property (nonatomic, strong) NSString *validatecode;//优惠劵码
@end
