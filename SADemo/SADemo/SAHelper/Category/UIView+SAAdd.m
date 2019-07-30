//
//  UIView+SAAdd.m
//  SADemo
//
//  Created by zhuopin on 2019/7/30.
//

#import "UIView+SAAdd.h"
#import "MESwizzleTool.h"
#import "NSObject+Add.h"
#import "SAHelper.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import "UIGestureRecognizer+SAAdd.h"

@implementation UIView (SAAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(gestureRecognizerShouldBegin:);
        SEL swizzingSelector = @selector(me_gestureRecognizerShouldBegin:);
        [MESwizzleTool swizzleClass:[self class]
                        originalSel:originalSelector
                         swizzleSel:swizzingSelector];
    });
}

- (BOOL)me_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    BOOL isShould = [self me_gestureRecognizerShouldBegin:gestureRecognizer];
    NSDictionary *controlConfigure = [SAHelper sharedInstance].gestureConfigure;
    
    UIView *view = gestureRecognizer.view;
    UIViewController *viewController = [view viewController];
    if (!viewController) return isShould;
    
    NSString *targetName = NSStringFromClass([viewController class]);
    NSDictionary *configureParam = controlConfigure[targetName];
    if (!configureParam) return isShould;

    NSString *selName = gestureRecognizer.me_selName;
    if (selName.length == 0) return isShould;
    NSDictionary *configure = configureParam[selName];
    if (!configure) return isShould;

    NSString *entity = configure[@"entity"];
    id model = [viewController valueForKey:entity];
    [SAHelper trackConfigure:configure model:model];
    return isShould;
}

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}





@end
