//
//  HYBCityList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBCityList : CXResource
@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, assign) NSInteger page;
@end
