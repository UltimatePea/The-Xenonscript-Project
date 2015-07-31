//
//  NewMethodCallTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
@class XMethodCall;
@class XFramework;
@class XFunction;
@class XClass;

@interface NewMethodCallTableViewController : CommonViewController
@property (strong, nonatomic) void (^completionBlock)(XMethodCall *newMethodCall);
@property (strong, nonatomic) XFramework *inFramework;
@property (strong, nonatomic) XFunction *inFunction;
@property (strong, nonatomic) XClass *inClass;
@end
