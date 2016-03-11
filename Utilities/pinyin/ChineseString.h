//
//  ChineseString.h
//  AiJia
//
//  Created by zhouhai on 15/4/1.
//  Copyright (c) 2015年 AiJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "pinyin.h"
#import "HYBPhoneContact.h"

@interface ChineseString : NSObject
@property(retain,nonatomic)HYBPhoneContact *contact;
@property(retain,nonatomic)NSString *pinYin;

//-----  返回tableview右方indexArray
+(NSMutableArray*)IndexArray:(NSArray*)stringArr;

//-----  返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)stringArr;
@end
