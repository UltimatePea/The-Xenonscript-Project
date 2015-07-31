//
//  Field.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "Field.h"
#import "Instance.h"
#import "InstanceFieldEntry.h"

@interface Field ()


//@property (strong, nonatomic) NSMutableArray *subFields;
@property (strong, nonatomic) NSMutableArray *instanceEntries;

@end


@implementation Field

- (NSMutableArray *)instanceEntries
{
    if (!_instanceEntries) {
        _instanceEntries = [NSMutableArray array];
    }
    return _instanceEntries;
}

- (Instance *)thisResolver
{
    if (!_thisResolver) {
        _thisResolver = self.inInstance;
    }
    return _thisResolver;
}

- (void)addInstance:(Instance *)instance
{
    [self.instanceEntries addObject:[[InstanceFieldEntry alloc] initWithInstance:instance]];
}

- (NSArray *)instancesForName:(NSString *)name
{
    if ([name isEqualToString:@"this"]) {
        return @[self.thisResolver];
    }
    NSMutableArray *result = [NSMutableArray array];
    [self.instanceEntries enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        InstanceFieldEntry *inst = obj;
        if ([inst.name isEqualToString:name]) {
            [result addObject:inst.containingInstance];
        }
    }];
    [result addObjectsFromArray:[self.inInstance.baseInstance.field instancesForName:name]];
    return result;
}

- (void)assignInstance:(Instance *)instance toName:(NSString *)name;
{
    if ([name isEqualToString:@"this"]) {
        return;
    }
    [self.instanceEntries enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        InstanceFieldEntry *inst = obj;
        if ([inst.name isEqualToString:name]) {
            inst.containingInstance = instance;
        }
    }];
}

- (void)addInstanceEntry:(InstanceFieldEntry *)entry
{
    [self.instanceEntries addObject:entry];
}


- (void)addInstance:(Instance *)instance forEntryName:(NSString *)entryName
{
    [self.instanceEntries addObject:[[InstanceFieldEntry alloc] initWithInstance:instance name:entryName]];
}


@end
