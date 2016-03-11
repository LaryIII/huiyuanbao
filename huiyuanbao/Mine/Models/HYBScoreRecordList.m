//
//  HYBScoreRecordList.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBScoreRecordList.h"
#import "HYBScoreRecord.h"

@implementation HYBScoreRecordList
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
        
        if (self.scoreRecords) {
            [self.scoreRecords removeAllObjects];
        }
        else {
            self.scoreRecords = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBScoreRecord *scoreRecord = [[HYBScoreRecord alloc] initWithValues:dictionary];
            [self.scoreRecords addObject:scoreRecord];
        }
        
        self.page++;
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end



