//
//  NewNameTypeTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/31/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XName;
@class XType;
@class XFramework;

@interface NewNameTypeTableViewController : UITableViewController

@property (strong, nonatomic) void (^completionBlock)(XName *name, XType *type);
@property (strong, nonatomic) XFramework *searchingFramework;
@end
