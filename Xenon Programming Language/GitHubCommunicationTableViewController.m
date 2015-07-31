//
//  GitHubCommunicationTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "GitHubCommunicationTableViewController.h"
#import "ProjectSelectorTableViewCell.h"
#import "ProjectsManager.h"
#import "UserPrompter.h"
#import "UAGithubEngine.h"
#import "QuickStorage.h"
@interface GitHubCommunicationTableViewController ()
@property (weak, nonatomic) IBOutlet ProjectSelectorTableViewCell *projectTableViewCell;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation GitHubCommunicationTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_PROJ" object:self];
    NSURL *expectedProjURL = [[ProjectsManager sharedProjectsManager] mostRecentModifiedProjectURL];
    if (expectedProjURL) {
        self.projectTableViewCell.selectedProjectURL = expectedProjURL;
        self.projectTableViewCell.detailTextLabel.text = expectedProjURL.pathComponents.lastObject;
    } else {
        [UserPrompter promptUserMessage:@"You do not have a project." withViewController:self];
    }
}
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.projectTableViewCell]){
        [self.projectTableViewCell pickProject:self];
    }
}

- (NSString *)quickStorageKeyForCurrentProject
{
    return [NSString stringWithFormat:@"%@-SHA", self.projectTableViewCell.selectedProjectURL.pathComponents.lastObject];
}

- (IBAction)commitToGitHub:(id)sender
{
    [UserPrompter getTextMessageFromUser:@"Please specify the message for this commit." withViewController:self completionBlock:^(NSString *enteredText) {
        NSError *error;
        NSMutableDictionary *info = [NSMutableDictionary dictionaryWithDictionary: @{@"message":enteredText,
//                               @"commiter":@{
//                                   @"name":self.engine.username,
//                                   @"emial":self.emailTextField.text
//                               },
                               @"content":[[[NSString stringWithContentsOfURL:self.projectTableViewCell.selectedProjectURL encoding:NSUTF8StringEncoding error:&error] dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0],
                               
                               }];
        if ([QuickStorage isObjectStoredWithKey:[self quickStorageKeyForCurrentProject]]) {
            [info setObject:[QuickStorage objectForKey:[self quickStorageKeyForCurrentProject]] forKey:@"sha"];
        }
        
        
        if (error) {
            [UserPrompter promptUserMessage:@"Unable to read the selected project." withViewController:self];
            return ;
        }
        [self.engine createFileWithInfo:info withPath:self.projectTableViewCell.selectedProjectURL.pathComponents.lastObject forUser:self.engine.username inRepo:self.repositoryName success:^(id obj) {
            NSLog(@"SUCCESS");
            [QuickStorage storeObject:obj[0][@"content"][@"sha"] forKey:[self quickStorageKeyForCurrentProject]];
        } failure:^(NSError *err) {
            NSLog(@"FAILED");
        }];
        
    }];
}

- (IBAction)getFileFromGitHub:(id)sender
{
    
}


@end
