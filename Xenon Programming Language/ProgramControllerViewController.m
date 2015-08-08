//
//  ProgramControllerViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProgramControllerViewController.h"
#import "ThreadLockingManager.h"
@implementation ProgramControllerViewController


- (IBAction)pause:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPause = YES;
}

- (IBAction)play:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPause = NO;
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.lock = NO;
    [manager.condition lock];
    [manager.condition signal];
    [manager.condition unlock];
}
- (IBAction)stepOver:(id)sender {
}
- (IBAction)stepIn:(id)sender {
}

@end
