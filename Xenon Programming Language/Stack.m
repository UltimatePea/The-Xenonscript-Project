//
//  Stack.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/7/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "Stack.h"
#import "StackTraceEntry.h"
#import "Instance.h"
#import "XMethodCall.h"
#import "StackTraceEntryContext.h"
#import "Instance.h"
#import "XFunction.h"
#import "ProjectAnalyzer.h"
@interface Stack ()

@property (strong, readwrite, nonatomic) NSMutableArray<StackTraceEntry *> *stackInstanceEntries;

@end

@implementation Stack

- (NSMutableArray *)stackInstanceEntries
{
    if (!_stackInstanceEntries) {
        _stackInstanceEntries = [NSMutableArray array];
    }
    return _stackInstanceEntries;
}



+ (instancetype)sharedStack
{
    static Stack *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)willCallMethod:(NSString *)methodName onClass:(NSString *)className methodCall:(XMethodCall *)methodCall sendingInstance:(Instance *)sendingInstance
{
    StackTraceEntry *entry = [[StackTraceEntry alloc] init];
    entry.className = className;
    entry.callingMethodName = methodName;
    entry.creatingInstance = sendingInstance;
    entry.methodCall = methodCall;
    [self.stackInstanceEntries addObject:entry];
}

- (void)didCallMethod:(NSString *)methodName onClass:(NSString *)className methodCall:(XMethodCall *)methodCall sendingInstance:(Instance *)sendingInstance
{
    StackTraceEntry *entry = self.stackInstanceEntries.lastObject;
    [self.stackInstanceEntries removeLastObject];
    if ([entry.className isEqualToString:className]
        &&
        [entry.callingMethodName isEqualToString:methodName]
        &&
        [entry.creatingInstance isEqual:sendingInstance]
        &&
        [entry.methodCall isEqual:methodCall]
        ) {
        
    }else {
        NSLog(@"UNSUCCESSFUL DELETION on %@", entry);
    }
}

- (void)clear
{
    self.stackInstanceEntries = nil;
}

/*
 
 HERE DUE to the implementation of the stack
 (class property order)
 entry1   context1
 entry2   context2
 entry3   context3
 entry4   context4
 
 entry2 corresponds to context1
*/
- (StackTraceEntryContext *)contextForStackTraceEntry:(StackTraceEntry *)entry;
{
    StackTraceEntryContext *context = [[StackTraceEntryContext alloc] init];
    StackTraceEntry *resultEntry = [self.stackInstanceEntries.lastObject isEqual:entry]?nil:self.stackInstanceEntries[[self.stackInstanceEntries indexOfObject:entry] + 1];
    
        context.inFunction = [resultEntry.creatingInstance.analyzer functionWhichMethodCallIsIn:resultEntry.methodCall];
        context.showingMethodCall = resultEntry.methodCall;
        context.instance = resultEntry.creatingInstance;
    return context;
    
}



@end
