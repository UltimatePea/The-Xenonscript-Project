//
//  Stack.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/7/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;
@class XMethodCall;
@class StackTraceEntry;
@class StackTraceEntryContext;

@interface Stack : NSObject

#warning consider revising the design of singleton, may be harmful in case of multi-threading, consider using parent instance and child instance in case of multithreading which may be well supported in later versions
#warning DEPRECATED since under circumstances of multithreading, a single stack may not be well managed.
+ (instancetype)sharedStack;



- (void)willCallMethod:(NSString *)methodName onClass:(NSString *)className methodCall:(XMethodCall *)methodCall sendingInstance:(Instance *)sendingInstance;
- (void)didCallMethod:(NSString *)methodName onClass:(NSString *)className methodCall:(XMethodCall *)methodCall sendingInstance:(Instance *)sendingInstance;
- (void)clear;

@property (strong, readonly, nonatomic) NSMutableArray<StackTraceEntry *> *stackInstanceEntries;
- (NSMutableArray *)stackInstanceEntries;
- (StackTraceEntryContext *)contextForStackTraceEntry:(StackTraceEntry *)entry;


@end
