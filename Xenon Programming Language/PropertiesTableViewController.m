//
//  PropertiesTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "PropertiesTableViewController.h"
#import "XProperty.h"
#import "XName.h"
#import "XType.h"

//@interface PropertiesTableViewController ()<UITableViewDataSource, UITableViewDelegate>
//
//@end


@implementation PropertiesTableViewController

- (void)setDisplayingProperties:(NSArray *)displayingProperties
{
    _displayingProperties = displayingProperties;
    self.displayingVariables = displayingProperties;
}

- (NSString *)reuseID
{
    return @"property";
}


@end
