//
//  StackTraceTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/1/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "StackTraceTableViewController.h"
#import "Instance.h"
#import "XClass.h"
#import "XName.h"
#import "StackTraceEntry.h"
#import "Stack.h"
#import "DebugProgramControllToolbar.h"
@interface StackTraceTableViewController ()
@property (strong, nonatomic) NSMutableArray<StackTraceEntry *> *methodCalls;
@end

@implementation StackTraceTableViewController

- (NSMutableArray *)methodCalls
{
    if (!_methodCalls) {
        _methodCalls = [NSMutableArray array];
    }
    return _methodCalls;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.toolbarItems = [[DebugProgramControllToolbar sharedToolbar] items];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    
}

- (void)loadView
{
    [super loadView];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"BREAK_POINT_NOTIFICATION" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self generateStackTrace:note.userInfo[@"info"]];
        });
    }];
}

- (void)generateStackTrace:(Instance *)inst
{
    NSLog(@"GENERATIONG STACK TRACE");
    NSMutableArray *stackTrace =
//    [NSMutableArray array];
//    while (inst.parentInstance.currentlyRespondingToMethodName) {
//        StackTraceEntry *entry = [[StackTraceEntry alloc] init];
//        entry.callingMethodName = inst.parentInstance.currentlyRespondingToMethodName;
//        entry.className = inst.name;
//        [stackTrace addObject:entry];
//        NSLog(@"Stack Trace for %@ generated.", inst.parentInstance.currentlyRespondingToMethodName);
//        inst = inst.parentInstance;
//    }
    [[Stack sharedStack] stackInstanceEntries];
    
    self.methodCalls = stackTrace;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.methodCalls.count;
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StackTraceTableViewControllerCell" forIndexPath:indexPath];
    cell.textLabel.text = self.methodCalls[indexPath.row].className;
    cell.detailTextLabel.text = self.methodCalls[indexPath.row].callingMethodName;
    return cell;
}


@end
