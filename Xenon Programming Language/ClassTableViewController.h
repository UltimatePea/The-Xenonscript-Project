//
//  ClassTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XClass;

@interface ClassTableViewController : UITableViewController

@property (strong, nonatomic) XClass *displayingClass;

@end
