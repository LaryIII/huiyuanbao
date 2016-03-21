//
//  HYBHuiChargeRecordList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHuiChargeRecordList.h"
#import "HYBHuiChargeRecord.h"

@implementation HYBHuiChargeRecordList
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
        
        if (self.huiChargeRecords) {
            [self.huiChargeRecords removeAllObjects];
        }
        else {
            self.huiChargeRecords = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBHuiChargeRecord *huiChargeRecord = [[HYBHuiChargeRecord alloc] initWithValues:dictionary];
            [self.huiChargeRecords addObject:huiChargeRecord];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
