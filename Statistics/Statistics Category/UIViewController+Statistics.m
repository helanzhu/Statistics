//
//  UIViewController+Statistics.m
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "UIViewController+Statistics.h"
#import "CCHookUtility.h"
#import "StatisticsManager.h"

@implementation UIViewController (Statistics)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
                
        SEL willAppearSelector = @selector(viewWillAppear:);
        SEL swizzled_willAppearSelector = @selector(swiz_viewWillAppear:);
        [CCHookUtility swizzlingInClass:[self class] originalSelector:willAppearSelector swizzledSelector:swizzled_willAppearSelector];
        
        SEL willDisappearSelector = @selector(viewWillDisappear:);
        SEL swizzled_WillDisappearSelector = @selector(swiz_viewWillDisappear:);
        [CCHookUtility swizzlingInClass:[self class] originalSelector:willDisappearSelector swizzledSelector:swizzled_WillDisappearSelector];
    });
}

#pragma mark - Method Swizzling

- (void)swiz_viewWillAppear:(BOOL)animated{
    [self swiz_viewWillAppear:animated];
        
    [[StatisticsManager sharedInstance] sendEventWithTarget:NSStringFromClass([self class]) action:NSStringFromSelector(@selector(viewWillAppear:)) atIndex:0 type:StatisticsTypePageEvent];

}

- (void)swiz_viewWillDisappear:(BOOL)animated{
    [self swiz_viewWillDisappear:animated];
    
    [[StatisticsManager sharedInstance] sendEventWithTarget:NSStringFromClass([self class]) action:NSStringFromSelector(@selector(viewWillDisappear:)) atIndex:0 type:StatisticsTypePageEvent];

}


@end
