//
//  HYBHomeData.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/6.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBHomeData.h"
#import "HYBAdvertisement.h"
#import "HYBStore.h"

@implementation HYBHomeData
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"result"]) {
        if (![value isKindOfClass:[NSArray class]]) {
            return;
        }
        NSArray *val = (NSArray *)value;
        NSMutableArray *valStore = [[NSMutableArray alloc]init];
        
        for (int i=0; i<val.count; i++) {
            if(i==0){
                // 广告
                NSDictionary *dictionary1 = value[i];
                NSMutableArray *ads = [dictionary1 objectForKey:@"merAd"];
                
                if (![ads isKindOfClass:[NSArray class]]) {
                    return;
                }
                
                if (self.ads) {
                    [self.ads removeAllObjects];
                }
                else {
                    self.ads = [NSMutableArray array];
                }
                
                for (id dictionary in ads) {
                    HYBAdvertisement *ad = [[HYBAdvertisement alloc] initWithValues:dictionary];
                    [self.ads addObject:ad];
                }
            }else if(i==1){
                // 第一次加入
                NSDictionary *dictionary2 = val[i];
                NSMutableArray *firstStores = [dictionary2 objectForKey:@"firstmant"];
                if (![firstStores isKindOfClass:[NSArray class]]) {
                    return;
                }
                
                if (self.firstStores) {
                    [self.firstStores removeAllObjects];
                }
                else {
                    self.firstStores = [NSMutableArray array];
                }
                
                for (id dictionary in firstStores) {
                    HYBFirstStore *store = [[HYBFirstStore alloc] initWithValues:dictionary];
                    [self.firstStores addObject:store];
                }
            }else{
//                // 附近的商店
//                NSDictionary *dictionary3 = value[i];
//                HYBStoreList *storeList = HYBStoreList.new;
//                NSMutableArray *stores = [dictionary3 objectForKey:@"firstmant"];
//                self.storeList = storeList;
//                self.storeList.stores = stores;
                [valStore addObject:val[i]];
            }
        }
        
        if (self.stores) {
            [self.stores removeAllObjects];
        }
        else {
            self.stores = [NSMutableArray array];
        }
        for (id dictionary in valStore) {
            HYBStore *store = [[HYBStore alloc] initWithValues:dictionary];
            [self.stores addObject:store];
        }
    }else {
        [super setValue:value forKey:key];
    }
}
@end
