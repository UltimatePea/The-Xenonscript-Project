//
//  PropertiesTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "PropertiesTableViewController.h"
#import "XProperty.h"


//@interface PropertiesTableViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@end


@implementation PropertiesTableViewController

- (void)setDisplayingProperties:(NSMutableArray *)displayingProperties
{
    _displayingProperties = displayingProperties;
    self.displayingVariables = displayingProperties;
}

- (NSString *)reuseID
{
    return @"property";
}


//may move to variables;


- (id)instanceForName:(id)name andType:(id)type
{
    XProperty *property = [[XProperty alloc] init];
    property.name = name;
    property.type = type;
    return property;
}


@end
