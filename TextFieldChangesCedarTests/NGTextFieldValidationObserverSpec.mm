#import "NGTextFieldValidationObserver.h"
#import "NGTextFieldValidationObserver_Private.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(NGTextFieldValidationObserverSpec)

static NSString *validString = @"Japan";
__block NGTextFieldValidationObserver *validator;
__block NGTextFieldValidationObserver *validatorAlloc;
__block NGTextFieldValidationBlock validationBlock = ^BOOL(id object) {
    return [[[object text]
             stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] isEqualToString:validString];
};
__block UITextField *textField;

beforeEach(^{
    textField = UITextField.alloc.init;
    validatorAlloc = NGTextFieldValidationObserver.alloc;
    spy_on(validatorAlloc);
    validator = [validatorAlloc initWithTextField:textField andValidationBlock:validationBlock];
    spy_on(validator);
});

describe(@"NGTextFieldValidationObserver initialization", ^{
    it(@"should assign the text field passed in", ^{
        validator.textField should equal(textField);
    });
    
    it(@"should set itself up with an NSCache instance", ^{
        validatorAlloc should have_received("setCache:").with(Arguments::anything);
    });
    
    it(@"should call monitorTextField: with the text field passed in", ^{
        validatorAlloc should have_received("monitorTextField:").with(validator.textField);
    });
});

describe(@"NGTextFieldValidationObserver textDidChange:", ^{
    __block NSNotification *textFieldTextDidChangeNotification;
    __block UITextField *otherTextField;
    UIColor *validColor = UIColor.greenColor;
    UIColor *invalidColor = UIColor.redColor;
    
    beforeEach(^{
        otherTextField = UITextField.alloc.init;
        textFieldTextDidChangeNotification = [NSNotification notificationWithName:UITextFieldTextDidChangeNotification object:otherTextField];
    });
    
    it(@"should call textField:isValidWithBlock: with passed-in text field", ^{
        [validator textDidChange:textFieldTextDidChangeNotification];
        validator should have_received("textField:isValidWithBlock:").with(otherTextField, Arguments::anything);
    });
    
    it(@"should set the border width & color of the passed in text field", ^{
        spy_on(otherTextField.layer);
        [validator textDidChange:textFieldTextDidChangeNotification];
        otherTextField.layer should have_received("setBorderWidth:").with(Arguments::anything);
        otherTextField.layer should have_received("setBorderColor:").with(Arguments::anything);
    });
    
    it(@"should set the border color to green if string is valid", ^{
        otherTextField.text = validString;
        [validator textDidChange:textFieldTextDidChangeNotification];
        UIColor *color = [UIColor colorWithCGColor:otherTextField.layer.borderColor];
        color should equal(validColor);
    });
    
    it(@"should set the border color to red if string is valid", ^{
        [validator textDidChange:textFieldTextDidChangeNotification];
        UIColor *color = [UIColor colorWithCGColor:otherTextField.layer.borderColor];
        color should equal(invalidColor);
    });
});

SPEC_END
