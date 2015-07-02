//
//  Instance.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "Instance.h"
#import "Field.h"
#import "MessageDispatcher.h"
#import "XMethodCall.h"
#import "XFunction.h"
#import "XArgument.h"
#import "XParameter.h"
#import "ProjectAnalyzer.h"
#import "XName.h"

@interface Instance ()

@property (weak, nonatomic) Instance *returnValue;
@property (nonatomic) BOOL shouldReturn;

@end

@implementation Instance

@synthesize field = _field;
- (Field *)field
{
    if (!_field) {
        _field = [[Field alloc] init];
    }
    return _field;
}
- (Instance *)respondToMethodCallWithName:(NSString *)functionName andArgumets:(NSMutableArray *)arguments
{
    if ([functionName isEqualToString:@"native"]) {
        return [self respondToNativeMethodCWithArguments:arguments];
    }
    id instances = [self.field instancesForName:functionName];
    NSMutableArray *eligibleInstances = [NSMutableArray array];
    for (Instance *instance in instances) {
        if (instance.isFunction) {
            [eligibleInstances addObject:instance];
        }
    }
    Instance *finalFunctionInst;
    //method undefined
    if (eligibleInstances.count == 0) {
        [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Attempt to Call a Undefined Method"] sender:self];
    } else
    //method overload
    
    if (eligibleInstances.count>1) {
        NSMutableArray *overloadEligibleInstances = [NSMutableArray array];
        for (Instance *overloadInstance in eligibleInstances) {
            if ([self isArguments:arguments matchedFunction:overloadInstance.objectiveCModel]) {
                [overloadEligibleInstances addObject:overloadInstance];
            }
        }
        if (overloadEligibleInstances.count == 0) {
            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Attempt to Call a Undefined Method"] sender:self];
        } else if (overloadEligibleInstances.count > 1){
            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"More than one qualified function"] sender:self];
        } else {
            finalFunctionInst = overloadEligibleInstances.firstObject;
        }
    } else
        
    {
        finalFunctionInst = eligibleInstances.firstObject;
    }
    
    XFunction *func = finalFunctionInst.objectiveCModel;
    //create child instance
    Instance *childFunctionInstance = [[Instance alloc] init];
    
    
    Field *childField = [[Field alloc] init];
    [func.localVariables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [childField addInstance:[Instance newInstanceForVariable:obj projectAnalyzer:self.analyzer]];
    }];
    [func.parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [childField addInstance:[Instance newInstanceForVariable:obj projectAnalyzer:self.analyzer]];
    }];
    [func.localFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [childField addInstance:[Instance functionInstanceWithFunction:obj]];
    }];
    childFunctionInstance.field = childField;
    
    childFunctionInstance.messageDispatcher = self.messageDispatcher;
    childFunctionInstance.analyzer = self.analyzer;
    childFunctionInstance.baseInstance = self;
    childFunctionInstance.isSubInstance = YES;
    
    NSArray *methodCallsToExecute = func.methodCalls;
    
    for (XMethodCall *mtdCall in methodCallsToExecute) {
        [childFunctionInstance performMethodCall:mtdCall];
        if (self.shouldReturn) {
            self.shouldReturn = NO;
            Instance *returnInstance = self.returnValue;
            self.returnValue = nil;
            return returnInstance;
        }
    }
    return [Instance nilInstance];
    
}

- (void)returnObject:(Instance *)returnValue
{
    self.shouldReturn = YES;
    self.returnValue = returnValue;
}

- (Instance *)performMethodCall:(XMethodCall *)methodCall
{
    Instance *instanceToPerformMethodOn = [Instance nilInstance];
    if (methodCall.instanceName) {
        NSArray *availableInstances = [self.field instancesForName:methodCall.instanceName.stringRepresentation];
        if (availableInstances.count == 0) {
            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Undefined Variable"] sender:self];
        } else if (availableInstances.count > 2){
            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"More than one variable found on the instance"] sender:self];
        } else {
            instanceToPerformMethodOn = availableInstances.firstObject;
        }
        
    } else if (methodCall.instanceMethodCall) {
        instanceToPerformMethodOn = [self performMethodCall:methodCall];
        
    } else {
        instanceToPerformMethodOn = self;
    }
    
    return [instanceToPerformMethodOn respondToMethodCallWithName:methodCall.functionName.stringRepresentation andArgumets:methodCall.arguments];
}

- (BOOL)isArguments:(NSArray *)arguments matchedFunction:(XFunction *)function//only check parameters match
{
   
    NSArray *parameters = function.parameters;
    if (arguments.count != parameters.count) {
        return NO;
    }
    for (int i = 0; i < arguments.count; i ++) {
        XArgument *arg = arguments[i];
        XParameter *para = parameters[i];
        if (![self.analyzer isArgumentType:arg.type matchedWithParameterType:para.type]) {
#warning Just arg.Type May Create Problem as explicit type conversion might trick the analyzer
            return NO;
        }
    }
    return YES;
    
}


- (Instance *)respondToNativeMethodCWithArguments:(NSArray *)arguments
{
    //TODO
    return nil;
}

- (void)setField:(Field *)field
{
    _field = field;
    _field.inInstance = self;
}

@end
