//
//  UIControl+SAAdd.m
//  SADemo
//
//  Created by zhuopin on 2019/7/24.
//

#import "UIControl+SAAdd.h"
#import "MESwizzleTool.h"
#import "NSObject+Add.h"
#import "SAHelper.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

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
    NSDictionary *controlConfigure = [SAHelper sharedInstance].controlConfigure;
    NSString *targetName = NSStringFromClass([target class]);
    NSDictionary *configureParam = controlConfigure[targetName];
    if (!configureParam) return;
    
    NSString *selName = NSStringFromSelector(action);
    NSDictionary *configure = configureParam[selName];
    if (!configure) return;
    
    NSMutableDictionary *values = [NSMutableDictionary new];
    NSString *entity = configure[@"entity"];
    id model = [target valueForKey:entity];
    [SAHelper trackConfigure:configure model:model];
}


@end
