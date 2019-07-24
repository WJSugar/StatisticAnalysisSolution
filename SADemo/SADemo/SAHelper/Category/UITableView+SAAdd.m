//
//  UITableView+SAAdd.m
//  SADemo
//
//  Created by zhuopin on 2019/2/11.
//

#import "UITableView+SAAdd.h"
#import "MESwizzleTool.h"
#import "NSObject+Add.h"
#import "SAHelper.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

@implementation UITableView (SAAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(setDelegate:);
        SEL swizzingSelector = @selector(me_setDelegate:);
        [MESwizzleTool swizzleClass:[self class]
                        originalSel:originalSelector
                         swizzleSel:swizzingSelector];
    });
}

- (void)me_setDelegate:(id<UITableViewDelegate>)delegate {
    [self me_setDelegate:delegate];
    id temp = (NSObject *)delegate;

    //hook  tableView:didSelectRowAtIndexPath:
    SEL originalDidSelecteSel = @selector(tableView:didSelectRowAtIndexPath:);
    SEL newDidSelectSel = @selector(me_tableView:didSelectRowAtIndexPath:);
    BOOL isImpDidSelecteSel = [temp isImplementSelector:originalDidSelecteSel];
    if (isImpDidSelecteSel) {
        [self swizzleObject:self.delegate
           originalSelector:originalDidSelecteSel
                newSelector:newDidSelectSel];
    }
    
    
    SEL originalWillDisplayCellSel = @selector(tableView:willDisplayCell:forRowAtIndexPath:);
    SEL newWillDisplayCellSel = @selector(me_tableView:willDisplayCell:forRowAtIndexPath:);
    BOOL isImpWillDisplayCellSel = [temp isImplementSelector:originalDidSelecteSel];
    if (isImpWillDisplayCellSel) {
        [self swizzleObject:self.delegate
           originalSelector:originalWillDisplayCellSel
                newSelector:newWillDisplayCellSel];
    }
}

- (void)me_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self me_tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSString *methodName = @"me_tableView:didSelectRowAtIndexPath:";
    NSDictionary *methodConfigure = [tableView configureForMethod:methodName];;
    if (!methodConfigure) return;

    NSString *reuseIdentifier = methodConfigure[@"reuseIdentifier"];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:reuseIdentifier]) {
        [tableView configureTrackParam:cell methodConfigure:methodConfigure];
    }
}

- (void)me_tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self me_tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    NSString *methodName = @"me_tableView:willDisplayCell:forRowAtIndexPath:";
    
    NSDictionary *methodConfigure = [tableView configureForMethod:methodName];;
    if (!methodConfigure) return;
    
    NSString *entity = methodConfigure[@"entity"];
    id model = [cell valueForKey:entity];
    NSObject *temp = (NSObject *)model;
    if (temp.me_isExpose) return;
    NSString *reuseIdentifier = methodConfigure[@"reuseIdentifier"];
    if ([cell.reuseIdentifier isEqualToString:reuseIdentifier]) {
        [tableView configureTrackParam:cell methodConfigure:methodConfigure];
    }
    temp.me_isExpose = YES;
}


- (NSDictionary *)configureForMethod:(NSString *)methodName {
    NSString *delegateClassName = NSStringFromClass([self.delegate class]);
    NSDictionary *saConfigure = [[SAHelper sharedInstance] tableConfigure][delegateClassName];
    if (!saConfigure) return nil;
    
    NSDictionary *methodConfigure = saConfigure[methodName];
    if (!methodConfigure) return nil;
    return methodConfigure;
}

- (void)configureTrackParam:(UITableViewCell *)cell methodConfigure:(NSDictionary *)methodConfigure {
    NSMutableDictionary *values = [NSMutableDictionary new];
    NSString *event = methodConfigure[@"event"];
    NSString *entity = methodConfigure[@"entity"];
    id model = [cell valueForKey:entity];
    
    NSDictionary *params = methodConfigure[@"params"];
    if (params) {
        for (NSString *parameter in params) {
            id title = [model valueForProperty:parameter];
            if (!title) {
                [values setValue:title forKey:parameter];
            }
        }
    }
    [[SensorsAnalyticsSDK sharedInstance] track:event
                                 withProperties:values];
    
    NSLog(@"event = %@, values = %@", event, values);
}

@end
