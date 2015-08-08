//
//  FrameworkTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FrameworkTableViewController.h"
#import "XFramework.h"
#import "FrameworksTableViewController.h"
#import "ClassesTableViewController.h"
@interface FrameworkTableViewController ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *linkedFrameworkTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *classesTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *shareButton;

@end


@implementation FrameworkTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.linkedFrameworkTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFramework.linkedFrameworks.count];
    self.classesTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFramework.classes.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.linkedFrameworkTableViewCell]) {
        FrameworksTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FrameworksTableViewController"];
        ftvc.displayingFrameworks = self.displayingFramework.linkedFrameworks;
        [self.navigationController pushViewController:ftvc animated:YES];
    } else if ([cell isEqual:self.classesTableViewCell]){
        ClassesTableViewController *ctvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassesTableViewController"];
        ctvc.inFramework = self.displayingFramework;
        ctvc.displayingClasses = self.displayingFramework.classes;
        [self.navigationController pushViewController:ctvc animated:YES];
    } else if([cell isEqual:self.shareButton]){
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        [self share];
    }
}
- (void)share
{
    
}

@end
