//
//  UIGestureRecognizer+SAAdd.m
//  SADemo
//
//  Created by zhuopin on 2019/7/30.
//

#import "UIGestureRecognizer+SAAdd.h"
#import "MESwizzleTool.h"

@implementation UIGestureRecognizer (SAAdd)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(initWithTarget:action:);
        SEL swizzingSelector = @selector(me_initWithTarget:action:);
        [MESwizzleTool swizzleClass:[self class]
                        originalSel:originalSelector
                         swizzleSel:swizzingSelector];
    });
}

- (instancetype)me_initWithTarget:(id)target action:(SEL)action {
    NSString *selName = NSStringFromSelector(action);
    self.me_selName = selName.length ? selName : @"";
    return [self me_initWithTarget:target action:action];
}

- (void)setMe_selName:(NSString *)me_selName {
    objc_setAssociatedObject(self, @selector(setMe_selName:), me_selName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)me_selName {
    return (NSString *)objc_getAssociatedObject(self, @selector(setMe_selName:));
}
@end
