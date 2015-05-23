//
//  FunctionTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FunctionTableViewController.h"
#import "ParametersTableViewController.h"
#import "XFunction.h"
#import "XName.h"
#import "XType.h"

@interface FunctionTableViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *functionNameTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *functionReturnTypeTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *parameterTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *methodCallsTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *overviewTableViewCell;

@end

@implementation FunctionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.functionNameTableViewCell.textLabel.text = [self.displayingFunction.name stringRepresentation];
    self.functionReturnTypeTableViewCell.textLabel.text = [self.displayingFunction.returnType stringRepresentation];
/*
//    [self addTapGestureToView:self.argumentTableViewCell withSelector:@selector(tapArgument:)];
//    [self addTapGestureToView:self.methodCallsTableViewCell withSelector:@selector(tapMethodCalls:)];
//    [self addTapGestureToView:self.overviewTableViewCell withSelector:@selector(tapOverview:)];
//
//    
//}
//
//- (void)addTapGestureToView:(UIView *)view withSelector:(SEL)selector
//{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
//    [view addGestureRecognizer:tap];
 */
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.parameterTableViewCell]) {
        [self tapParameter:nil];
    } else if ([cell isEqual:self.methodCallsTableViewCell]){
        [self tapMethodCalls:nil];
    } else if ([cell isEqual:self.overviewTableViewCell]){
        [self tapOverview:nil];
    }
}

- (void)tapParameter:(id)sender
{
    ParametersTableViewController *ptvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParametersTableViewController"];
    ptvc.displayingParameters = self.displayingFunction.parameters;
    [self.navigationController pushViewController:ptvc animated:YES];
}

- (void)tapMethodCalls:(id)sender
{
    
}

- (void)tapOverview:(id)sender
{
    
}



@end
