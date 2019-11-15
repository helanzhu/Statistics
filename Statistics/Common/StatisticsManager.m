//
//  StatisticsManager.m
//  Statistics
//
//  Created by chenqg on 2019/11/12.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "StatisticsManager.h"

@interface StatisticsManager()

@property (nonatomic, strong) NSDictionary *statisticsDic;

@end

@implementation StatisticsManager

+ (instancetype)sharedInstance{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)sendEventWithTarget:(NSString *)targetString action:(NSString *)actionString atIndex:(NSUInteger)index type:(StatisticsType)type{

    NSDictionary *configDict = self.statisticsDic;
    NSString *eventID = nil;

    if (targetString.length == 0 || actionString.length == 0 || !targetString || !actionString) {
        return;
    }
    
    if (![[configDict objectForKey:targetString] isKindOfClass:[NSDictionary class]]){
        return;
    }

    if (type == StatisticsTypeControlEvent) {
        eventID = configDict[targetString][@"ControlEventIDs"][actionString];
        
    }else{
        eventID = configDict[targetString][@"PageEventIDs"][actionString];
    }
    
    NSLog(@"eventID = %@",eventID);
 
}

#pragma mark - getter

- (NSDictionary *)statisticsDic{
    if (!_statisticsDic){

        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"StatisticsConfig" ofType:@"plist"];
        _statisticsDic = [NSDictionary dictionaryWithContentsOfFile:filePath];

    }

    return _statisticsDic;
}

@end
