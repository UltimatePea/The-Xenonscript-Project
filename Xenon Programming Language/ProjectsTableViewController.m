//
//  ProjectsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "ProjectTableViewController.h"
#import "XProject.h"
#import "XName.h"

#import "UserPrompter.h"
#import "ProjectsManager.h"

#import "XClass.h"
#import "XType.h"
#import "XFunction.h"
@interface ProjectsTableViewController ()

@property (strong, nonatomic)   ProjectsManager *projectsManager;

@end

@implementation ProjectsTableViewController

- (ProjectsManager *)projectsManager
{
    if (!_projectsManager) {
        _projectsManager = [ProjectsManager sharedProjectsManager];
    }
    return _projectsManager;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDisplayingProjects];
    self.arrayToReturnCount = self.displayingProjectURLs;
}

- (void)loadDisplayingProjects
{
    self.displayingProjectURLs = [self.projectsManager projectsURLsAvailable];
}


- (NSString *)titleLabelForObjectInArray:(id)object
{
    NSURL *url = object;
    return url.pathComponents.lastObject;
}

- (BOOL)didSelectObjectInArray:(id)object//return NO if you want to deselect
{
    ProjectTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectTableViewController"];
    ftvc.displayingProject = [[XProject alloc] initWithURL:object];
    [self.navigationController pushViewController:ftvc animated:YES];
    return YES;
}

- (void)confirmDeleting:(id)objectToBeDeleted completion:(void (^)(BOOL))completionBlock
{
    [UserPrompter actionSheetWithTitle:@"Do you really want to delete this project?" message:@"This action is irreversible" normalActions:nil cancelActions:@[@"Cancel"] destructiveActions:@[@"YES"] sendingVC:self completionBlock:^(NSUInteger selectedStringIndex, int actionType) {
        if (actionType==ACTION_TYPE_DESTRUCTIVE) {
            [self.projectsManager deleteProjectAtURL:objectToBeDeleted];
            completionBlock(YES);
            
        }
    }];

}

- (NSString *)reuseID
{
    return @"project";
}

- (BOOL)canAddItem
{
    return YES;
}

- (BOOL)canEditTable
{
    return YES;
}

- (void)addNewItem:(void (^)(id))completionBlock
{
    [UserPrompter getTextMessageFromUser:@"New Project Name" withViewController:self completionBlock:^(NSString *enteredText) {
        __block BOOL shouldReturn = NO;
        //check legitibility
        [self.displayingProjectURLs enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
            
            if ([[self titleLabelForObjectInArray:obj] isEqualToString:enteredText]) {
                [UserPrompter promptUserMessage:@"Already have a project with the same name" withViewController:self];
                shouldReturn = YES;
            }
            
        }];
        if (shouldReturn) {
            return;
        }
        
        
        completionBlock([self.projectsManager urlForAddingProjectWithName:enteredText]);
    }];
}





@end
