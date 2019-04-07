//
//  MESwizzleTool.h
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface MESwizzleTool : NSObject
+ (void)swizzleClass:(Class)cls originalSel:(SEL)originalSel swizzleSel:(SEL)swizzleSel;

@end

NS_ASSUME_NONNULL_END
