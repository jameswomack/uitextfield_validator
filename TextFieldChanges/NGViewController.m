//
//  NGViewController.m
//  TextFieldChanges
//
//  Created by James Womack on 2/28/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import "NGViewController.h"
#import "NGTextFieldValidationObserver.h"

@interface NGViewController ()
@property (nonatomic, strong) NGTextFieldValidationObserver *textFieldValidator;
@end

@implementation NGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.textFieldValidator = [NGTextFieldValidationObserver.alloc
                               initWithTextField:self.correctableTextField
                               andValidationBlock:^BOOL(id object) {
        return [[[object text]
                 stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] isEqualToString:@"Japan"];
    }];
}

@end
