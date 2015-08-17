//
//  Field.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;
@class XFunction;
@class InstanceFieldEntry;

@interface Field : NSObject

@property (strong, nonatomic) NSMutableArray *instanceEntries;


- (NSArray *)instancesForName:(NSString *)name;

- (void)addInstance:(Instance *)instance;
- (void)addInstanceEntry:(InstanceFieldEntry *)entry;
- (void)addInstance:(Instance *)instance forEntryName:(NSString *)entryName;
- (void)assignInstance:(Instance *)instance toName:(NSString *)name;
@property (strong, nonatomic) Instance *inInstance, *thisResolver;
//- (void)addInstance:(Instance *)instance forName:(NSString *)name;
//- (void)addSubField:(Field *)subField;
//- (void)removeSubField:(Field *)subField;
//- (NSArray *)listOfMethodCallsForInstance:(Instance *)instance andMethodName:(NSString *)methodName;
//- (NSArray *)functionForInstance:(Instance *)instance andMethodName:(NSString *)methodName;
//considering the two methods under field or compile or @property (strong, nonatomic) XClass *definingClass; in Instance
@end
