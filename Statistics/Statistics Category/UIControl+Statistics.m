//
//  UIControl+Statistics.m
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "UIControl+Statistics.h"
#import "CCHookUtility.h"
#import "StatisticsManager.h"
#import "objc/runtime.h"

@implementation UIControl (Statistics)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [CCHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}


#pragma mark - Method Swizzling

- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    [self swiz_sendAction:action to:target forEvent:event];
    [[StatisticsManager sharedInstance] sendEventWithTarget:NSStringFromClass([target class]) action:NSStringFromSelector(action) atIndex:0 type:StatisticsTypeControlEvent];
}


@end
