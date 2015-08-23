//
//  QuickStorage.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "QuickStorage.h"

@interface QuickStorage ()

@property (strong, nonatomic) NSMutableDictionary *storageDictionary;
@property (strong, readonly, nonatomic) NSURL *saveURL;

@end


@implementation QuickStorage


@synthesize saveURL = _saveURL;

- (NSURL *)saveURL
{
    if (!_saveURL) {
        _saveURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject URLByAppendingPathComponent:@"QuickStorage.qstore"];
    }
    return _saveURL;
}



- (NSMutableDictionary *)storageDictionary
{
    if (!_storageDictionary) {
        if([[NSFileManager defaultManager] fileExistsAtPath:self.saveURL.path]){
            _storageDictionary = [[NSMutableDictionary alloc] initWithContentsOfURL:self.saveURL];
        } else {
            _storageDictionary = [NSMutableDictionary dictionary];
            [_storageDictionary writeToURL:self.saveURL atomically:YES];
        }
        
    }
    return _storageDictionary;
}

+ (instancetype)sharedInstance
{
    static QuickStorage *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QuickStorage alloc] init];
    });
    return instance;
}

- (void)saveDictionary
{
    [self.storageDictionary writeToURL:self.saveURL atomically:YES];
}

- (void)storeObject:(id)object forKey:(NSString *)key;
{
    [self.storageDictionary setObject:object forKey:key];
    [self saveDictionary];
}

- (id)objectForKey:(NSString *)key;
{
    return self.storageDictionary[key];
}

- (BOOL)isObjectStoredWithKey:(NSString *)key
{
    return [self.storageDictionary.allKeys containsObject:key];
}
- (void)deleteObjectForKey:(NSString *)key;
{
    [self.storageDictionary removeObjectForKey:key];
    [self saveDictionary];
}

+ (void)storeObject:(id)object forKey:(NSString *)key;
{
    return [[QuickStorage sharedInstance] storeObject:object forKey:key];
}
+ (id)objectForKey:(NSString *)key;
{
    return [[QuickStorage sharedInstance] objectForKey:key];
}
+ (BOOL)isObjectStoredWithKey:(NSString *)key;
{
    return [[QuickStorage sharedInstance] isObjectStoredWithKey:key];
}
+ (void)deleteObjectForKey:(NSString *)key;
{
    return [[QuickStorage sharedInstance] deleteObjectForKey:key];
}




@end
