//
//  MethodCallsTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"
@class XFunction;
@class XClass;
@interface MethodCallsTableViewController : GenericTableViewController

@property (strong, nonatomic) NSMutableArray *displayingMethodCalls;

@property (strong, nonatomic) XFunction *inFunction;
@property (strong, nonatomic) XClass *inClass;
@end
