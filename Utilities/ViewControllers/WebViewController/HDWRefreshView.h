//
//  HDWRefreshView.h
//  haidaowan
//
//  Created by zhouhai on 15/4/28.
//  Copyright (c) 2015年 AiJia. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HDWRefreshViewDelegate <NSObject>

@optional

- (void)refreshViewTapped:(id)sender;

@end

@interface HDWRefreshView : UIView

@property (nonatomic, assign)id<HDWRefreshViewDelegate>delegate;


@end
