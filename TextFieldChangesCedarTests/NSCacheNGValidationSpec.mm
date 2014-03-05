#import "NSCache+NGValidation.h"
#import "NGValidationIncludes.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(NSCacheNGValidationSpec)

describe(@"NSCache", ^{
    __block NSString *key = @"KEY";

    describe(@"validForKey:generationFallback:", ^{
        it(@"should set value for key if not previously set", ^{
            NGValidationBlock blockReturningTRUE = ^BOOL{
                return TRUE;
            };
            NSCache *model = NSCache.alloc.init;
            [model validForKey:key generationFallback:blockReturningTRUE];
            [model objectForKey:key] should equal(@(blockReturningTRUE()));
        });
        
        it(@"should not set value for key if previously set", ^{
            NGValidationBlock blockReturningFALSE = ^BOOL{
                return FALSE;
            };
            NSCache *model = NSCache.alloc.init;
            [model setObject:@TRUE forKey:key];
            [model validForKey:key generationFallback:blockReturningFALSE];
            [model objectForKey:key] should_not equal(@(blockReturningFALSE()));
        });
    });
});

SPEC_END
