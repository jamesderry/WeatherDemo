//
//  WeatherManager.m
//  iOS2Lab5
//
//  Created by James Derry on 11/13/13.
//  Copyright (c) 2013 James Derry. All rights reserved.
//

#import "WeatherManager.h"

// We're using Yahoo Weather API's
// yahoo weather api call looks like
// http://weather.yahooapis.com/forecastrss?w=2355944&u=f

#define kYahooWeatherAPIUrlStub @"http://weather.yahooapis.com/forecastrss?"

@implementation WeatherManager
{
    NSString *currentElement;
}


#pragma mark Singleton Method

+ (id)sharedManager {
    static WeatherManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)getWeatherForCityID:(NSString *)cityID
{
    NSString *urlString = [NSString stringWithFormat:@"%@w=%@&u=f", kYahooWeatherAPIUrlStub, cityID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
        
        if (error) {
            NSLog(@"An error occurred connecting to yahoo weather api.");
        } else {
            [self parseWeatherXML:data];
        }
        
    }];
}

- (void)parseWeatherXML:(NSData *)data
{
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    [parser parse];
    
}

#pragma mark NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"yweather:condition"]) {
        NSString *temp = [attributeDict valueForKey:@"temp"];
        NSLog(@"temperature is %@", temp);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationNewTemperature object:nil userInfo:attributeDict];
    }
}



















@end
