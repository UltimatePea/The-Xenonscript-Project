//
//  MethodCallTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/29/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "MethodCallTableViewController.h"
#import "ArgumentsTableViewController.h"
#import "XMethodCall.h"
#import "XName.h"
@interface MethodCallTableViewController ()<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *instanceTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *functionNameTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *argumentsTableViewCell;

@end

@implementation MethodCallTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.instanceTableViewCell.textLabel.text = ([self.displayingMethodCall.instanceStringRepresentation isEqualToString:INSTANCE_STRING_REP_NIL])?@"this":self.displayingMethodCall.instanceStringRepresentation;
    self.functionNameTableViewCell.textLabel.text = self.displayingMethodCall.functionName.stringRepresentation;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.argumentsTableViewCell]) {
        ArgumentsTableViewController *atvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ArgumentsTableViewController"];
        atvc.displayingArguments = self.displayingMethodCall.arguments;
        atvc.inFramework = self.inFramework;
        atvc.inClass = self.inClass;
        atvc.inFunction = self.inFunction;
        [self.navigationController pushViewController:atvc animated:YES];
    }
}


@end
