//
//  SAHelper.m
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import "SAHelper.h"
#import "NSObject+Add.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>

@interface SAHelper()
@property (nonatomic, strong) NSDictionary *configureDict;
@property (nonatomic, strong) NSDictionary *contollers;
@property (nonatomic, strong) NSDictionary *actions;
@property (nonatomic, strong) NSDictionary *tableConfigure;
@property (nonatomic, strong) NSDictionary *controlConfigure;
@property (nonatomic, strong) NSDictionary *gestureConfigure;
@end

@implementation SAHelper
+ (instancetype)sharedInstance {
    static SAHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SAConfigureJson" ofType:@"json"];
        _sharedInstance.configureDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path]
                                                                        options:NSJSONReadingAllowFragments error:nil];
        _sharedInstance.contollers = _sharedInstance.configureDict[@"controllers"];
        _sharedInstance.tableConfigure = _sharedInstance.configureDict[@"tableView"];
        _sharedInstance.controlConfigure = _sharedInstance.configureDict[@"control"];
        _sharedInstance.gestureConfigure = _sharedInstance.configureDict[@"gesture"];
    });
    return _sharedInstance;
}

- (NSString *)pageCodeController:(NSString *)controller {
    NSString *pageCode = self.contollers[controller];
    return pageCode.length ? pageCode : @"";
}

- (NSString *)getPageCodeController:(UIViewController *)controller {
    NSString *name = NSStringFromClass([controller class]);
    return [self pageCodeController:name];
}


+ (void)trackConfigure:(NSDictionary *)configure model:(id)model {
    NSMutableDictionary *values = [NSMutableDictionary new];
    NSString *eventName = configure[@"event"];
    NSString *entity = configure[@"entity"];
    if (entity.length) {
        NSDictionary *params = configure[@"params"];
        if (params) {
            for (NSString *parameter in params) {
                id title = [model valueForProperty:parameter];
                NSString *temp = [NSString stringWithFormat:@"%@", title];
                if (temp.length) {
                    [values setValue:temp forKey:parameter];
                }
            }
        }
    }
    [[SensorsAnalyticsSDK sharedInstance] track:eventName
                                 withProperties:values];
    NSLog(@"values - %@", values);
}

@end
