//
//  FrameworksTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FrameworksTableViewController.h"
#import "FrameworkTableViewController.h"
#import "XFramework.h"
#import "XName.h"

@implementation FrameworksTableViewController

- (void)viewDidLoad
{
    self.arrayToReturnCount = self.displayingFrameworks;
}
- (NSString *)titleLabelForObjectInArray:(id)object
{
    XFramework *fram = object;
    return fram.name.stringRepresentation;
}

- (BOOL)didSelectObjectInArray:(id)object//return NO if you want to deselect
{
    FrameworkTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FrameworkTableViewController"];
    ftvc.displayingFramework = object;
    [self.navigationController pushViewController:ftvc animated:YES];
    return YES;
}
- (NSString *)reuseID
{
    return @"framework";
}

@end
