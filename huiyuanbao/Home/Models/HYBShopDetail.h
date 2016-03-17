//
//  HYBShopDetail.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/17.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXResource.h"
#define SHOP_DETAIL @"merchant/getMerchantdetile"
@interface HYBShopDetail : CXResource
@property (nonatomic, strong) NSString *merchant_describe;//"家的感觉"
@property (nonatomic, strong) NSString *latitude;//"39.892945",
@property (nonatomic, strong) NSString *merchant_bool;//:false,
@property (nonatomic, strong) NSString *merchant_img;//36d23840f13d4924937cdb6fa6b6b7c5_LOGO_IMG_20160118_184357.jpg",
@property (nonatomic, strong) NSString *merchant_name;//速8酒店",
@property (nonatomic, strong) NSString *remark;//":"",
@property (nonatomic, strong) NSString *merchant_phone;//":"4008975858",
@property (nonatomic, strong) NSString *logocheck;//":2,
@property (nonatomic, strong) NSString *merchant_level;//":2,
@property (nonatomic, strong) NSMutableArray *merAd;//":[{"adurl":"36d23840f13d4924937cdb6fa6b6b7c5_IMG_20160118_184258.jpg","addesc":"5"},{"adurl":"36d23840f13d4924937cdb6fa6b6b7c5_IMG_20160118_184232.jpg","addesc":"4"},{"adurl":"36d23840f13d4924937cdb6fa6b6b7c5_IMG_20160118_184211.jpg","addesc":"3"},{"adurl":"36d23840f13d4924937cdb6fa6b6b7c5_IMG_20160118_184129.jpg","addesc":"2"},{"adurl":"36d23840f13d4924937cdb6fa6b6b7c5_IMG_20160118_184101.jpg","addesc":"1"}],
@property (nonatomic, strong) NSString *merchant_adress;//":"北京丰台区广安路11号",
@property (nonatomic, strong) NSMutableArray *productList;//[{"earnestmoney":0.000,"pkproduct":"0cad2731ba2d4e3fa0a2668a02eee2cc","vipPrice":1.000,"remark":"1","isdefault":2,"productName":"1","productPrice":1.000,"notice":"1"},
@property (nonatomic, strong) NSString *isvip;
@property (nonatomic, strong) NSString *interest;
@property (nonatomic, strong) NSString *merchant_redpacket;
@end
