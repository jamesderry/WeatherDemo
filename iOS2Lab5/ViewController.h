//
//  ViewController.h
//  iOS2Lab5
//
//  Created by James Derry on 11/13/13.
//  Copyright (c) 2013 James Derry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UITextField *cityIDTxtField;

@end
