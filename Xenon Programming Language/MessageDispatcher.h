//
//  MessageDispatcher.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/21/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageDispatcher : NSObject

- (void)dispatchInformationMessage:(NSString *)msg sender:(id)sender;
- (void)dispatchWarningMessage:(NSString *)msg sender:(id)sender;
- (void)dispatchErrorMessage:(NSString *)msg sender:(id)sender;

@end
