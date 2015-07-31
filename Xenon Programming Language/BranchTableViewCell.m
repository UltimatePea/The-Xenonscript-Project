//
//  BranchTableViewCell.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "BranchTableViewCell.h"
#import "UserPrompter.h"
#import "UAGithubEngine.h"
#import "NSArray+PerformSelectorAndAssign.h"
@implementation BranchTableViewCell

- (void)pickBranch
{
    [self.engine branchesForRepository:self.repoName user:self.engine.username  success:^(id obj) {
        NSArray *branches = obj;
        NSArray *names = [branches arrayByReplacingObjectsUsingBlock:^id(id objectInTheArray) {
            return objectInTheArray[@"name"];
        }];
        [UserPrompter actionSheetWithTitle:@"Please Select A Branch To Commit Your Project"
                                   message:nil
                             normalActions:names
                             cancelActions:@[@"Cancel"]
                        destructiveActions:nil
                                 sendingVC:self.viewController
                           completionBlock:^(NSUInteger selectedStringIndex,
                                             int actionType) {
            switch (actionType) {
                case ACTION_TYPE_CANCEL:
                    
                    break;
                case ACTION_TYPE_DEFAULT:
                    if (selectedStringIndex<names.count) {
                        self.branchName = names[selectedStringIndex];
                    } else {
                        [self createNewBranch];
                    }
                    break;
                default:
                    break;
            }
        }];
    } failure:^(NSError *err) {
        [UserPrompter promptUserMessage:@"Unable to read branches for given repository." withViewController:self.viewController];
    }];
    
}

- (void)createNewBranch
{
    
}

- (void)setRepoName:(NSString *)repoName
{
    _repoName = repoName;
    self.branchName = @"master";
    
}

- (void)setBranchName:(NSString *)branchName
{
    _branchName = branchName;
    self.detailTextLabel.text = branchName;
}

- (void)setupWithEngine:(UAGithubEngine *)engine repoName:(NSString *)repoName  viewController:(UIViewController *)vc;
{
    self.engine = engine;
    self.repoName = repoName;
    self.viewController = vc;
}

@end
