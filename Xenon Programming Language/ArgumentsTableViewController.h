//
//  ArgumentsTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/29/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "VariablesTableViewController.h"
@class XFunction;
@class XClass;
@interface ArgumentsTableViewController : VariablesTableViewController

@property (strong, nonatomic) NSMutableArray *displayingArguments;

@property (strong, nonatomic) XFunction *inFunction;
@property (strong, nonatomic) XClass *inClass;

@end
