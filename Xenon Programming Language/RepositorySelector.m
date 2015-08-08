//
//  RepositorySelector.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "RepositorySelector.h"
#import "UAGithubEngine.h"
#import "NSArray+PerformSelectorAndAssign.h"
#import "UserPrompter.h"



@interface RepositorySelector ()

@property (strong, nonatomic) UAGithubEngine *engine;
@property (strong, nonatomic) UIAlertController *theNewRepoAlert;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) void (^block)(NSString *selectedRepo);
@end

@implementation RepositorySelector
+ (void)startRepositorySelectionWithEngine:(UAGithubEngine *)engine
                            viewController:(UIViewController *)vc
                           completionBlock:(void (^)(NSString *selectedRepositoryName))block;
{
    [UserPrompter presentBlocking:vc];
    dispatch_async(dispatch_queue_create("RepositorySelector", NULL), ^{
        [engine repositoriesForUser:engine.username includeWatched:YES success:^(id obj) {
            //suc
            dispatch_async(dispatch_get_main_queue(), ^{
                [UserPrompter dismissBlocking:vc completion:^{
                    NSLog(@"SUCCESS");
                    NSArray *repos = obj;
                    NSArray *names = [repos arrayByReplacingObjectsUsingBlock:^id(id objectInTheArray) {
                        NSDictionary *dic = objectInTheArray;
                        return dic[@"name"];
                    }];
                    [UserPrompter actionSheetWithTitle:@"Please Select A Repository To Store Your Project" message:nil normalActions:[names arrayByAddingObject:@"Create a New Git Repository"] cancelActions:@[@"Cancel"] destructiveActions:nil sendingVC:vc completionBlock:^(NSUInteger selectedStringIndex, int actionType) {
                        switch (actionType) {
                            case ACTION_TYPE_CANCEL:
                                
                                break;
                            case ACTION_TYPE_DEFAULT:
                                if (selectedStringIndex<names.count) {
                                    block(names[selectedStringIndex]);
                                } else {
                                    [[[RepositorySelector alloc] initWithEngine:engine viewController:vc block:block] createNewRepository];
                                }
                                break;
                            default:
                                break;
                        }
                    }];

                }];
#warning behaviour may change to up dismissBlocking
//                [vc dismissViewControllerAnimated:YES completion:nil];
            });
            
        } failure:^(NSError *error) {
            //fai
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"FAILED");
                [UserPrompter dismissBlocking:vc];
                [UserPrompter promptUserMessage:@"Failed to load repositories. Please check your username and passwords." withViewController:vc];
            });
            
        }];
    });
    
}

- (instancetype)initWithEngine:(UAGithubEngine *)engine viewController:(UIViewController *)vc block:(void (^)(NSString *selectedRepositoryName))block;
{
    if (self = [super init]) {
        self.engine = engine;
        self.viewController = vc;
        self.block = block;
    }
    return self;
}

- (void)createNewRepository
{
    UIAlertController *ac = [UserPrompter defaultAlertControllerWithTitle:@"Create New Repository" message:@"Please provide some important information. You can also edit the information later on GitHub website." style:UIAlertControllerStyleAlert completionBlock:^{
        NSDictionary *info = @{ @"name":self.theNewRepoAlert.textFields[0].text ,
                                @"description":self.theNewRepoAlert.textFields[1].text,
                                @"homepage":self.theNewRepoAlert.textFields[2].text
                                };
        [UserPrompter presentBlocking:self.viewController];
        dispatch_async(dispatch_queue_create("Repo Select", NULL), ^{
            [self.engine createRepositoryWithInfo:info success:^(id response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UserPrompter dismissBlocking:self.viewController];
                    self.block (response[0][@"name"]);
                    
                });
                
            } failure:^(NSError *err) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ac dismissViewControllerAnimated:YES completion:nil];
                    [UserPrompter dismissBlocking:self.viewController];
#warning issue with recursive presentation
                    [UserPrompter promptUserMessage:@"Failed to create repository" withViewController:self.viewController];
                });
                
            }];
        });
        
    }];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * __nonnull textField) {
        textField.placeholder = @"Name";
    }];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * __nonnull textField) {
        textField.placeholder = @"Description";
    }];
    [ac addTextFieldWithConfigurationHandler:^(UITextField * __nonnull textField) {
        textField.placeholder = @"Homepage URL";
    }];
    self.theNewRepoAlert = ac;
    [self.viewController presentViewController:ac animated:YES completion:nil];
    
}


@end
