//
//  ConsoleEntry.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageType.h"

@interface ConsoleEntry : NSObject

+ (instancetype)entryWithMessage:(NSString *)message messageType:(MessageType)msgType;
- (instancetype)initWithMessage:(NSString *)message messageType:(MessageType)msgType;
;

@property (nonatomic) MessageType msgType;
@property (strong, nonatomic) NSString *message;

@end
