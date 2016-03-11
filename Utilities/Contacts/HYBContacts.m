//
//  HYBContacts.m
//  huiyuanbao
//
//  Created by zhouhai on 15/4/1.
//  Copyright (c) 2015年 huiyuanbao. All rights reserved.
//

#import "HYBContacts.h"
@import AddressBook;
@import AddressBookUI;
#import "HYBPhoneContact.h"

@interface HYBContacts()
@end

@implementation HYBContacts

-(NSMutableArray *)getAddress
{
    //typedef CFTypeRef ABAddressBookRef;
    //typedef const void * CFTypeRef;
    //指向常量的指针
    self.contacts = [[NSMutableArray alloc] init];
    ABAddressBookRef addressBook = nil;
    //判断当前系统的版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        //如果不小于6.0，使用对应的api获取通讯录，注意，必须先请求用户的同意，如果未获得同意或者用户未操作，此通讯录的内容为空
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);//等待同意后向下执行//为了保证用户同意后在进行操作，此时使用多线程的信号量机制，创建信号量，信号量的资源数0表示没有资源，调用dispatch_semaphore_wait会立即等待。若对此处不理解，请参看GCD信号量同步相关内容。
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//发出访问通讯录的请求
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
            //如果用户同意，才会执行此block里面的方法
            //此方法发送一个信号，增加一个资源数
            dispatch_semaphore_signal(sema);
        });
        //如果之前的block没有执行，则sema的资源数为零，程序将被阻塞
        //当用户选择同意，block的方法被执行， sema资源数为1；
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }//如果系统是6.0之前的系统，不需要获得同意，直接访问
    else{
    //    addressBook = ABAddressBookCreate();
        addressBook = ABAddressBookCreateWithOptions(NULL, NULL);

    }
    //通讯录信息已获得，开始取出
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    //联系人条目数（使用long而不使用int是为了兼容64位）
    long peopleCount = CFArrayGetCount(results);
    for (int i=0; i<peopleCount; i++)
    {
        HYBPhoneContact *contact = [[HYBPhoneContact alloc] init];
        ABRecordRef record = CFArrayGetValueAtIndex(results, i);
        NSString *firstName,*lastName;
        
        firstName = nil;
        lastName= nil;
        
        CFTypeRef tmp = NULL;
        //firstName
        tmp = ABRecordCopyValue(record, kABPersonFirstNameProperty);
        if (tmp) {
            firstName = [NSString stringWithString:(__bridge NSString *)(tmp)];
            CFRelease(tmp);tmp = NULL;
        }
        //lastName
        tmp = ABRecordCopyValue(record, kABPersonLastNameProperty);
        if (tmp){
            lastName= [NSString stringWithString:(__bridge NSString *)(tmp)];
            CFRelease(tmp);
            tmp = NULL;
        }
        //取得完整名字（与上面firstName、lastName无关）
        CFStringRef  fullName=ABRecordCopyCompositeName(record);
        
        contact.contactName = (__bridge NSString *)(fullName);
        // 读取电话,不只一个
        ABMultiValueRef phones = ABRecordCopyValue(record, kABPersonPhoneProperty);
        long phoneCount = ABMultiValueGetCount(phones);
        for (int j=0; j<phoneCount; j++) {
            // label
            CFStringRef lable = ABMultiValueCopyLabelAtIndex(phones, j);
            // phone number
            CFStringRef number = ABMultiValueCopyValueAtIndex(phones, j);
            // localize label
            CFStringRef local = ABAddressBookCopyLocalizedLabel(lable);
            //此处可使用一个自定义的model类来存储姓名和电话信息。我在这里就直接输出了。
            contact.contactPhone = (__bridge NSString*)(number);
            if (local)CFRelease(local);
            if (lable) CFRelease(lable);
            if (number)CFRelease(number);
        }
        [self.contacts addObject:contact];
        if (phones) CFRelease(phones);
        record = NULL;
    }
    if (results)CFRelease(results);
    results = nil;if (addressBook)CFRelease(addressBook);
    addressBook = NULL;
    return self.contacts;
}

-(void)addPeople
{
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    //判断当前系统的版本
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
    {
        //如果不小于6.0，使用对应的api获取通讯录，注意，必须先请求用户的同意，如果未获得同意或者用户未操作，此通讯录的内容为空
        tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);//等待同意后向下执行//为了保证用户同意后在进行操作，此时使用多线程的信号量机制，创建信号量，信号量的资源数0表示没有资源，调用dispatch_semaphore_wait会立即等待。若对此处不理解，请参看GCD信号量同步相关内容。
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);//发出访问通讯录的请求
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool granted, CFErrorRef error){
            //如果用户同意，才会执行此block里面的方法
            //此方法发送一个信号，增加一个资源数
            dispatch_semaphore_signal(sema);
        });
        //如果之前的block没有执行，则sema的资源数为零，程序将被阻塞
        //当用户选择同意，block的方法被执行， sema资源数为1；
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }//如果系统是6.0之前的系统，不需要获得同意，直接访问
    else{
        // tmpAddressBook = ABAddressBookCreate();
        tmpAddressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    //创建一条联系人记录
    ABRecordRef tmpRecord = ABPersonCreate();
    CFErrorRef error;
    BOOL tmpSuccess = NO;
    //Nickname
    CFStringRef tmpNickname = CFSTR("Sparky");
    tmpSuccess = ABRecordSetValue(tmpRecord, kABPersonNicknameProperty, tmpNickname, &error);
    CFRelease(tmpNickname);
    //First name
    CFStringRef tmpFirstName = CFSTR("zhou");
    tmpSuccess = ABRecordSetValue(tmpRecord, kABPersonFirstNameProperty, tmpFirstName, &error);
    CFRelease(tmpFirstName);
    //Last name
    CFStringRef tmpLastName = CFSTR("shan");
    tmpSuccess = ABRecordSetValue(tmpRecord, kABPersonLastNameProperty, tmpLastName, &error);
    CFRelease(tmpLastName);
    //phone number
    CFTypeRef tmpPhones = CFSTR("13902400000");
    ABMutableMultiValueRef tmpMutableMultiPhones = ABMultiValueCreateMutable(kABPersonPhoneProperty);
    ABMultiValueAddValueAndLabel(tmpMutableMultiPhones, tmpPhones, kABPersonPhoneMobileLabel, NULL);
    tmpSuccess = ABRecordSetValue(tmpRecord, kABPersonPhoneProperty, tmpMutableMultiPhones, &error);
    CFRelease(tmpPhones);
    //保存记录
    tmpSuccess = ABAddressBookAddRecord(tmpAddressBook, tmpRecord, &error);
    CFRelease(tmpRecord);
    //保存数据库
    tmpSuccess = ABAddressBookSave(tmpAddressBook, &error);
    CFRelease(tmpAddressBook);
}


@end
