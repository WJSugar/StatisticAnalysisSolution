//
//  SAHelper.h
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SAHelper : NSObject
+ (instancetype)sharedInstance;
@property (nonatomic, strong, readonly) NSDictionary *contollers;
@property (nonatomic, strong, readonly) NSDictionary *actions;
@property (nonatomic, strong, readonly) NSDictionary *tableConfigure;
@property (nonatomic, strong, readonly) NSDictionary *controlConfigure;
@property (nonatomic, strong, readonly) NSDictionary *gestureConfigure;

- (NSString *)pageCodeController:(NSString *)controller;
- (NSString *)getPageCodeController:(UIViewController *)controller;

+ (void)trackConfigure:(NSDictionary *)configure model:(id)model;
@end

NS_ASSUME_NONNULL_END
