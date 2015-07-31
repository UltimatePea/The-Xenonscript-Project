//
//  ClassTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
@class XClass;
@class XFramework;

#warning SERIOUS DESIGN PROBLEM Each class has to implement inCLass and inFunction Method

@interface ClassTableViewController : CommonViewController

@property (strong, nonatomic) XClass *displayingClass;
@property (strong, nonatomic) XFramework *inFramework;
@end
