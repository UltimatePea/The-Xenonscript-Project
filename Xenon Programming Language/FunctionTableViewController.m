//
//  FunctionTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FunctionTableViewController.h"
#import "ParametersTableViewController.h"
#import "MethodCallsTableViewController.h"
#import "LocalVariablesTableViewController.h"
#import "MethodsTableViewController.h"
#import "XFunction.h"
#import "XName.h"
#import "XType.h"

@interface FunctionTableViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *functionNameTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *functionReturnTypeTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *parameterTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *localVariablesTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *localFunctionsTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *methodCallsTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *overviewTableViewCell;



@end

@implementation FunctionTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.functionNameTableViewCell.detailTextLabel.text = [self.displayingFunction.name stringRepresentation];
    self.functionReturnTypeTableViewCell.detailTextLabel.text = [self.displayingFunction.returnType stringRepresentation];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.parameterTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFunction.parameters.count];
    self.localVariablesTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFunction.localVariables.count];
    self.methodCallsTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFunction.methodCalls.count];
    self.localFunctionsTableViewCell.detailTextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.displayingFunction.localFunctions.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.parameterTableViewCell]) {
        [self tapParameter:nil];
    } else if ([cell isEqual:self.methodCallsTableViewCell]){
        [self tapMethodCalls:nil];
    } else if ([cell isEqual:self.localVariablesTableViewCell]){
        [self tapLocalVariables:nil];
    } else if ([cell isEqual:self.localFunctionsTableViewCell]){
        [self tapLocalFunctions:nil];
    } else if ([cell isEqual:self.overviewTableViewCell]){
        [self tapOverview:nil];
    }
}

- (void)tapParameter:(id)sender
{
    ParametersTableViewController *ptvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParametersTableViewController"];
    ptvc.displayingParameters = self.displayingFunction.parameters;
    ptvc.inFramework = self.inFramework;
    [self.navigationController pushViewController:ptvc animated:YES];
}

- (void)tapMethodCalls:(id)sender
{
    MethodCallsTableViewController *mctvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodCallsTableViewController"];
    mctvc.displayingMethodCalls = self.displayingFunction.methodCalls;
    mctvc.inFramework = self.inFramework;
    mctvc.inClass = self.inClass;
    mctvc.inFunction = self.displayingFunction;
    [self.navigationController pushViewController:mctvc animated:YES];
}

- (void)tapLocalVariables:(id)sender
{
    LocalVariablesTableViewController *lvtvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocalVariablesTableViewController"];
    lvtvc.displayingLocalVariables = self.displayingFunction.localVariables;
    lvtvc.inFramework = self.inFramework;
    
    [self.navigationController pushViewController:lvtvc animated:YES];
}

- (void)tapLocalFunctions:(id)sender
{
    MethodsTableViewController *mtvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodsTableViewController"];
    mtvc.displayingMethods = self.displayingFunction.localFunctions;
    mtvc.inFramework = self.inFramework;
    [self.navigationController pushViewController:mtvc animated:YES];
}

- (void)tapOverview:(id)sender
{
    
}



@end
