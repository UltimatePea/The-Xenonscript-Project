//
//  CodesDebuggerTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/10/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "CodesDebuggerTableViewController.h"
#import "NotificationCenterNameRecord.h"
#import "StackTraceEntry.h"
#import "Instance.h"
#import "XFunction.h"
#import "ProjectAnalyzer.h"
#import "Stack.h"
#import "StackTraceEntryContext.h"

@interface CodesDebuggerTableViewController ()

//@property (strong, nonatomic) StackTraceEntry *currentlyDisplayingEntry;
@property (strong, nonatomic) XMethodCall *showingMethodCall;
@end


@implementation CodesDebuggerTableViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];//will reload data
//    [self.tableView reloadData];
    
}

- (void)loadView
{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserverForName:NOTIFICATION_CENTER_SELECTED_STACK_TRACE_NOTIFICATION object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self analyzeStackEntry:note.userInfo[NOTIFICATION_CENTER_SELECTED_STACK_TRACE_NOTIFICATION_USER_INFO_KEY_ENTRY]];
        });
    }];
}

- (void)analyzeStackEntry:(StackTraceEntry *)entry
{
    StackTraceEntryContext *context = [[Stack sharedStack] contextForStackTraceEntry:entry];
    self.showingMethodCall = context.showingMethodCall;
    self.displayingMethodCalls = context.inFunction.methodCalls;
    NSLog(@"CODES DISPLAY: %@", self.displayingMethodCalls);
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if ([self.displayingMethodCalls[indexPath.row] isEqual:self.showingMethodCall] ) {
        cell.textLabel.textColor = [UIColor greenColor];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    return cell;
}

- (NSString *)reuseID
{
    return @"CodesDebuggerTableViewControllerCell";
}

@end
