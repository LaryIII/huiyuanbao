//
//  HYBMsgList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBMsgList.h"
#import "HYBMsg.h"

@implementation HYBMsgList
- (instancetype)initWithBaseURL:(NSURL *)url path:(NSString *)path
{
    self.isInfinite = false;
    return [self initWithBaseURL:url path:path cachePolicyType:kCachePolicyTypeReturnCacheDataOnError];
}

- (instancetype)initWithBaseURL:(NSURL *)url path:(NSString *)path cachePolicyType:(CachePolicyType)cachePolicyType
{
    self = [super initWithBaseURL:url path:path cachePolicyType:cachePolicyType];
    if (self) {
        self.page = 1;
    }
    self.isInfinite = false;
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        
        if (self.msgs) {
            [self.msgs removeAllObjects];
        }
        else {
            self.msgs = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBMsg *msg = [[HYBMsg alloc] initWithValues:dictionary];
            [self.msgs addObject:msg];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
