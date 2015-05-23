//
//  ProjectTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"
@class XFramework;

@interface ProjectTableViewController : GenericTableViewController

@property (strong, nonatomic) XFramework *displayingFramework;

@end
