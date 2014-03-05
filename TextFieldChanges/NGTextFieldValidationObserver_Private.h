//
//  NGTextFieldValidationObserver_Private.h
//  TextFieldChanges
//
//  Created by James Womack on 3/5/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import "NGTextFieldValidationObserver.h"

@interface NGTextFieldValidationObserver ()
@property (strong, nonatomic) NSCache *cache;
- (void)monitorTextField:(UITextField *)textField;
- (void)textDidChange:(NSNotification *)notification;
- (void)setCache:(NSCache *)cache;
@end
