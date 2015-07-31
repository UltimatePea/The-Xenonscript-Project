//
//  NewNameTypeTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/31/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
@class XName;
@class XType;
@class XFramework;

@interface NewNameTypeTableViewController : CommonViewController

@property (strong, nonatomic) void (^completionBlock)(XName *name, XType *type);
@property (strong, nonatomic) XFramework *searchingFramework;
@property (strong, nonatomic) NSArray *titlesForNameAndType;
@end
