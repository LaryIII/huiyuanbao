//
//  HYBQuanList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQuanList.h"
#import "HYBQuan.h"

@implementation HYBQuanList
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
        
        if (self.quans) {
            [self.quans removeAllObjects];
        }
        else {
            self.quans = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBQuan *quan = [[HYBQuan alloc] initWithValues:dictionary];
            [self.quans addObject:quan];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end


