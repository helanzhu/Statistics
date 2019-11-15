//
//  StatisticsManager.h
//  Statistics
//
//  Created by chenqg on 2019/11/12.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,StatisticsType){
    StatisticsTypePageEvent = 1,
    StatisticsTypeControlEvent
};


@interface StatisticsManager : NSObject

+ (instancetype)sharedInstance;

- (void)sendEventWithTarget:(NSString *)target action:(NSString *)actionString atIndex:(NSUInteger)index type:(StatisticsType)type;

@end

