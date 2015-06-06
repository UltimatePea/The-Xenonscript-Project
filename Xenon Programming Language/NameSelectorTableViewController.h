//
//  NameSelectorTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "SearchTableViewController.h"
@class XClass;
@class XName;
@class XFunction;

@interface NameSelectorTableViewController : SearchTableViewController

@property (strong, nonatomic) void (^completionBlock)(XName *selectedInstanceName);
@property (strong, nonatomic) XClass *inClass;
@property (strong, nonatomic) XFunction *inFunction;


@end
