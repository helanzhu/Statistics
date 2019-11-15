//
//  CCHookUtility.m
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "CCHookUtility.h"
#import <objc/runtime.h>

@implementation CCHookUtility

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    
    Class class = cls;
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
//    https://segmentfault.com/a/1190000014785502 这篇文章讲解了为什么必须class_addMethod
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
