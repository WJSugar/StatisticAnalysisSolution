//
//  SAHelper.m
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import "SAHelper.h"

@interface SAHelper()
@property (nonatomic, strong) NSDictionary *configureDict;
@property (nonatomic, strong) NSDictionary *contollers;
@property (nonatomic, strong) NSDictionary *actions;
@property (nonatomic, strong) NSDictionary *tableConfigure;
@end

@implementation SAHelper
+ (instancetype)sharedInstance {
    static SAHelper *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"SAConfigureJson" ofType:@"json"];
        _sharedInstance.configureDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:NSJSONReadingAllowFragments error:nil];
        _sharedInstance.contollers = _sharedInstance.configureDict[@"controllers"];
        _sharedInstance.tableConfigure = _sharedInstance.configureDict[@"tableView"];
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

@end
