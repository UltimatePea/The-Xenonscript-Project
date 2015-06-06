//
//  FunctionTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XFunction;
@class XClass;
@class XFramework;
@interface FunctionTableViewController : UITableViewController

@property (strong, nonatomic) XFunction *displayingFunction;
@property (strong, nonatomic) XClass *inClass;
@property (strong, nonatomic) XFramework *inFramework;
@end
