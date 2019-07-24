//
//  UIControl+SAAdd.m
//  SADemo
//
//  Created by zhuopin on 2019/7/24.
//

#import "UIControl+SAAdd.h"
#import "MESwizzleTool.h"

@implementation UIControl (SAAdd)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzingSelector = @selector(me_sendAction:to:forEvent:);
        [MESwizzleTool swizzleClass:[self class]
                        originalSel:originalSelector
                         swizzleSel:swizzingSelector];
    });
}

- (void)me_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self me_sendAction:action to:target forEvent:event];
    
}


@end
