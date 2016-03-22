//
//  HYBQueryBalance.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQueryBalance.h"

@implementation HYBQueryBalance
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        if([value count]>0){
            NSDictionary *dictionary = value[0];
            for(id k in dictionary){
                [super setValue:[dictionary objectForKey:k] forKey:k];
            }
        }
    }
    else {
        [super setValue:value forKey:key];
    }
}

@end
