//
//  ReceivedMessageTableViewCell.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConsoleEntry;

@interface ReceivedMessageTableViewCell : UITableViewCell

@property (strong, nonatomic) ConsoleEntry *displayingEntry;
- (void)updateView;
@end
