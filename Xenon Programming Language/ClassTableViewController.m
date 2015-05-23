//
//  ClassTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ClassTableViewController.h"
#import "XClass.h"
#import "XName.h"
#import "PropertiesTableViewController.h"
#import "MethodsTableViewController.h"

@interface ClassTableViewController () <UITableViewDelegate>

@end

@implementation ClassTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [self.displayingClass.name stringRepresentation];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewController *tvc;
    switch (indexPath.row) {
        case 0:
            tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertiesTableViewController"];
            tvc.title = [NSString stringWithFormat:@"%@ : Properties", self.displayingClass.name.stringRepresentation];
            ((PropertiesTableViewController *)tvc).displayingProperties = self.displayingClass.properties;
            break;
        case 1:
            tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodsTableViewController"];
            tvc.title = [NSString stringWithFormat:@"%@ : Methods", self.displayingClass.name.stringRepresentation];
            ((MethodsTableViewController *)tvc).displayingMethods = self.displayingClass.methods;
            
        default:
            break;
    }
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
