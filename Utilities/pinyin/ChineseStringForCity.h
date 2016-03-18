//
//  ChineseStringForCity.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "HYBCityName.h"

@interface ChineseStringForCity : NSObject
@property(retain,nonatomic)HYBCityName *city;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;
@end
