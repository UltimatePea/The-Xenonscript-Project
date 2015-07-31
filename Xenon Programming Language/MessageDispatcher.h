//
//  MessageDispatcher.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/21/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDispatcher : NSObject
#define NOTIFICATION_CENTER_INFORMATION_FLAG @"NOTIFICATION_CENTER_INFORMATION_FLAG"
#define NOTIFICATION_CENTER_WARNING_FLAG @"NOTIFICATION_CENTER_WARNING_FLAG"
#define NOTIFICATION_CENTER_ERROR_FLAG @"NOTIFICATION_CENTER_ERROR_FLAG"
#define USER_INFO_KEY_MSG @"msg"
- (void)dispatchInformationMessage:(NSString *)msg sender:(id)sender;
- (void)dispatchWarningMessage:(NSString *)msg sender:(id)sender;
- (void)dispatchErrorMessage:(NSString *)msg sender:(id)sender;
+ (instancetype)sharedMessgeDispatcher;
@end
