//
//  MessageDispatcher.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/21/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "MessageDispatcher.h"

@interface MessageDispatcher ()

@property (strong, nonatomic) NSNotificationCenter *notificationCenter;

@end

@implementation MessageDispatcher

- (NSNotificationCenter *)notificationCenter
{
    if (!_notificationCenter) {
        _notificationCenter  = [NSNotificationCenter defaultCenter];
    }
    return _notificationCenter;
}

+ (instancetype)sharedMessgeDispatcher
{
    static MessageDispatcher *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MessageDispatcher alloc] init];
    });
    return sharedInstance;
}


- (void)dispatchInformationMessage:(NSString *)msg sender:(id)sender
{
    [self.notificationCenter postNotificationName:NOTIFICATION_CENTER_INFORMATION_FLAG object:self userInfo:@{USER_INFO_KEY_MSG:msg}];
}
- (void)dispatchWarningMessage:(NSString *)msg sender:(id)sender
{
    [self.notificationCenter postNotificationName:NOTIFICATION_CENTER_WARNING_FLAG object:self userInfo:@{USER_INFO_KEY_MSG:msg}];
}
- (void)dispatchErrorMessage:(NSString *)msg sender:(id)sender
{
    [self.notificationCenter postNotificationName:NOTIFICATION_CENTER_ERROR_FLAG object:self userInfo:@{USER_INFO_KEY_MSG:msg}];
}

@end
