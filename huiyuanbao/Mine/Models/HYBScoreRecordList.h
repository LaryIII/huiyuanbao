//
//  HYBScoreRecordList.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/5.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"

@interface HYBScoreRecordList : CXResource
@property (nonatomic, strong) NSMutableArray *scoreRecords;
@property (nonatomic, assign) NSInteger page;
@end
