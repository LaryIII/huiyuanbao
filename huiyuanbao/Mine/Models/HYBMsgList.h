//
//  HYBMsgList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define MSG_LIST @"push/getPushList"
@interface HYBMsgList : CXResource
@property (nonatomic, strong) NSMutableArray *msgs;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
