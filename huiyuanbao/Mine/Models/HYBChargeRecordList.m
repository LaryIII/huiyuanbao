//
//  HYBChargeRecordList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBChargeRecordList.h"
#import "HYBChargeRecord.h"

@implementation HYBChargeRecordList
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
        
        if (self.chargeRecords) {
            [self.chargeRecords removeAllObjects];
        }
        else {
            self.chargeRecords = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBChargeRecord *chargeRecord = [[HYBChargeRecord alloc] initWithValues:dictionary];
            [self.chargeRecords addObject:chargeRecord];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
