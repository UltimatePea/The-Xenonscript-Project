//
//  VariablesTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/23/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"

@class XName;
@class XType;

@interface VariablesTableViewController : GenericTableViewController

@property (strong, nonatomic) NSMutableArray *displayingVariables;

- (id)instanceForName:(XName *)name andType:(XType *)type;


@end
