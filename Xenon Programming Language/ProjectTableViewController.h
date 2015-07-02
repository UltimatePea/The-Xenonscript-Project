//
//  ProjectTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FrameworkTableViewController.h"
@class XProject;

@interface ProjectTableViewController : FrameworkTableViewController

@property (strong, nonatomic) XProject *displayingProject;

@end
