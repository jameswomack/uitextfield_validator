//
//  NSObject+KeyedSubscript.m
//  TextFieldChanges
//
//  Created by James Womack on 3/5/14.
//  Copyright (c) 2014 James Womack. All rights reserved.
//

#import "NSObject+KeyedSubscript.h"

@implementation NSObject (KeyedSubscript)

- (id)objectForKeyedSubscript:(id)key; {
    BOOL respondsToObjectForKey = [self respondsToSelector:@selector(objectForKey:)];
    return respondsToObjectForKey ? [(id)self objectForKey:key] : [self valueForKey:key];
}

- (void)setObject:(id)object forKeyedSubscript:(id < NSCopying >)aKey; {
    BOOL respondsToSetObjectForKey = [self respondsToSelector:@selector(setObject:forKey:)];
    return respondsToSetObjectForKey ? [(id)self setObject:object forKey:aKey] : [self setValue:object forKey:(NSString *)aKey];
}

@end
