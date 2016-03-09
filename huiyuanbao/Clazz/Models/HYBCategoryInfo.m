//
//  HYBCategoryInfo.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/10.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCategoryInfo.h"
#import "HYBCategoryInfo2.h"

@implementation HYBCategoryInfo
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"subList"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        
        if (self.subList) {
            [self.subList removeAllObjects];
        }
        else {
            self.subList = [NSMutableArray array];
        }
        
        for (id dictionary in value) {
            HYBCategoryInfo2 *categoryinfo2 = [[HYBCategoryInfo2 alloc] initWithValues:dictionary];
            [self.subList addObject:categoryinfo2];
        }
    }
    else {
        [super setValue:value forKey:key];
    }
}
@end
