//
//  UIGestureRecognizer+Statistics.m
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "UIGestureRecognizer+Statistics.h"
#import "CCHookUtility.h"
#import "StatisticsManager.h"
#import "objc/runtime.h"

static void *_actionName = "_actionName";

@implementation UIGestureRecognizer (Statistics)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSelector = @selector(initWithTarget:action:);
        SEL swizzingSelector = @selector(analysis_initWithTarget:action:);
        
        [CCHookUtility swizzlingInClass:[self class] originalSelector:originSelector swizzledSelector:swizzingSelector];
        
    });
}

- (instancetype)analysis_initWithTarget:(id)target action:(SEL)action{
    UIGestureRecognizer *selfGestureRecognizer = [self analysis_initWithTarget:target action:action];
    if (!target && !action) {
        return selfGestureRecognizer;
    }
    
    if ([target isKindOfClass:[UIScrollView class]]) {
        return selfGestureRecognizer;
    }
    
    Class class = [target class];
    
    SEL originalSEL = action;
    
    NSString * sel_name = [NSString stringWithFormat:@"%s_%@", class_getName([target class]),NSStringFromSelector(action)];
    SEL swizzledSEL =  NSSelectorFromString(sel_name);
    
    BOOL addMethod = class_addMethod(class,
                                       swizzledSEL,
                                       method_getImplementation(class_getInstanceMethod([self class], @selector(statistics_gesture:))),
                                       nil);
    
    if (addMethod) {
        [CCHookUtility swizzlingInClass:class originalSelector:originalSEL swizzledSelector:swizzledSEL];
    }
    
    if (objc_getAssociatedObject(self, &_actionName) == nil) {
        objc_setAssociatedObject(self, &_actionName, NSStringFromSelector(action), OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    return selfGestureRecognizer;
}

- (void)statistics_gesture:(UIGestureRecognizer *)gesture{
    NSString * identifier = [NSString stringWithFormat:@"%s_%@", class_getName([self class]),objc_getAssociatedObject(gesture, &_actionName)];
    
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void (*func)(id, SEL,id) = (void *)imp;
        func(self, sel,gesture);
    }
    
    if ([gesture isKindOfClass:[UIGestureRecognizer class]]) {
        [[StatisticsManager sharedInstance] sendEventWithTarget:NSStringFromClass([self class]) action:objc_getAssociatedObject(gesture, &_actionName) atIndex:gesture.view.tag type:StatisticsTypeControlEvent];
    }
}

@end
