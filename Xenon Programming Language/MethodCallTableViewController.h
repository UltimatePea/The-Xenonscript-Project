//
//  MethodCallTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/29/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XMethodCall;
@class XFunction;
@class XClass;
@class XFramework;

@interface MethodCallTableViewController : UITableViewController

@property (strong, nonatomic) XMethodCall *displayingMethodCall;

@property (strong, nonatomic) XFramework *inFramework;
@property (strong, nonatomic) XFunction *inFunction;
@property (strong, nonatomic) XClass *inClass;

@end
