//
//  DebuggerExitViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/1/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebuggerExitViewController.h"

@implementation DebuggerExitViewController
- (IBAction)exit:(id)sender {
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}

@end
