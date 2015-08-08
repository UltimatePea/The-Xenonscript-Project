//
//  Console.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ConsoleEntry;
#import "ConsoleDelegate.h"

@interface Console : NSObject

@property (strong, nonatomic) NSMutableArray<ConsoleEntry *> *allEntries;

+ (instancetype)sharedConsole;

- (void)clear;
@property (strong, nonatomic) id<ConsoleDelegate> delegate;

@end
