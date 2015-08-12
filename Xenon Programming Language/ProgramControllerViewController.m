//
//  ProgramControllerViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProgramControllerViewController.h"
#import "ThreadLockingManager.h"
#import "Instance.h"
#import "NotificationCenterNameRecord.h"

@interface ProgramControllerViewController ()

@property (weak, nonatomic) Instance * pausingInstance;

@end

@implementation ProgramControllerViewController

- (void)loadView
{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CENTER_BREAK_POINT_NOTIFICATION object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self saveInstance:note.userInfo[@"info"]];
        });
    }];
}

- (void)saveInstance:(Instance *)instance
{
    self.pausingInstance = instance;
}

- (IBAction)pause:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPause = YES;
}

- (IBAction)play:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPauseForInstance = NO;
    [ThreadLockingManager sharedManager].shouldPauseForInstanceInstance = nil;
    [self playWithoutCancelingPausing:nil];
}

- (IBAction)playWithoutCancelingPausing:(id)sender
{
    [ThreadLockingManager sharedManager].shouldPause = NO;
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.lock = NO;
    [manager.condition lock];
    [manager.condition signal];
    [manager.condition unlock];
}
- (IBAction)stepOver:(id)sender {
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.shouldPauseForInstance = YES;
    manager.shouldPauseForInstanceInstance = self.pausingInstance;
    [self playWithoutCancelingPausing:nil];
}

- (IBAction)stepIn:(id)sender {
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.shouldPauseForInstance = YES;
    manager.shouldPauseForInstanceInstance = self.pausingInstance.childInstance;
    [self playWithoutCancelingPausing:nil];
    
}
- (IBAction)stepOut:(id)sender {
    ThreadLockingManager *manager = [ThreadLockingManager sharedManager];
    manager.shouldPauseForInstance = YES;
    manager.shouldPauseForInstanceInstance = self.pausingInstance.parentInstance;
    [self playWithoutCancelingPausing:nil];
}
- (IBAction)exit:(id)sender {
    [self pause:sender];
    [self play:sender];
    [self.tabBarController dismissViewControllerAnimated:YES completion:^{
        [ThreadLockingManager sharedManager].shouldCancel = YES;
    }];
    
}

@end
