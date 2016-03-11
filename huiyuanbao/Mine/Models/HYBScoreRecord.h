//
//  HYBScoreRecord.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBScoreRecord : CXResource
@property (nonatomic, strong) NSString *createtime;//时间
@property (nonatomic, strong) NSString *pointtype;//1 充值获取 2 消费获取 3 消费扣除 4 系统发送
@property (nonatomic, strong) NSString *point;//积分数量
@end
