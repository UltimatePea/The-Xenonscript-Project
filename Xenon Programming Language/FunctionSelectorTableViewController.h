//
//  FunctionSelectorTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/4/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "SearchTableViewController.h"
@class XClass;
@class XFunction;
@class XName;

@interface FunctionSelectorTableViewController : SearchTableViewController

#warning SERIOUS CODE DUPLICATION code duplication as Name Selector consider revising
@property (strong, nonatomic) void (^completionBlock)(XName *selectedInstanceName);
@property (strong, nonatomic) XClass *inClass;
@property (strong, nonatomic) XFunction *inFunction;



@end
