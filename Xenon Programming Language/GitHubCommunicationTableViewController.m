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
#import "RepositorySelector.h"
#import "BranchTableViewCell.h"
@interface GitHubCommunicationTableViewController ()
@property (weak, nonatomic) IBOutlet BranchTableViewCell *branchTableViewCell;
@property (weak, nonatomic) IBOutlet ProjectSelectorTableViewCell *projectTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *repositoryTableViewCell;
//@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation GitHubCommunicationTableViewController

- (void)setRepositoryName:(NSString *)repositoryName
{
    _repositoryName= repositoryName;
    self.repositoryTableViewCell.detailTextLabel.text = repositoryName;
    self.branchTableViewCell.repoName = repositoryName;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.repositoryTableViewCell.detailTextLabel.text = self.repositoryName;
    [self.branchTableViewCell setupWithEngine:self.engine repoName:self.repositoryName viewController:self];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SAVE_PROJ" object:self];
    NSURL *expectedProjURL = [[ProjectsManager sharedProjectsManager] mostRecentModifiedProjectURL];
    if (expectedProjURL) {
        if (self.projectTableViewCell.selectedProjectURL == nil) {
            self.projectTableViewCell.selectedProjectURL = expectedProjURL;
            self.projectTableViewCell.detailTextLabel.text = expectedProjURL.pathComponents.lastObject;

        }
    } else {
        [UserPrompter promptUserMessage:@"You do not have a project." withViewController:self];
    }
}
- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.projectTableViewCell]){
        [self.projectTableViewCell pickProject:self completion:^{
           ;
            
        }];
    } else if ([cell isEqual:self.repositoryTableViewCell]){
        [RepositorySelector startRepositorySelectionWithEngine:self.engine viewController:self completionBlock:^(NSString *selectedRepositoryName) {
            self.repositoryName = selectedRepositoryName;
        }];
    } else if ([cell isEqual:self.branchTableViewCell]){
        [self.branchTableViewCell pickBranch];
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
//                               @"branch":self.branchTableViewCell.branchName
                               }];
        if ([QuickStorage isObjectStoredWithKey:[self quickStorageKeyForCurrentProject]]) {
            [info setObject:[QuickStorage objectForKey:[self quickStorageKeyForCurrentProject]] forKey:@"sha"];
        }
        
        
        if (error) {
            [UserPrompter promptUserMessage:@"Unable to read the selected project." withViewController:self];
            return ;
        }
        [UserPrompter presentBlocking:self];
        dispatch_async(dispatch_queue_create("GHCommunication", NULL), ^{
            [self.engine createFileWithInfo:info withPath:self.projectTableViewCell.selectedProjectURL.pathComponents.lastObject forUser:self.engine.username inRepo:self.repositoryName success:^(id obj) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"SUCCESS");
                    [UserPrompter dismissBlocking:self];
                    [UserPrompter promptUserMessage:@"File Commited Successfully." withViewController:self];
                    [QuickStorage storeObject:obj[0][@"content"][@"sha"] forKey:[self quickStorageKeyForCurrentProject]];
                });
                
            } failure:^(NSError *err) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UserPrompter dismissBlocking:self];
                    [UserPrompter promptUserMessage:@"An error occured during committing." withViewController:self];
                    NSLog(@"FAILED");
                });
                
            }];
        });
        
        
    }];
}

- (IBAction)getFileFromGitHub:(id)sender
{
    [UserPrompter destructiveAlertWithTitle:@"Warning" message:@"Your local files will be replaced by the files on GitHub Server. Uncommited changes will be lost permanently. This action cannot be undone." withViewController:self confirmed:^{
        NSDictionary *sendingParam = @{
//                                       @"branch":self.branchTableViewCell.branchName
                                       };
        [UserPrompter presentBlocking:self];
        dispatch_async(dispatch_queue_create("GHCommunication-download", NULL), ^{
            [self.engine fileWithInfo:sendingParam withPath:self.projectTableViewCell.selectedProjectURL.pathComponents.lastObject forUser:self.engine.username inRepo:self.repositoryName success:^(id obj) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UserPrompter dismissBlocking:self];
                    
                    NSString *base64EncodedStr = obj[0][@"content"];
                    NSData *nsdataFromBase64String =
                    //            NSError *error;
                    
                    [[NSData alloc]
                     initWithBase64EncodedString:base64EncodedStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
                    [nsdataFromBase64String writeToURL:self.projectTableViewCell.selectedProjectURL atomically:YES];
                    //            NSString *base64Decoded = [[NSString alloc]
                    //                                       initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
                    //            NSError *error;
                    //            [base64Decoded writeToURL:self.projectTableViewCell.selectedProjectURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
                    //            if (error) {
                    //                [UserPrompter promptUserMessage:@"Unable to save" withViewController:self];
                    //                return;
                    //            }
                    
                    [QuickStorage storeObject:obj[0][@"sha"] forKey:[self quickStorageKeyForCurrentProject]];
                    [UserPrompter promptUserMessage:@"File downloaded successfully" withViewController:self];
                    NSLog(@"SUCCESS");

                });
                
            } failure:^(NSError *err) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UserPrompter dismissBlocking:self];
                    [UserPrompter promptUserMessage:@"An error occured during file downloading." withViewController:self];
                    NSLog(@"FAILED");
                });
                
            }];
        });
        
    }];
}


@end
