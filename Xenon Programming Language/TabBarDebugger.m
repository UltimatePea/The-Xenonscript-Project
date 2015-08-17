//
//  TabBarDebugger.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/1/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "TabBarDebugger.h"
#import "NotificationCenterNameRecord.h"
//#import "ConsoleAlertViewController.h"

@implementation TabBarDebugger

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *array = [NSMutableArray arrayWithArray: self.viewControllers];
    for (UINavigationController *nc in self.viewControllers) {
        nc.viewControllers[0].view;
    }
//    ConsoleAlertViewController *ac = [ConsoleAlertViewController alertControllerWithTitle:@"Running" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [array insertObject:ac atIndex:0];
//    self.viewControllers = array;
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CENTER_SELECTED_STACK_TRACE_NOTIFICATION
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectedViewController = self.viewControllers[self.viewControllers.count - 2];
        });
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CENTER_RESUMED_EXECUTION
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.selectedViewController = self.viewControllers.firstObject;
        });
    }];
}

@end
