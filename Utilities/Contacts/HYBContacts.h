//
//  HYBContacts.h
//  huiyuanbao
//
//  Created by zhouhai on 15/4/1.
//  Copyright (c) 2015年 huiyuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HYBContacts.h"

@interface HYBContacts : NSObject

@property (nonatomic, strong) NSMutableArray *contacts;

-(NSMutableArray *)getAddress;
-(void)addPeople;

@end
