//
//  HYBCategorys.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/10.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCategorys.h"
#import "HYBCategoryInfo.h"

@implementation HYBCategorys
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        NSArray *arr = (NSArray *)value;
        NSMutableArray *categorysx = [arr[0] objectForKey:@"category"];
        if (self.categorys) {
            [self.categorys removeAllObjects];
        }
        else {
            self.categorys = [NSMutableArray array];
        }
        
        for (id dictionary in categorysx) {
            HYBCategoryInfo *categoryinfo1 = [[HYBCategoryInfo alloc] initWithValues:dictionary];
            [self.categorys addObject:categoryinfo1];
        }
    }
    else {
        [super setValue:value forKey:key];
    }
}
@end
