//
//  PauseResumeToolbar.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "PauseBarItem.h"
#import "ThreadLockingManager.h"

@implementation PauseBarItem

+ (instancetype)pauseBarItem
{
    return [[self alloc] initWithDefaultConfiguration];
}

#define TITLE_PAUSE 

- (instancetype)initWithDefaultConfiguration
{
    return self = [super initWithTitle:@"⛔️" style:UIBarButtonItemStylePlain target:self action:@selector(pause:)];
}


- (void)pause:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPause = YES;
}

@end
