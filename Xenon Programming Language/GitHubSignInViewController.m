//
//  GitHubSignInViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "GitHubSignInViewController.h"
//#import "../octokit.objc-master/OctoKit/OctoKit.h"
//#import "../UAGithubEngine-master/UAGithubEngine/UAGithubEngine.h"
#import "UAGithubEngine.h"
#import "GitHubCommunicationTableViewController.h"
#import "NSArray+PerformSelectorAndAssign.h"
#import "UserPrompter.h"
#import "QuickStorage.h"
@import Security;

@interface GitHubSignInViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) UAGithubEngine *engine;
@property (weak, nonatomic) IBOutlet UISwitch *saveCredentialSwitch;
@property (strong, nonatomic) UIAlertController *theNewRepoAlert;
@property (strong, nonatomic) NSURLProtectionSpace *loginProtectionSpace;
@property (strong, nonatomic) NSString *server, *repoName;
@end

@implementation GitHubSignInViewController

- (NSString *)server
{
    return @"www.github.com";
}
//
//- (NSURLProtectionSpace *)loginProtectionSpace
//{
//    if (_loginProtectionSpace) {
//        NSURL *url = [NSURL URLWithString:@"https://www.github.com"];
//        _loginProtectionSpace =
//          [[NSURLProtectionSpace alloc] initWithHost:url.host
//                                                                          port:[url.port integerValue]
//                                                                      protocol:url.scheme
//                                                                         realm:nil
//                                                          authenticationMethod:NSURLAuthenticationMethodHTTPBasic];
//    }
//    return _loginProtectionSpace;
//}
#define KEY_CREDENTIAL_SAVED @"KEY_CREDENTIAL_SAVED"
#define KEY_GITHUB_USER_NAME @"KEY_GITHUB_USER_NAME"
#define KEY_GITHUB_PASSWORD @"KEY_GITHUB_PASSWORD"
#define KEY_GITHUB_REPO_NAME @"KEY_GITHUB_REPO_NAME"
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
//    [self getCredentialsForServer:self.server];
    if ([QuickStorage isObjectStoredWithKey:KEY_CREDENTIAL_SAVED]) {
        if ([[QuickStorage objectForKey:KEY_CREDENTIAL_SAVED] boolValue]==YES) {
            self.usernameTextField.text = [QuickStorage objectForKey:KEY_GITHUB_USER_NAME];
            self.passwordTextField.text = [QuickStorage objectForKey:KEY_GITHUB_PASSWORD];
//            NSURLCredential *credential;
//            NSDictionary *credentials;
//            
//            credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:self.loginProtectionSpace];
//            credential = [credentials.objectEnumerator nextObject];
//            self.usernameTextField.text = credential.user   ;
//            self.passwordTextField.text = credential.password;
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (animated == NO) {//tab switch
        if ([QuickStorage isObjectStoredWithKey:KEY_GITHUB_REPO_NAME]) {
            if ([QuickStorage isObjectStoredWithKey:KEY_CREDENTIAL_SAVED]) {
                if ([[QuickStorage objectForKey:KEY_CREDENTIAL_SAVED] boolValue]==YES) {
                    self.engine = [[UAGithubEngine alloc] initWithUsername:self.usernameTextField.text password:self.passwordTextField.text withReachability:YES];
                    [self confirmedRepositoryWithName:[QuickStorage objectForKey:KEY_GITHUB_REPO_NAME]];
                }
            }
        }
    }
    
}


- (BOOL)textFieldShouldReturn:(nonnull UITextField *)textField
{
    if ([textField isEqual:self.usernameTextField]) {
        [self.passwordTextField becomeFirstResponder];
    } else if ([textField isEqual:self.passwordTextField]){
        [self.passwordTextField resignFirstResponder];
        [self signIn];
    }
    return YES;
}

- (IBAction)signIn
{
    UAGithubEngine *engine = [[UAGithubEngine alloc] initWithUsername:self.usernameTextField.text password:self.passwordTextField.text withReachability:YES];
    self.engine = engine;
    [self.engine repositoriesForUser:self.engine.username includeWatched:YES success:^(id obj) {
        //suc
        NSLog(@"SUCCESS");
        NSArray *repos = obj;
        NSArray *names = [repos arrayByReplacingObjectsUsingBlock:^id(id objectInTheArray) {
            NSDictionary *dic = objectInTheArray;
            return dic[@"name"];
        }];
        [UserPrompter actionSheetWithTitle:@"Please Select A Repository To Store Your Project" message:nil normalActions:[names arrayByAddingObject:@"Create a New Git Repository"] cancelActions:@[@"Cancel"] destructiveActions:nil sendingVC:self completionBlock:^(NSUInteger selectedStringIndex, int actionType) {
            switch (actionType) {
                case ACTION_TYPE_CANCEL:
                    
                    break;
                case ACTION_TYPE_DEFAULT:
                    if (selectedStringIndex<names.count) {
                        [self confirmedRepositoryWithName:names[selectedStringIndex]];
                    } else {
                        [self createNewRepository];
                    }
                    break;
                default:
                    break;
            }
        }];
    } failure:^(NSError *error) {
        //fai
        NSLog(@"FAILED");
        [UserPrompter promptUserMessage:@"Failed to load repositories. Please check your username and passwords." withViewController:self];
    }];
    
    
}

- (void)confirmedRepositoryWithName:(NSString *)name
{
    if (self.saveCredentialSwitch.on) {
//        NSURLCredential *credential;
//        
//        credential = [NSURLCredential credentialWithUser:self.engine.username password:self.engine.password persistence:NSURLCredentialPersistencePermanent];
//        [[NSURLCredentialStorage sharedCredentialStorage] setCredential:credential forProtectionSpace:self.loginProtectionSpace];
        [QuickStorage storeObject:[NSNumber numberWithBool:YES] forKey:KEY_CREDENTIAL_SAVED];
        [QuickStorage storeObject:self.engine.username forKey:KEY_GITHUB_USER_NAME];
        [QuickStorage storeObject:self.engine.password forKey:KEY_GITHUB_PASSWORD];
        [QuickStorage storeObject:name forKey:KEY_GITHUB_REPO_NAME];
        self.repoName = name;
//        [self saveUsername:self.engine.username withPassword:self.engine.password forServer:self.server];
    }
    [self performSegueWithIdentifier:@"showGitHubCommunicationTableViewController" sender:self];
}
- (IBAction)deleteCredential:(id)sender {
//    NSURLCredential *credential;
//    NSDictionary *credentials;
//    
//    credentials = [[NSURLCredentialStorage sharedCredentialStorage] credentialsForProtectionSpace:self.loginProtectionSpace];
//    credential = [credentials.objectEnumerator nextObject];
//    [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:credential forProtectionSpace:self.loginProtectionSpace];
    [QuickStorage deleteObjectForKey:KEY_GITHUB_USER_NAME];
    [QuickStorage deleteObjectForKey:KEY_GITHUB_PASSWORD];
    [QuickStorage deleteObjectForKey:KEY_GITHUB_REPO_NAME];
    [QuickStorage storeObject:[NSNumber numberWithBool:NO] forKey:KEY_CREDENTIAL_SAVED];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
//    [UserPrompter promptUserMessage:@"Your credentials have been deleted." withViewController:self];
//    [self removeAllCredentialsForServer:self.server];
    
}

- (void)createNewRepository
{
    UIAlertController *ac = [UserPrompter defaultAlertControllerWithTitle:@"Create New Repository" message:@"Please provide some important information. You can also edit the information later on GitHub website." style:UIAlertControllerStyleAlert completionBlock:^{
        NSDictionary *info = @{ @"name":self.theNewRepoAlert.textFields[0].text ,
                                @"description":self.theNewRepoAlert.textFields[1].text,
                                @"homepage":self.theNewRepoAlert.textFields[2].text
                                };
        
        [self.engine createRepositoryWithInfo:info success:^(id response) {
            [self confirmedRepositoryWithName:response[0][@"name"]];
        } failure:^(NSError *err) {
            [ac dismissViewControllerAnimated:YES completion:nil];
            [UserPrompter promptUserMessage:@"Failed to create repository" withViewController:self];
        }];
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
    [self presentViewController:ac animated:YES completion:nil];
        
}

#pragma mark - Navigation
- (void)prepareForSegue:(nonnull UIStoryboardSegue *)segue sender:(nullable id)sender
{
    if ([segue.identifier isEqualToString:@"showGitHubCommunicationTableViewController"]) {
        if ([segue.destinationViewController isKindOfClass:[GitHubCommunicationTableViewController class]]) {
            GitHubCommunicationTableViewController *ghctvc = segue.destinationViewController;
            ghctvc.engine = self.engine;
            ghctvc.repositoryName = self.repoName;
        }
    }
    
    
    
    
}


//
//-(void) saveUsername:(NSString*)user withPassword:(NSString*)pass forServer:(NSString*)server {
//    
//    // Create dictionary of search parameters
//    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, server, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, nil];
//    
//    // Remove any old values from the keychain
//    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
//    
//    // Create dictionary of parameters to add
//    NSData* passwordData = [pass dataUsingEncoding:NSUTF8StringEncoding];
//    dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword), kSecClass, server, kSecAttrServer, passwordData, kSecValueData, user, kSecAttrAccount, nil];
//    
//    // Try to save to keychain
//    err = SecItemAdd((__bridge CFDictionaryRef) dict, NULL);
//    
//}
//
//
//-(void) removeAllCredentialsForServer:(NSString*)server {
//    
//    // Create dictionary of search parameters
//    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, server, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, kCFBooleanTrue, kSecReturnData, nil];
//    
//    // Remove any old values from the keychain
//    OSStatus err = SecItemDelete((__bridge CFDictionaryRef) dict);
//    
//}
//
//
//-(void) getCredentialsForServer:(NSString*)server {
//    
//    // Create dictionary of search parameters
//    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)(kSecClassInternetPassword),  kSecClass, server, kSecAttrServer, kCFBooleanTrue, kSecReturnAttributes, kCFBooleanTrue, kSecReturnData, nil];
//    
//    // Look up server in the keychain
//    NSDictionary* found = nil;
//    CFDictionaryRef foundCF;
//    OSStatus err = SecItemCopyMatching((__bridge CFDictionaryRef) dict, (CFTypeRef*)&foundCF);
//    
//    // Check if found
//    if(CFDictionaryGetCount(foundCF)<2){
//        return;
//    }
//    
//    found = (__bridge_transfer NSDictionary*)(foundCF);
//    if (!found)
//        return;
//    
//    // Found
//    NSString* user = (NSString*) [found objectForKey:(__bridge id)(kSecAttrAccount)];
//    NSString* pass = [[NSString alloc] initWithData:[found objectForKey:(__bridge id)(kSecValueData)] encoding:NSUTF8StringEncoding];
//    self.usernameTextField.text = user;
//    self.passwordTextField.text = pass;
//}

@end
