//
//  NGTextFieldValidationObserver.m
//  TextFieldChanges
//
//  Created by James Womack on 3/2/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import "NGTextFieldValidationObserver.h"
#import "NGTextFieldValidationObserver_Private.h"
#import "NSCache+NGValidation.h"

@implementation NGTextFieldValidationObserver

@dynamic textFieldIsValid;

- (instancetype)initWithTextField:(UITextField *)textField
               andValidationBlock:(NGTextFieldValidationBlock)validationBlock; {
    if ((self = super.init)) {
        self.textField = textField;
        self.validationBlock = validationBlock;
        self.cache = NSCache.new;
        [self monitorTextField:self.textField];
    }
    return self;
}

- (void)monitorTextField:(UITextField *)textField
{
    [NSNotificationCenter.defaultCenter
     addObserver:self
     selector:@selector(textDidChange:)
     name:UITextFieldTextDidChangeNotification
     object:textField];
}

- (void)textDidChange:(NSNotification *)notification
{
    BOOL valid = [self textField:notification.object isValidWithBlock:self.validationBlock];
    CGColorRef color;
    
    if (valid) {
        color = UIColor.greenColor.CGColor;
    } else {
        color = UIColor.redColor.CGColor;
    }
    
    [[notification.object layer] setBorderWidth:2.f];
    [[notification.object layer] setBorderColor:color];
}

- (BOOL)textField:(UITextField *)textField isValidWithBlock:(NGTextFieldValidationBlock)validationBlock {
    NSString *text = textField.text;
    return [self.cache validForKey:text generationFallback:^BOOL{
        return validationBlock(textField);
    }];
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter
     removeObserver:self
     name:UITextFieldTextDidChangeNotification
     object:self.textField];
}

@end
