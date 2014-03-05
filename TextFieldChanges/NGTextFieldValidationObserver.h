//
//  NGTextFieldValidationObserver.h
//  TextFieldChanges
//
//  Created by James Womack on 3/2/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGValidationIncludes.h"

@interface NGTextFieldValidationObserver : NSObject

@property (weak, nonatomic)     UITextField       *textField;
@property (strong, nonatomic)   NGTextFieldValidationBlock validationBlock;
@property (readonly, nonatomic) BOOL              textFieldIsValid;

- (instancetype)initWithTextField:(UITextField *)textField
               andValidationBlock:(NGTextFieldValidationBlock)validationBlock;

- (BOOL)textField:(UITextField *)textField
 isValidWithBlock:(NGTextFieldValidationBlock)validationBlock;

@end
