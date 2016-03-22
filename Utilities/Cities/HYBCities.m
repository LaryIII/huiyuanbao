//
//  HYBCities.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/18.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBCities.h"
#import "HYBCityName.h"

@interface HYBCities()
@property (nonatomic, strong) NSArray *provinces;
@end

@implementation HYBCities
-(NSMutableArray *)getCities{
    self.cities = [[NSMutableArray alloc] init];
    _provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    for (int i=0; i<_provinces.count; i++) {
        NSArray *arr = [[_provinces objectAtIndex:i] objectForKey:@"cities"];
        for(int j=0;j<arr.count;j++){
            HYBCityName *city = [[HYBCityName alloc] init];
            city.name = [[arr objectAtIndex:j] objectForKey:@"CityName"];
            city.code = [[arr objectAtIndex:j] objectForKey:@"code"];
            [self.cities addObject:city];
        }
    }
    
    return self.cities;
}
@end
