//
//  GitHubCommunicationTableViewController.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

@import UIKit;
@class UAGithubEngine;

@interface GitHubCommunicationTableViewController : UITableViewController

@property (strong, nonatomic) UAGithubEngine *engine;
@property (strong, nonatomic) NSString *repositoryName;
@end
