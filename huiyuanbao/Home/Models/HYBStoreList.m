//
//  HYBStoreList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStoreList.h"
#import "HYBStore.h"

@implementation HYBStoreList
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
    if ([key isEqualToString:@"list"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        
        if (self.stores) {
            [self.stores removeAllObjects];
        }
        else {
            self.stores = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBStore *store = [[HYBStore alloc] initWithValues:dictionary];
            [self.stores addObject:store];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end

