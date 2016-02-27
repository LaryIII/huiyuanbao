//
//  HYBStore.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBStore : CXResource
@property (nonatomic, strong) NSString *sid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imgUrl_2x;
@property (nonatomic, strong) NSString *imgUrl_3x;
@property (nonatomic, strong) NSString *label;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger type;
@end
