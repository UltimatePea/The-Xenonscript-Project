//
//  BranchTableViewCell.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UAGithubEngine;

@interface BranchTableViewCell : UITableViewCell

@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UAGithubEngine *engine;
@property (strong, nonatomic) NSString *repoName, *branchName;
- (void)pickBranch;
- (void)setupWithEngine:(UAGithubEngine *)engine repoName:(NSString *)repoName viewController:(UIViewController *)vc;
@end
