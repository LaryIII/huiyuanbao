//
//  HYBStoreList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

#define NEARBY_LIST @"merchant/nearby_recommend"
@interface HYBStoreList : CXResource
@property (nonatomic, strong) NSMutableArray *stores;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isInfinite;
@end
