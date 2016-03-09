//
//  HYBHomeData.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/6.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#import "HYBFirstStore.h"
#import "HYBStoreList.h"

#define HOME_DATA @"merchant/nearby_recommend"
@interface HYBHomeData : CXResource
@property (nonatomic, strong) NSMutableArray *ads;
@property (nonatomic, strong) NSMutableArray *firstStores;
@property (nonatomic, strong) NSMutableArray *stores;
@end
