//
//  HYBShopDetail.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/17.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBShopDetail.h"
#import "HYBAdvertisement.h"
#import "HYBStoreProduct.h"

@implementation HYBShopDetail
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        NSArray *arr = (NSArray *)value;
        
        for (NSString *key in arr[0]) {
            id object=[arr[0] objectForKey:key];
            if([key isEqualToString:@"merAd"]){
                if (![object isKindOfClass:[NSArray class]]) {
                    return;
                }
                
                if (self.merAd) {
                    [self.merAd removeAllObjects];
                }
                else {
                    self.merAd = [NSMutableArray array];
                }
                
                for (id dictionary in object) {
                    HYBAdvertisement *ad = [[HYBAdvertisement alloc] initWithValues:dictionary];
                    [self.merAd addObject:ad];
                }
            }else if([key isEqualToString:@"productList"]){
                if (![object isKindOfClass:[NSArray class]]) {
                    return;
                }
                
                if (self.productList) {
                    [self.productList removeAllObjects];
                }
                else {
                    self.productList = [NSMutableArray array];
                }
                
                for (id dictionary in object) {
                    HYBStoreProduct *product = [[HYBStoreProduct alloc] initWithValues:dictionary];
                    [self.productList addObject:product];
                }
            }else{
                [super setValue:object forKey:key];
            }
            
        }
    }
//    else {
//        [super setValue:value forKey:key];
//    }
}
@end
