//
//  FrameworkTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

@import UIKit;
#import "CommonViewController.h"
@class XFramework;

@interface FrameworkTableViewController : CommonViewController

@property (strong, nonatomic) XFramework    *displayingFramework;

@end
