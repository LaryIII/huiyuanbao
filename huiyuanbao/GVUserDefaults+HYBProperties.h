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

@property (nonatomic, weak) NSString *userId;
@property (nonatomic, weak) NSString *cpuid;
@property (nonatomic, weak) NSString *phoneno;

@end
