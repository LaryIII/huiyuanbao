//
//  HYBHuiTradeRecordList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHuiTradeRecordList.h"
#import "HYBHuiTradeRecord.h"

@implementation HYBHuiTradeRecordList
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
        
        if (self.huiTradeRecords) {
            [self.huiTradeRecords removeAllObjects];
        }
        else {
            self.huiTradeRecords = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBHuiTradeRecord *huiTradeRecord = [[HYBHuiTradeRecord alloc] initWithValues:dictionary];
            [self.huiTradeRecords addObject:huiTradeRecord];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
