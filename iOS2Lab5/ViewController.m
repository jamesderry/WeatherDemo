//
//  ViewController.m
//  iOS2Lab5
//
//  Created by James Derry on 11/13/13.
//  Copyright (c) 2013 James Derry. All rights reserved.
//

#import "ViewController.h"
#import "WeatherManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.cityIDTxtField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTemperatureLabel:) name:kNotificationNewTemperature object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTemperatureLabel:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tempLabel.text = [dict objectForKey:@"temp"];
    });
}

#pragma mark UITextFieldDelegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[WeatherManager sharedManager] getWeatherForCityID:textField.text];
    
    [textField resignFirstResponder];  //this dismisses the keyboard
    
    return YES;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationNewTemperature object:nil];
}






















@end
