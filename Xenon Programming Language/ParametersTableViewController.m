//
//  ArgumentsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ParametersTableViewController.h"

@implementation ParametersTableViewController

- (void)setDisplayingParameters:(NSArray *)displayingArguments
{
    _displayingParameters = displayingArguments;
    self.displayingVariables = displayingArguments;
}

- (NSString *)reuseID
{
    return @"parameter";
}

@end
