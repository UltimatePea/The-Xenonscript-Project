//
//  TypeSelectorTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/30/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "SearchTableViewController.h"
@class XType;
@class XFramework;
@interface TypeSelectorTableViewController : SearchTableViewController

@property (strong, nonatomic) void (^completionBlock)(XType *selectedType);
//@property (strong, nonatomic) XFramework *searchingFramwork;

@end
