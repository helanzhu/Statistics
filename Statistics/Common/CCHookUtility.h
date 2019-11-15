//
//  CCHookUtility.h
//  Statistics
//
//  Created by chenqg on 2019/11/14.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCHookUtility : NSObject

+ (void)swizzlingInClass:(Class)cls originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
