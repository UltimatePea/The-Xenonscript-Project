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

@interface Field : NSObject

- (NSArray<Instance *> *)instancesForName:(NSString *)name;

- (void)addInstance:(Instance *)instance;
@property (strong, nonatomic) Instance *inInstance;
//- (void)addInstance:(Instance *)instance forName:(NSString *)name;
//- (void)addSubField:(Field *)subField;
//- (void)removeSubField:(Field *)subField;
//- (NSArray *)listOfMethodCallsForInstance:(Instance *)instance andMethodName:(NSString *)methodName;
//- (NSArray *)functionForInstance:(Instance *)instance andMethodName:(NSString *)methodName;
//considering the two methods under field or compile or @property (strong, nonatomic) XClass *definingClass; in Instance
@end
