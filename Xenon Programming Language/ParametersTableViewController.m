//
//  ArgumentsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ParametersTableViewController.h"
#import "XParameter.h"

@implementation ParametersTableViewController

- (void)setDisplayingParameters:(NSMutableArray *)displayingArguments
{
    _displayingParameters = displayingArguments;
    self.displayingVariables = displayingArguments;
}

- (NSString *)reuseID
{
    return @"parameter";
}

- (id)instanceForName:(id)name andType:(id)type
{
    XParameter *param = [[XParameter alloc] init];
    param.name = name;
    param.type = type;
    return param;
}

@end
