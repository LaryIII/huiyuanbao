//
//  HYBStoreXiaofeiRecordList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/12.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreXiaofeiRecordList.h"
#import "HYBStoreXiaofeiRecord.h"

@implementation HYBStoreXiaofeiRecordList
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
        
        if (self.storeXiaofeiRecords) {
            [self.storeXiaofeiRecords removeAllObjects];
        }
        else {
            self.storeXiaofeiRecords = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBStoreXiaofeiRecord *storeXiaofeiRecord = [[HYBStoreXiaofeiRecord alloc] initWithValues:dictionary];
            [self.storeXiaofeiRecords addObject:storeXiaofeiRecord];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end




