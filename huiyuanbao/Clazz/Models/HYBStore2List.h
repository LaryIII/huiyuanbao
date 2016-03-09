//
//  HYBStore2List.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/9.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define STORE_LIST @"merchant/merchant_search"
@interface HYBStore2List : CXResource
@property (nonatomic, strong) NSMutableArray *stores;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) BOOL isInfinite;
@end
