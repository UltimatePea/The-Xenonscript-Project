//
//  ThreadLockingManager.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/1/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ThreadLockingManager.h"

@implementation ThreadLockingManager

- (NSCondition *)condition
{
    if (!_condition) {
        _condition  = [[NSCondition alloc] init];
    }
    return _condition;
}

+ (instancetype)sharedManager;
{
    static ThreadLockingManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)clear
{
    self.lock = NO;
    self.shouldPause = NO;
    self.shouldPauseForInstance = NO;
    self.shouldPauseForInstanceInstance = nil;
    self.shouldCancel = NO;
}

- (BOOL)shouldPauseForInstance:(id)instance
{
    return self.shouldPauseForInstance&&[self.shouldPauseForInstanceInstance isEqual:instance];
}

@end
