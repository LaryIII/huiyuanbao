//
//  HYBHuiTixianRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/21.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define HUITIXIAN_LIST @"withdraw/getWithList"
@interface HYBHuiTixianRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *huiTixianRecords;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) BOOL isInfinite;
@end
