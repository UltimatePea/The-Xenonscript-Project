//
//  MethodsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "MethodsTableViewController.h"
#import "FunctionTableViewController.h"
#import "XFunction.h"
#import "XName.h"
#import "XType.h"

@implementation MethodsTableViewController

- (void)viewDidLoad
{
    self.arrayToReturnCount = self.displayingMethods;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XFunction *func = object;
    return [func.name stringRepresentation];
}

- (BOOL)didSelectObjectInArray:(id)object
{
    FunctionTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FunctionTableViewController"];
    ftvc.displayingFunction = object;
    [self.navigationController pushViewController:ftvc animated:YES];
    return YES;
}

- (NSString *)reuseID
{
    return @"method";
}

- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    XFunction *func = object;
    return [func.returnType stringRepresentation];
}

@end
