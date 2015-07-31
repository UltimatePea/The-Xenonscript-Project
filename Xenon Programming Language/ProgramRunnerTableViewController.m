//
//  ProgramRunnerTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/3/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProgramRunnerTableViewController.h"
#import "ProjectSelectorTableViewController.h"
#import "UserPrompter.h"
#import "XProject.h"
#import "ProjectsManager.h"
#import "XName.h"
#import "ProgramLoader.h"
#import "ConsoleAlertViewController.h"
#import "ProjectSelectorTableViewCell.h"
@interface ProgramRunnerTableViewController ()
@property (weak, nonatomic) IBOutlet ProjectSelectorTableViewCell *projectTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *startTableViewCell;

@property (strong, nonatomic) ProjectsManager *manager;
@end

@implementation ProgramRunnerTableViewController

- (ProjectsManager *)manager
{
    if (!_manager) {
        _manager = [ProjectsManager sharedProjectsManager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_PROJ" object:self];
    self.startTableViewCell.textLabel.textColor = self.startTableViewCell.textLabel.tintColor;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_PROJ" object:self];
    NSURL *expectedProjURL = [self.manager mostRecentModifiedProjectURL];
    if (expectedProjURL) {
        self.projectTableViewCell.selectedProjectURL = expectedProjURL;
        self.projectTableViewCell.detailTextLabel.text = expectedProjURL.pathComponents.lastObject;
    } else {
        [UserPrompter promptUserMessage:@"You do not have a project to run" withViewController:self];
    }
    
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.startTableViewCell]) {
        [self runProject];
    } else if ([cell isEqual:self.projectTableViewCell]){
        [self.projectTableViewCell pickProject:self];
    }
}

- (void)runProject
{
    if (!self.projectTableViewCell.selectedProjectURL) {
        [UserPrompter promptUserMessage:@"Please first select a project or create one." withViewController:self];
        return;
    }
    ConsoleAlertViewController *ac = [ConsoleAlertViewController alertControllerWithTitle:@"Running" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:ac animated:YES completion:^{
        ProgramLoader *loader = [[ProgramLoader alloc] initWithProject:[[XProject alloc] initWithURL:self.projectTableViewCell.selectedProjectURL] delegate:nil];
        dispatch_queue_t queue = dispatch_queue_create("queue for custom programms", NULL);
        dispatch_async(queue, ^{
            [loader start];
        });
        
    }];
    
    
}

@end
