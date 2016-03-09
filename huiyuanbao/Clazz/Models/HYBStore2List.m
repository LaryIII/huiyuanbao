//
//  HYBStore2List.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/9.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBStore2List.h"
#import "HYBStore2.h"

@implementation HYBStore2List
- (instancetype)initWithBaseURL:(NSURL *)url path:(NSString *)path
{
    return [self initWithBaseURL:url path:path cachePolicyType:kCachePolicyTypeReturnCacheDataOnError];
}

- (instancetype)initWithBaseURL:(NSURL *)url path:(NSString *)path cachePolicyType:(CachePolicyType)cachePolicyType
{
    self = [super initWithBaseURL:url path:path cachePolicyType:cachePolicyType];
    if (self) {
        self.page = 1;
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
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
            HYBStore2 *store = [[HYBStore2 alloc] initWithValues:dictionary];
            [self.stores addObject:store];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}
@end
