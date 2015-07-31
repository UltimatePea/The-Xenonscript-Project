//
//  ProjectSelectorTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectSelectorTableViewController.h"

@implementation ProjectSelectorTableViewController
#define REUSE_ID @"ProjectSelectorTableViewCell"
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSE_ID]
    ;
    self.title = @"Select A Project";
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    self.completionBlock(self.arrayToReturnCount[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)reuseID
{
    return REUSE_ID;
}

@end
