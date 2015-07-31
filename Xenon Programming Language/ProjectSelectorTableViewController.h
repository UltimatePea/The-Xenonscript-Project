//
//  ProjectSelectorTableViewController.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectsTableViewController.h"

@interface ProjectSelectorTableViewController : ProjectsTableViewController

@property (strong, nonatomic) void (^completionBlock)(NSURL *selectedProjectURL);

@end
