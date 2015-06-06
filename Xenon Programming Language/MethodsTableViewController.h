//
//  MethodsTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"
@class XClass;
@interface MethodsTableViewController : GenericTableViewController

@property (strong, nonatomic) NSMutableArray *displayingMethods;

@property (strong, nonatomic) XClass *inClass;
@end
