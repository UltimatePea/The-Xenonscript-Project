//
//  ProjectSelectorTableViewCell.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectSelectorTableViewCell : UITableViewCell

- (void)pickProject:(UIViewController *)sender;
@property (strong, nonatomic) NSURL *selectedProjectURL;

@end
