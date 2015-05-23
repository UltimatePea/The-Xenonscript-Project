//
//  VariablesTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/23/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "VariablesTableViewController.h"
#import "XVariable.h"
#import "XName.h"
#import "XType.h"

@implementation VariablesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayToReturnCount = self.displayingVariables;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XVariable *variable = object;
    return [variable.name stringRepresentation];
}

- (BOOL)didSelectObjectInArray:(id)object
{
    return NO;
}



- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    XVariable *variable = object;
    return [variable.type stringRepresentation];
}

@end
