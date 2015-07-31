//
//  ProjectSelectorTableViewCell.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectSelectorTableViewCell.h"
#import "ProjectSelectorTableViewController.h"

@implementation ProjectSelectorTableViewCell

- (void)pickProject:(UIViewController *)sender;
{
    ProjectSelectorTableViewController *pstvc = [[ProjectSelectorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [pstvc setCompletionBlock:^(NSURL *selectedURL) {
        self.selectedProjectURL = selectedURL;
        self.detailTextLabel.text = selectedURL.pathComponents.lastObject;
    }];
    [sender.navigationController pushViewController:pstvc animated:YES];
}
@end
