//
//  GVUserDefaults+HYBProperties.h
//  huiyuanbao
//
//  Created by zhouhai on 15/1/26.
//  Copyright (c) 2015年 huiyuanbao. All rights reserved.
//

#import "GVUserDefaults.h"


@interface GVUserDefaults (HYBProperties)

@property (nonatomic, weak) NSString *token;
@property (nonatomic, weak) NSString *refreshToken;
@property (nonatomic, weak) NSString *expire;

@property (nonatomic, weak) NSString *sid;
@property (nonatomic, weak) NSString *name;
@property (nonatomic, weak) NSString *nick;
@property (nonatomic, weak) NSString *summary;
@property (nonatomic, weak) NSString *gender;
@property (nonatomic, weak) NSString *region;
@property (nonatomic, weak) NSString *wechat;
@property (nonatomic, weak) NSString *avatar;
@property (nonatomic, weak) NSString *type;

@property (nonatomic, weak) NSDictionary *plan;
@property (nonatomic, weak) NSDictionary *sailors;
@property (nonatomic, weak) NSDictionary *armada;
@property (nonatomic, weak) NSDictionary *field;

@property (nonatomic, weak) NSDictionary *startups;
@property (nonatomic, weak) NSDictionary *education;
@property (nonatomic, weak) NSDictionary *work;

@property (nonatomic, weak) NSString *epicsid;
@property (nonatomic, weak) NSString *epicsummary;
@property (nonatomic, weak) NSNumber *epicjointime;
@property (nonatomic, weak) NSString *epicworktime;
@property (nonatomic, weak) NSString *plansid;

@property (nonatomic, weak) NSString *isFirst;

@end
