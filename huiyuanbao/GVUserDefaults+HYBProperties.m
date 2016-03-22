//
//  GVUserDefaults+AJProperties.m
//  AiJia
//
//  Created by 熊财兴 on 15/1/26.
//  Copyright (c) 2015年 AiJia. All rights reserved.
//

#import "GVUserDefaults+HYBProperties.h"

@implementation GVUserDefaults (HYBProperties)

@dynamic token;
@dynamic refreshToken;
@dynamic expire;
@dynamic userId;
@dynamic cpuid;
@dynamic phoneno;
@dynamic position;
@dynamic citycode;
@dynamic cityname;

- (NSDictionary *)setupDefaults {
    return @{
             @"userId":@"ea47794a91d0401089539020b170db24",
             @"cpuid":@"099D035B-E748-4CCA-A019-94ED7BF9D6EB",
             @"phoneno":@"13236567035",
             @"position":@"",
             @"citycode":@"320100",
             @"cityname":@"南京"
             };
}

#pragma mark - convert key
- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"HYBUserDefault%@", key];
}

@end
