//
//  HYBOrderDetailViewController.h
//  huiyuanbao
//
//  Created by zhouhai on 16/3/19.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "CXNavigationBarController.h"
#import "HYBOrderRecord.h"

@interface HYBOrderDetailViewController : CXNavigationBarController
- (instancetype)initWithOrder:(HYBOrderRecord *)order;
@end
