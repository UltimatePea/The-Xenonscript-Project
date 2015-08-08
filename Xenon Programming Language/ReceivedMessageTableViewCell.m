//
//  ReceivedMessageTableViewCell.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ReceivedMessageTableViewCell.h"
#import "ReceivedMessageView.h"
#import "ConsoleEntry.h"

@interface ReceivedMessageTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *textLabelMsg;
@property (weak, nonatomic) IBOutlet ReceivedMessageView *backgroundViewMsg;

@end

@implementation ReceivedMessageTableViewCell

- (void)setDisplayingEntry:(ConsoleEntry *)displayingEntry
{
    _displayingEntry = displayingEntry;
    self.textLabelMsg.text = displayingEntry.message;
    self.backgroundViewMsg.msgType = displayingEntry.msgType;
    [self.backgroundViewMsg setNeedsDisplay];
}
- (void)updateView
{
    [self.backgroundViewMsg setNeedsDisplay];
}
@end
