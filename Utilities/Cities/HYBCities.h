//
//  HYBCities.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "HYBCities.h"

@interface HYBCities : NSObject
@property (nonatomic, strong) NSMutableArray *cities;
-(NSMutableArray *)getCities;
@end
