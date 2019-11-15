//
//  UITableView+Statistics.m
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "UITableView+Statistics.h"
#import "CCHookUtility.h"
#import "StatisticsManager.h"
#import <objc/runtime.h>

@implementation UITableView (Statistics)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originSelector = @selector(setDelegate:);
        SEL swizzingSelector = @selector(analysis_setDelegate:);
        [CCHookUtility swizzlingInClass:[self class] originalSelector:originSelector swizzledSelector:swizzingSelector];
    });
}


- (void)analysis_setDelegate:(id)delegate{
    [self analysis_setDelegate:delegate];
    
    if (delegate) {
        SEL originSelector = @selector(tableView:didSelectRowAtIndexPath:);
        SEL swizzingSelector = @selector(analysis_tableView:didSelectRowAtIndexPath:);

        BOOL addMethod = class_addMethod([delegate class],
                        swizzingSelector,
                        method_getImplementation(class_getInstanceMethod([self class], swizzingSelector)),
                        method_getTypeEncoding(class_getInstanceMethod([self class],swizzingSelector)));

        if (addMethod) {
            [CCHookUtility swizzlingInClass:[delegate class] originalSelector:originSelector swizzledSelector:swizzingSelector];

        }
    }

}

- (void)analysis_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@ - %@",[self class],indexPath);
    
    [self analysis_tableView:tableView didSelectRowAtIndexPath:indexPath];
    [[StatisticsManager sharedInstance] sendEventWithTarget:NSStringFromClass([self class]) action:NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:)) atIndex:indexPath.row type:StatisticsTypeControlEvent];
    
}


@end
