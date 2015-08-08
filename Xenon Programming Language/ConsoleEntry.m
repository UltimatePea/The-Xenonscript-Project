//
//  ConsoleEntry.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ConsoleEntry.h"

@implementation ConsoleEntry

+ (instancetype)entryWithMessage:(NSString *)message messageType:(MessageType)msgType
{
    return [[ConsoleEntry alloc] initWithMessage:message messageType:msgType];
}

- (instancetype)initWithMessage:(NSString *)message messageType:(MessageType)msgType
{
    if (self = [super init]) {
        self.msgType = msgType;
        self.message = message;
    }
    return self;
}

@end
