//
//  WeatherManager.h
//  iOS2Lab5
//
//  Created by James Derry on 11/13/13.
//  Copyright (c) 2013 James Derry. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNotificationNewTemperature @"NewTemperatureReady"

@interface WeatherManager : NSObject <NSXMLParserDelegate>


+ (id)sharedManager;

- (void)getWeatherForCityID:(NSString *)cityID;

@end
