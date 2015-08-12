//
//  ThreadLockingManager.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/1/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThreadLockingManager : NSObject

@property (strong, nonatomic) NSCondition *condition;
@property ( nonatomic) BOOL lock;
@property ( nonatomic) BOOL shouldPause, shouldPauseForInstance, shouldCancel;
@property (weak, nonatomic) id shouldPauseForInstanceInstance;


+ (instancetype)sharedManager;
- (void)clear;
- (BOOL)shouldPauseForInstance:(id)instance;
@end
