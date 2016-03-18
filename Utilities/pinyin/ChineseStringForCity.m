//
//  ChineseStringForCity.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "ChineseStringForCity.h"
#import "HYBCityName.h"
#import "HYBCityNameList.h"

@interface ChineseStringForCity()
@end

@implementation ChineseStringForCity
@synthesize city;
@synthesize pinYin;

#pragma mark - 返回tableview右方 indexArray
+(NSMutableArray*)IndexArray:(NSArray*)HYBCitiesArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArrar:HYBCitiesArr];
    NSMutableArray *A_Result=[NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChineseStringForCity *)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

#pragma mark - 返回城市
+(NSMutableArray*)LetterSortArray:(NSArray*)HYBCitiesArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArrar:HYBCitiesArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
    //    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {
        
        NSString *pinyin = [((ChineseStringForCity *)object).pinYin substringToIndex:1];
        HYBCityName *city = ((ChineseStringForCity *)object).city;
        
        //不同
        //        if(![tempString isEqualToString:pinyin])
        //        {
        if([LetterResult count] > 0){
            //分组
            BOOL flag = NO;
            for(HYBCityNameList *obj in LetterResult){
                if([obj.pinYin isEqualToString:pinyin]){
                    flag = YES;
                    [obj.cities addObject:city];
                    break;
                }else{
                }
            }
            if(!flag){
                HYBCityNameList *item = [[HYBCityNameList alloc] init];
                item.cities = [NSMutableArray array];
                [item.cities addObject:city];
                item.pinYin = pinyin;
                [LetterResult addObject:item];
            }
        }else{
            HYBCityNameList *item = [[HYBCityNameList alloc] init];
            item.cities = [NSMutableArray array];
            [item.cities addObject:city];
            item.pinYin = pinyin;
            [LetterResult addObject:item];
        }
        
        //            [item  addObject:contact];
        
        //遍历
        //            tempString = pinyin;
        //        }else//相同
        //        {
        ////            [item  addObject:contact];
        //            [item.contacts addObject:contact];
        //        }
    }
    return LetterResult;
}




//过滤指定字符串   里面的指定字符根据自己的需要添加
+(NSString*)RemoveSpecialCharacter: (NSString *)str {
    NSRange urgentRange = [str rangeOfCharacterFromSet: [NSCharacterSet characterSetWithCharactersInString: @",.？、 ~￥#&<>《》()[]{}【】^@/￡&curren;|&sect;&uml;「」『』￠￢￣~@#&*（）——+|《》$_€"]];
    if (urgentRange.location != NSNotFound)
    {
        return [self RemoveSpecialCharacter:[str stringByReplacingCharactersInRange:urgentRange withString:@""]];
    }
    return str;
}

///////////////////
//
//返回排序好的字符拼音
//
///////////////////
+(NSMutableArray*)ReturnSortChineseArrar:(NSArray*)HYBContactsArr
{
    //获取字符串中文字的拼音首字母并与字符串共同存放
    NSMutableArray *chineseStringsArray=[NSMutableArray array];
    for(int i=0;i<[HYBContactsArr count];i++)
    {
        ChineseStringForCity *chineseStringForCity=[[ChineseStringForCity alloc]init];
        id object =[HYBContactsArr objectAtIndex:i];
        if ([object isKindOfClass:[HYBCityName class]]){
            HYBCityName *city = [[HYBCityName alloc] init];
            city = (HYBCityName *)object;
            chineseStringForCity.city = [[HYBCityName alloc] init];
            chineseStringForCity.city = city;
        }
        
        if(chineseStringForCity.city.name==nil){
            chineseStringForCity.city.name=@"";
        }
        //去除两端空格和回车
        chineseStringForCity.city.name  = [chineseStringForCity.city.name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        //此方法存在一些问题 有些字符过滤不了
        //NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）&yen;「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
        //chineseString.string = [chineseString.string stringByTrimmingCharactersInSet:set];
        
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        chineseStringForCity.city.name =[ChineseStringForCity RemoveSpecialCharacter:chineseStringForCity.city.name];
        // NSLog(@"string====%@",chineseString.string);
        
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseStringForCity.city.name])
        {
            //首字母大写
            chineseStringForCity.pinYin = [chineseStringForCity.city.name capitalizedString] ;
        }else{
            if(![chineseStringForCity.city.name isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseStringForCity.city.name.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseStringForCity.city.name characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseStringForCity.pinYin=pinYinResult;
            }else{
                chineseStringForCity.pinYin=@"";
            }
        }
        [chineseStringsArray addObject:chineseStringForCity];
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}
@end
