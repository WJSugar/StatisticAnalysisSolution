//
//  NSObject+Add.m
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import "NSObject+Add.h"
#import <objc/runtime.h>

@implementation NSObject (Add)

- (void)setMe_isExpose:(BOOL)me_isExpose {
    objc_setAssociatedObject(self, @selector(setMe_isExpose:), @(me_isExpose), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)me_isExpose {
    return (BOOL)objc_getAssociatedObject(self, @selector(setMe_isExpose:));
}

- (id)valueForProperty:(NSString *)property {
    unsigned int outCount;
    objc_property_t *property_ts = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; ++i) {
        objc_property_t property_t = property_ts[i];
        const char *propertyName = property_getName(property_t);
        NSString *propertyNameToStr = [NSString stringWithUTF8String:propertyName];
        if ([propertyNameToStr isEqualToString:property]) {
            id propertyValue = [self valueForKey:propertyNameToStr];
            return propertyValue;
        }
    }
    free(property_ts);
    return nil;
}

- (BOOL)isImplementSelector:(SEL)selector {
    unsigned int outCount;
    Method *methods = class_copyMethodList([self class], &outCount);
    NSString *selectorName = NSStringFromSelector(selector);
    for (int i = 0; i < outCount; ++i) {
        Method method = methods[i];
        SEL sel = method_getName(method);
        const char *selName = sel_getName(sel);
        NSString *selNameToString = [NSString stringWithUTF8String:selName];
        if ([selNameToString isEqualToString:selectorName]) {
            return YES;
        }
    }
    free(methods);
    return NO;
}

- (void)swizzleObject:(NSObject *)object originalSelector:(SEL)originalSelector newSelector:(SEL)newSelector {
    Method swizzingMethod = class_getInstanceMethod([self class], newSelector);
    IMP swizzingIMP = method_getImplementation(swizzingMethod);
    BOOL addMethod = class_addMethod([object class],
                                     newSelector,
                                     swizzingIMP,
                                     nil);
    if (addMethod) {
        Method originalMethod = class_getInstanceMethod([object class], originalSelector);
        Method newMethod = class_getInstanceMethod([object class], newSelector);
        method_exchangeImplementations(originalMethod, newMethod);
    }
}

@end
