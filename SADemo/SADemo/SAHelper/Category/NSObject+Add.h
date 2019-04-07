//
//  NSObject+Add.h
//  SADemo
//
//  Created by zhuopin on 2019/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Add)
- (id)valueForProperty:(NSString *)property;
- (BOOL)isImplementSelector:(SEL)selector;

- (void)swizzleObject:(NSObject *)object
     originalSelector:(SEL)originalSelector
          newSelector:(SEL)newSelector;
@end


NS_ASSUME_NONNULL_END
