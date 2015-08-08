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

- (void)pickProject:(UIViewController *)sender completion:(void (^)())comp
{
    ProjectSelectorTableViewController *pstvc = [[ProjectSelectorTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [pstvc setCompletionBlock:^(NSURL *selectedURL) {
        self.selectedProjectURL = selectedURL;
        self.detailTextLabel.text = selectedURL.pathComponents.lastObject;
        NSLog(@"textlabel set to %@", self.detailTextLabel.text);
        [self.detailTextLabel setNeedsDisplay];
        comp();
    }];
    [sender.navigationController pushViewController:pstvc animated:YES];
}
@end
