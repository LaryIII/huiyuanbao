//
//  HYBAdvertisement.h
//  huiyuanbao
//
//  Created by zhouhai on 16/2/27.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBAdvertisement : CXResource
@property (nonatomic, copy) NSString *bannerUrl;
@property (nonatomic, copy) NSString *jumpUrl;
@property (nonatomic, copy) NSString *logon;
@property (nonatomic, assign) NSInteger position;
@end
