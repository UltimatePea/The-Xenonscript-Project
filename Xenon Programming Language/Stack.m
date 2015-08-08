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


@end
