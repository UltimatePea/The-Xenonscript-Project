//
//  Instance.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XClass;
@class XFunction;
@class XVariable;
@class Field;
//@class ProgramExecuter;
@class ProjectAnalyzer;
@class MessageDispatcher;
@class XMethodCall;



@interface Instance : NSObject

@property (strong, nonatomic) id objectiveCModel;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Field *field;
@property (strong, nonatomic) MessageDispatcher *messageDispatcher;
@property (strong, nonatomic) ProjectAnalyzer *analyzer;
//@property (strong, nonatomic) ProgramExecuter *programExecuter;
@property (strong, nonatomic) Instance *baseInstance;//for inheritance
- (Instance *)respondToMethodCallWithName:(NSString *)functionName andArgumets:(NSMutableArray *)arguments;
- (Instance *)performMethodCall:(XMethodCall *)methodCall;
@property (strong, nonatomic) XClass *definingClass;//this one or the two methods under field or cimpiler
@property (strong, nonatomic) Instance *parentInstance;//for stack trace
@property (strong, nonatomic) NSString *currentlyRespondingToMethodName;



+ (instancetype)nilInstance;
+ (instancetype)stringInstanceWithString:(NSString *)string;
+ (instancetype)functionInstanceWithFunction:(XFunction *)function;
+ (instancetype)newInstanceForVariable:(XVariable *)variable  projectAnalyzer:(ProjectAnalyzer *)analyzer;
- (BOOL)isFunction;
- (BOOL)isNil;
- (BOOL)isString;
@property (nonatomic) BOOL isNil, isFunction, isString, isSubInstance;

/*
 Common Instances have both names and objectiveCModels;
 String Instances have only objectiveCModels;
 Function Instances have objectiveCModel of type XFunction;
 Instances that have not been assigned any value have only names;
 Nil Instances have neither names nor objectiveCModels;
 */

@end

