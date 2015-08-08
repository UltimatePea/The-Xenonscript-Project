//
//  Console.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "Console.h"
#import "MessageDispatcherNotificationCommunicationStrings.h"
#import "MessageType.h"
#import "ConsoleEntry.h" 

@interface Console ()

@property (strong, nonatomic) NSNotificationCenter *notificationCenter;


@end

@implementation Console

- (NSMutableArray<ConsoleEntry *> *)allEntries
{
    if (!_allEntries) {
        _allEntries = [NSMutableArray array];
    }
    return _allEntries;
}

- (NSNotificationCenter *)notificationCenter
{
    if (!_notificationCenter) {
        _notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return _notificationCenter;
}

+ (instancetype)sharedConsole;
{
    static Console *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        __weak Console *weakSelf = self;
        [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_INFORMATION_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
            [weakSelf addMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeInfo];
        }];
        [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_WARNING_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
            [weakSelf addMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeWarning];
        }];
        [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_ERROR_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
            [weakSelf addMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeErr];
        }];
        
        
    }
    return self;
}


- (void)addMessage:(NSString *)msg withType:(MessageType)type
{
    ConsoleEntry *entry = [ConsoleEntry entryWithMessage:msg messageType:type];
    [self.allEntries addObject:entry];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.delegate console:self didAppendEntry:entry];
    });
    
}

- (void)clear
{
    self.allEntries = nil;
}



@end
