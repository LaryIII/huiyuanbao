//
//  ChineseString.m
//  AiJia
//
//  Created by zhouhai on 15/4/1.
//  Copyright (c) 2015年 AiJia. All rights reserved.
//

#import "ChineseString.h"
#import "HYBPhoneContact.h"
#import "HYBPhoneContactList.h"

@interface ChineseString()
@end

@implementation ChineseString
@synthesize contact;
@synthesize pinYin;

#pragma mark - 返回tableview右方 indexArray
+(NSMutableArray*)IndexArray:(NSArray*)HYBContactsArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArrar:HYBContactsArr];
    NSMutableArray *A_Result=[NSMutableArray array];
    NSString *tempString ;
    
    for (NSString* object in tempArray)
    {
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        //不同
        if(![tempString isEqualToString:pinyin])
        {
            [A_Result addObject:pinyin];
            tempString = pinyin;
        }
    }
    return A_Result;
}

#pragma mark - 返回联系人
+(NSMutableArray*)LetterSortArray:(NSArray*)HYBContactsArr
{
    NSMutableArray *tempArray = [self ReturnSortChineseArrar:HYBContactsArr];
    NSMutableArray *LetterResult=[NSMutableArray array];
//    NSString *tempString ;
    //拼音分组
    for (NSString* object in tempArray) {
        
        NSString *pinyin = [((ChineseString*)object).pinYin substringToIndex:1];
        HYBPhoneContact *contact = ((ChineseString*)object).contact;
        
        //不同
//        if(![tempString isEqualToString:pinyin])
//        {
        if([LetterResult count] > 0){
            //分组
            BOOL flag = NO;
            for(HYBPhoneContactList* obj in LetterResult){
                if([obj.pinYin isEqualToString:pinyin]){
                    flag = YES;
                    [obj.contacts addObject:contact];
                    break;
                }else{
                }
            }
            if(!flag){
                HYBPhoneContactList *item = [[HYBPhoneContactList alloc] init];
                item.contacts = [NSMutableArray array];
                [item.contacts addObject:contact];
                item.pinYin = pinyin;
                [LetterResult addObject:item];
            }
        }else{
            HYBPhoneContactList *item = [[HYBPhoneContactList alloc] init];
            item.contacts = [NSMutableArray array];
            [item.contacts addObject:contact];
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
        ChineseString *chineseString=[[ChineseString alloc]init];
        id object =[HYBContactsArr objectAtIndex:i];
        if ([object isKindOfClass:[HYBPhoneContact class]]){
            HYBPhoneContact *contact = [[HYBPhoneContact alloc] init];
            contact = (HYBPhoneContact *)object;
            chineseString.contact = [[HYBPhoneContact alloc] init];
            chineseString.contact = contact;
        }
        
        if(chineseString.contact.contactName==nil){
            chineseString.contact.contactName=@"";
        }
        //去除两端空格和回车
        chineseString.contact.contactName  = [chineseString.contact.contactName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        //此方法存在一些问题 有些字符过滤不了
        //NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）&yen;「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
        //chineseString.string = [chineseString.string stringByTrimmingCharactersInSet:set];
        
        
        //这里我自己写了一个递归过滤指定字符串   RemoveSpecialCharacter
        chineseString.contact.contactName =[ChineseString RemoveSpecialCharacter:chineseString.contact.contactName];
        // NSLog(@"string====%@",chineseString.string);
        
        
        //判断首字符是否为字母
        NSString *regex = @"[A-Za-z]+";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        
        if ([predicate evaluateWithObject:chineseString.contact.contactName])
        {
            //首字母大写
            chineseString.pinYin = [chineseString.contact.contactName capitalizedString] ;
        }else{
            if(![chineseString.contact.contactName isEqualToString:@""]){
                NSString *pinYinResult=[NSString string];
                for(int j=0;j<chineseString.contact.contactName.length;j++){
                    NSString *singlePinyinLetter=[[NSString stringWithFormat:@"%c",pinyinFirstLetter([chineseString.contact.contactName characterAtIndex:j])]uppercaseString];
                    
                    pinYinResult=[pinYinResult stringByAppendingString:singlePinyinLetter];
                }
                chineseString.pinYin=pinYinResult;
            }else{
                chineseString.pinYin=@"";
            }
        }
        [chineseStringsArray addObject:chineseString];
    }
    //按照拼音首字母对这些Strings进行排序
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    return chineseStringsArray;
}
@end
