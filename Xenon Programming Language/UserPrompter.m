//
//  UserPrompter.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/31/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "UserPrompter.h"

@implementation UserPrompter

+ (void)promptUserMessage:(NSString *)message withViewController:(UIViewController *)sender
{
    [[[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

+ (void)getTextMessageFromUser:(NSString *)prompt withViewController:(UIViewController *)sender completionBlock:(void (^)(NSString *))completionBlock
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:prompt message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *textf = [[ac textFields] objectAtIndex:0];
        completionBlock(textf.text);
        [ac dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [ac dismissViewControllerAnimated:YES completion:nil];
    }];
    [ac addAction:ok];
    [ac addAction:cancel];
    [ac addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
    }];
    [sender presentViewController:ac animated:YES completion:nil];
}

+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)msg
               normalActions:(NSArray *)actions
               cancelActions:(NSArray *)cancels
          destructiveActions:(NSArray *)destructives
                   sendingVC:(UIViewController *)vc
             completionBlock:(void (^)(NSUInteger selectedStringIndex, int actionType))completionBlock
{
    UIAlertController *ac  = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    [actions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            completionBlock(idx, ACTION_TYPE_DEFAULT);
            [ac dismissViewControllerAnimated:YES completion:^{
               
            }];
            
        }];
        [ac addAction:defaultAction];
    }];
    [cancels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            completionBlock(idx, ACTION_TYPE_CANCEL);
            [ac dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [ac addAction:cancelAction];
    }];
    [destructives enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIAlertAction *destructiveAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            completionBlock(idx, ACTION_TYPE_DESTRUCTIVE);
            [ac dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }];
        [ac addAction:destructiveAction];
    }];
    [vc presentViewController:ac animated:YES completion:nil];
}

+ (UIAlertController *)defaultAlertControllerWithTitle:(NSString *)title message:(NSString *)msg style:(UIAlertControllerStyle)style completionBlock:(void (^)())completionBlock;
{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
        [ac dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
        completionBlock();
        [ac dismissViewControllerAnimated:YES completion:nil];
    }];
    [ac addAction:cancel];
    [ac addAction:ok];
    return ac;
}

+ (void)destructiveAlertWithTitle:(NSString *)title message:(NSString *)msg withViewController:(UIViewController *)sender confirmed:(void (^)())completionBlock;
{
    
}

@end
