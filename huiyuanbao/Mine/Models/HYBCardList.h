//
//  HYBCardList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBCardList : CXResource
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, assign) NSInteger page;
@end
