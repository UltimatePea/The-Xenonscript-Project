//
//  XenonscriptRunningUIViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/9/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XenonscriptRunningUIViewController.h"
#import "SharedRuntimeUI.h"

@implementation XenonscriptRunningUIViewController

- (void)loadView
{
    [super loadView];
    [SharedRuntimeUI sharedRuntimeUI].sharedViewController = self;
}

- (void)showViewController:(nonnull UIViewController *)vc sender:(nullable id)sender
{
    [super showViewController:vc sender:sender];
}

@end
