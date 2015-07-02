////
////  ProgramExecuter.m
////  Xenon Programming Language
////
////  Created by Chen Zhibo on 6/11/15.
////  Copyright (c) 2015 Chen Zhibo. All rights reserved.
////
//
//#import "ProgramExecuter.h"
//#import "Field.h"
//#import "Instance.h"
//#import "XMethodCall.h"
//#import "XName.h"
//#import "XClass.h"
//#import "XFunction.h"
//#import "XLocalVariable.h"
//@interface ProgramExecuter ()
//
//
//@property (strong, nonatomic) Instance *instance;
//@property (strong, nonatomic) XMethodCall *methodCall;
//@property (strong, nonatomic) Field *field;
//@property (strong, nonatomic) id<ProgramExecuterDelegate> programExecuterDelegate;//do not use it for the time being
//
//@end
//
//@implementation ProgramExecuter
//
//- (instancetype)initWithStartingInstance:(Instance *)startingInstance methodCall:(XMethodCall *)methodCall field:(Field *)field delegate:(id<ProgramExecuterDelegate>)delegate
//{
//    self = [super init];
//    if (self) {
//        self.instance = startingInstance;
//        self.methodCall = methodCall;
//        self.field = field;
////        self.programExecuterDelegate = delegate;
//    }
//    return self;
//}
//
//- (Instance *)executeForResult//should not return nil
//{
//    //calculate instance
//    Instance *inst;
//    if ([self.methodCall instanceName]) {
//        inst = [self.field instanceForName:self.methodCall.instanceName.stringRepresentation];
//        
//    } else if ([self.methodCall instanceMethodCall]){
//        ProgramExecuter *exec = [[ProgramExecuter alloc] initWithStartingInstance:self.instance methodCall:self.methodCall.instanceMethodCall field:self.field delegate:self.programExecuterDelegate];
//        inst = [exec executeForResult];
//    } else {
//        inst = self.instance;
//    }
//    //if inst is not defined, inst is considerred to be self
//    
//    //calculate arguments
//    NSMutableArray *calculatedArguemnts = [NSMutableArray array];
//    [self.methodCall.arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        if ([obj isKindOfClass:[XMethodCall class]]) {
//            ProgramExecuter *programExecuter = [[ProgramExecuter alloc] initWithStartingInstance:self.instance methodCall:obj field:self.field delegate:self.programExecuterDelegate];
//            [calculatedArguemnts addObject:[programExecuter executeForResult]];
//        } else if ([obj isKindOfClass:[XName class]]){
//            [calculatedArguemnts addObject:[self.field instanceForName:[obj stringRepresentation]]];
//        } else {
//            [calculatedArguemnts addObject:[Instance stringInstanceWithString:obj]];
//        }
//    }];
//    
//    Instance *returnedInstance = [self performMethodWithName:self.methodCall.functionName.stringRepresentation onInstance:inst withArguments:calculatedArguemnts];
//    if (!returnedInstance) {
//        returnedInstance = [Instance nilInstance];
//    }
//    return returnedInstance;
//}
//
//- (Instance *)performMethodWithName:(NSString *)name onInstance:(Instance *)startingInstance withArguments:(NSArray *)arguments//of type instances
//{
//    //get function;
//    Instance *instance = [self.field instanceForName:name];
//    if (![instance isFunction]) {
//        [self.programExecuterDelegate programExecuter:self outputString:@"Attempt to perform unrecognized method on instance" withType:ProgramExecuterOutputMessageTypeError];
//        return nil;
//    }
//    XFunction *func = instance.objectiveCModel;
//    if (func.parameters.count != arguments.count) {
//        [self.programExecuterDelegate programExecuter:self outputString:@"Parameter numbers mismatch" withType:ProgramExecuterOutputMessageTypeWarning];
//    }
//    //compute new field
//    
//    Field *field = [[Field alloc] init];
//    [func.localVariables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [field addInstance:[Instance instanceForVariable:obj]];
//    }];
//    [func.parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [field addInstance:[Instance instanceForVariable:obj]];
//    }];
//    [func.localFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [field addInstance:[Instance functionInstanceWithFunction:obj]];
//    }];
////    [self.field addSubField:field];
//    
//    //compute
//    __block Instance *instanceToReturn = [Instance nilInstance];
//    NSArray *listOfMethodCalls = func.methodCalls;
//    [listOfMethodCalls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        XMethodCall *mc = obj;
//        ProgramExecuter *exec = [[ProgramExecuter alloc] initWithStartingInstance:instance methodCall:mc field:self.field delegate:self.programExecuterDelegate];
//        instanceToReturn = [exec executeForResult];
//    }];
//    return instanceToReturn;
//    
//}
//
//@end
