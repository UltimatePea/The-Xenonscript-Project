//
//  PlayBarItem.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "PlayBarItem.h"
#import "ThreadLockingManager.h"

@implementation PlayBarItem

- (void)play
{
    [ThreadLockingManager sharedManager].shouldPause = NO;
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.lock = NO;
    [manager.condition lock];
    [manager.condition signal];
    [manager.condition unlock];
}
- (instancetype)initWithDefaultConfiguration
{
    return self = [super initWithTitle:@"▶️" style:UIBarButtonItemStylePlain target:self action:@selector(play)];
}

+ (instancetype)playBarItem
{
    return [[PlayBarItem alloc] initWithDefaultConfiguration];
}

@end
