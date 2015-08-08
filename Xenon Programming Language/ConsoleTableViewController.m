//
//  ConsoleTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ConsoleTableViewController.h"
#import "ConsoleEntry.h"
#import "Console.h"
#import "DebugProgramControllToolbar.h"
#import "ReceivedMessageTableViewCell.h"

@interface ConsoleTableViewController () <ConsoleDelegate>

@property (strong, nonatomic) Console *console;

@end

@implementation ConsoleTableViewController

- (Console *)console
{
    if (!_console) {
        _console = [Console sharedConsole];
        _console.delegate = self;
    }
    return _console;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.toolbarItems = [DebugProgramControllToolbar sharedToolbar].items;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
//    [self.navigationController.toolbar setNeedsDisplay];
}

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.console.allEntries.count;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ReceivedMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ReceivedMessageTableViewCell class])];
    cell.displayingEntry = self.console.allEntries[indexPath.row];
    [cell updateView];
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 40;
}
- (void)console:(Console *)consle didAppendEntry:(ConsoleEntry *)entry
{
    if (self.isViewLoaded && self.view.window &&[self.tabBarController.selectedViewController isEqual:self.navigationController]) {
        
        [self.tableView reloadData];
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.tableView numberOfRowsInSection:0] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}



@end
