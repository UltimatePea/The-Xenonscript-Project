//
//  UserPrompter.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/31/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface UserPrompter : NSObject

+ (void)promptUserMessage:(NSString *)message withViewController:(UIViewController *)sender;

+ (void)getTextMessageFromUser:(NSString *)prompt withViewController:(UIViewController *)sender completionBlock:(void (^)(NSString *enteredText))completionBlock;

+ (void)destructiveAlertWithTitle:(NSString *)title message:(NSString *)msg withViewController:(UIViewController *)sender confirmed:(void (^)())completionBlock;

#define ACTION_TYPE_DEFAULT 1
#define ACTION_TYPE_CANCEL 2
#define ACTION_TYPE_DESTRUCTIVE 3
+ (void)actionSheetWithTitle:(NSString *)title
                     message:(NSString *)msg
               normalActions:(NSArray *)actions
               cancelActions:(NSArray *)cancels
          destructiveActions:(NSArray *)destructives
                   sendingVC:(UIViewController *)vc
             completionBlock:(void (^)(NSUInteger selectedStringIndex, int actionType))completionBlock;
+ (UIAlertController *)defaultAlertControllerWithTitle:(NSString *)title message:(NSString *)msg style:(UIAlertControllerStyle)style completionBlock:(void (^)())completionBlock;

+ (void)presentBlocking:(UIViewController *)vc;
+ (void)dismissBlocking:(UIViewController *)vc;
+ (void)dismissBlocking:(UIViewController *)vc completion:(void (^)())block;
@end
