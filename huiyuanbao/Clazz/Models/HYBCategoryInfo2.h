//
//  HYBCategoryInfo2.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/10.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBCategoryInfo2 : CXResource
@property (nonatomic, strong) NSString *mtcode;
@property (nonatomic, strong) NSString *mtlevel;
@property (nonatomic, strong) NSString *mtname;
@property (nonatomic, strong) NSString *parentpk;
@property (nonatomic, strong) NSMutableArray *subList;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *logourl;
@end
