//
//  NewMethodCallTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "NewMethodCallTableViewController.h"
#import "NameSelectorTableViewController.h"
#import "FunctionSelectorTableViewController.h"
#import "XMethodCall.h"
#import "XName.h"
#import "UserPrompter.h"

@interface NewMethodCallTableViewController ()

@property (strong, nonatomic) XMethodCall *methodCall;
@property (weak, nonatomic) IBOutlet UITableViewCell *selectInstanceTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *selectFunctionTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *EnterSerializedCallStatementTableViewCell;


@end

@implementation NewMethodCallTableViewController

- (XMethodCall *)methodCall
{
    if (!_methodCall) {
        _methodCall = [[XMethodCall alloc] init];
        _methodCall.instanceName = [[XName alloc] initWithString:@"this"];
    }
    return _methodCall;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateTable];
    
}

- (void)updateTable
{
#warning NEED TO RESEARCH THIS ONE
    self.selectInstanceTableViewCell.detailTextLabel.text = [self.methodCall.instanceStringRepresentation isEqualToString:INSTANCE_STRING_REP_NIL]?@"this":self.methodCall.instanceStringRepresentation;
    self.selectFunctionTableViewCell.detailTextLabel.text = self.methodCall.functionName.stringRepresentation;
    [self.selectFunctionTableViewCell setNeedsLayout];
    [self.selectInstanceTableViewCell setNeedsLayout];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
}
- (void)done:(id)sender
{
    if (!self.methodCall.functionName) {
        [UserPrompter promptUserMessage:@"Function name must be specified" withViewController:self];
        return;
    }
    self.completionBlock(self.methodCall);
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.selectInstanceTableViewCell]) {
        [UserPrompter actionSheetWithTitle:@"Select Instance" message:nil normalActions:@[@"Instance Name", @"New Method Call"] cancelActions:@[@"Cancel"] destructiveActions:nil sendingVC:self completionBlock:^(NSUInteger selectedStringIndex, int actionType) {
            switch (actionType) {
                case ACTION_TYPE_DEFAULT:
                    switch (selectedStringIndex) {
                        case 0:
                            [self selectName];
                            break;
                        case 1:
                            [self selectMethodCall];
                            
                        default:
                            break;
                    }
                    break;
                    
                default:
                    break;
            }
        }];
        
    } else if([cell isEqual:self.selectFunctionTableViewCell]){
        FunctionSelectorTableViewController *fstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FunctionSelectorTableViewController"];
        [fstvc setCompletionBlock:^(XName *selectedInstanceName) {
            self.methodCall.functionName = selectedInstanceName;
            [self updateTable];
        }];
        fstvc.inFramework = self.inFramework;
        fstvc.inClass = self.inClass;
        fstvc.inFunction = self.inFunction;
        [self.navigationController pushViewController:fstvc animated:YES];
    }
}

- (void)selectName
{
    NameSelectorTableViewController *nstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"NameSelectorTableViewController"];
    [nstvc setCompletionBlock:^(XName *name) {
        self.methodCall.instanceName = name;
        [self updateTable];
    }];
    nstvc.inFramework = self.inFramework;
    nstvc.inFunction = self.inFunction;
    nstvc.inClass = self.inClass;
    [self.navigationController pushViewController:nstvc animated:YES];
}

- (void)selectMethodCall
{
#warning SERIOUS Code Duplication as MethodCallsTVC
    NewMethodCallTableViewController *nmctvc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NewMethodCallTableViewController"];
    [nmctvc setCompletionBlock:^(XMethodCall *newMethodCall) {
        self.methodCall.instanceMethodCall = newMethodCall;
        [self updateTable];
    }];
    nmctvc.inFramework = self.inFramework;
    nmctvc.inFunction = self.inFunction;
    nmctvc.inClass = self.inClass;
    [self.navigationController pushViewController:nmctvc animated:YES];
}


@end
