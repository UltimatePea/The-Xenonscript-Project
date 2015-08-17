//
//  InstanceInspectorTableViewController.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/17/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Instance;


@interface InstanceInspectorTableViewController : UITableViewController

@property (weak, nonatomic) Instance *displayingInstance;

@end
