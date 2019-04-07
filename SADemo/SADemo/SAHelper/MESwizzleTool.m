//
//  MESwizzleTool.m
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import "MESwizzleTool.h"

@implementation MESwizzleTool
+ (void)swizzleClass:(Class)cls originalSel:(SEL)originalSel swizzleSel:(SEL)swizzleSel {
    Class class = cls;
    Method originalMethod = class_getInstanceMethod(class, originalSel);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSel);
    
    BOOL addMethod = class_addMethod(class,
                                     originalSel,
                                     method_getImplementation(swizzleMethod),
                                     method_getTypeEncoding(swizzleMethod));
    
    if (addMethod) {
        class_replaceMethod(class,
                            swizzleSel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
}

@end
