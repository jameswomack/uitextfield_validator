using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

#import "NSObject+KeyedSubscript.h"

SPEC_BEGIN(NSObjectKeyedSubscriptSpec)

/* This is not an exhaustive list of usages.
 For more information, please visit https://github.com/pivotal/cedar */

static NSString *name = @"name";
static NSString *two = @"2";

describe(@"Testing keyed subscript access", ^{
    it(@"should return value of valueForKey: on classes that don't implement setObject:ForKey:", ^{
        NSLock *lock = NSLock.alloc.init;
        [lock setValue:two forKey:name];
        lock[name] should equal(two);
    });
    
    it(@"should return value of objectForKey: on instances of classes that implement that method", ^{
        NSMapTable *mapTable = NSMapTable.alloc.init;
        [mapTable setObject:two forKey:name];
        mapTable[name] should equal(two);
    });
});

describe(@"Testing keyed subscript assignment", ^{
    it(@"should set value to be returned by valueForKey: on classes that don't implement objectForKey:", ^{
        NSLock *lock = NSLock.alloc.init;
        lock[name] = two;
        [lock valueForKey:name] should equal(two);
    });
    
    it(@"should set value to be returned by objectForKey: on instances of classes that implement that method", ^{
        NSMapTable *mapTable = NSMapTable.alloc.init;
        mapTable[name] = two;
        [mapTable objectForKey:name] should equal(two);
    });
});

SPEC_END

