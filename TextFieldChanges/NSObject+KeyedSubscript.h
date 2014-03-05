//
//  NSObject+KeyedSubscript.h
//  TextFieldChanges
//
//  Created by James Womack on 3/5/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyedSubscript)
- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey;
@end
