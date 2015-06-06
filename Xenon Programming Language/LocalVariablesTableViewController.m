//
//  LocalVariablesTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/30/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "LocalVariablesTableViewController.h"
#import "XLocalVariable.h"

@implementation LocalVariablesTableViewController
- (void)setDisplayingLocalVariables:(NSMutableArray *)displayingLocalVariables
{
    _displayingLocalVariables = displayingLocalVariables;
    self.displayingVariables = displayingLocalVariables;
}

- (NSString *)reuseID
{
    return @"localVariable";
}

- (id)instanceForName:(id)name andType:(id)type
{
    XLocalVariable *lv = [[XLocalVariable alloc] init];
    lv.name = name;
    lv.type = type;
    return lv;
}

@end
