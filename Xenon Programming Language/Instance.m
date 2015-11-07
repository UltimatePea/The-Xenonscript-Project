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
//#import "XMethodCall.h"
//#import "XFunction.h"
//#import "XArgument.h"
//#import "XParameter.h"
#import "ProjectAnalyzer.h"
//#import "XName.h"
#import "Xenon.h"
#import "ThreadLockingManager.h"
#import "Stack.h"
#import "SharedRuntimeUI.h"
#import "NotificationCenterNameRecord.h"
#import "XSString.h"
#import "XSKit.h"
#import "NativeMethodCall.h"
@interface Instance ()

@property (weak, nonatomic) Instance *returnValue;
@property (nonatomic) BOOL shouldReturn;

@end

@implementation Instance
//#warning CRASH WORK, SHOULD REDESIGN ALL THROUGH

- (id)objectiveCModel
{
    if (!_objectiveCModel) {
        _objectiveCModel = [self.baseInstance objectiveCModel];
        //lazy instantiation
        if (self.baseInstance == nil && _objectiveCModel == nil) {
            _objectiveCModel = [[XSObject alloc] init];
        }
    }
    return _objectiveCModel;
}

- (XClass *)definingClass
{
    if (_definingClass) {
        return _definingClass;
    }
    if (self.baseInstance) {
        return [self.baseInstance definingClass];
    }
    return nil;
}

- (BOOL)isString
{
    if (_isString) {
        return _isString;
    } else {
        return [self.objectiveCModel isKindOfClass:[XSString class]];
    }
}

- (MessageDispatcher *)messageDispatcher
{
    if (!_messageDispatcher) {
        _messageDispatcher = [MessageDispatcher sharedMessgeDispatcher];
    }
    return _messageDispatcher;
}

@synthesize field = _field;
- (Field *)field
{
    if (!_field) {
        _field = [[Field alloc] init];
        _field.inInstance = self;
    }
    return _field;
}

#pragma mark - Runtime Behaviour

- (Instance *)respondToMethodCallWithName:(NSString *)functionName andArgumets:(NSMutableArray *)arguments
{
    //calculate arguments
    
    NSMutableArray *argumentInstances = arguments;
    
    
    
    
    
    //calculate methods
    if ([functionName isEqualToString:@"native"]) {
        return [self respondToNativeMethodCallWithArguments:argumentInstances];
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
        [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Attempt to Call an Undefined Method %@", functionName] sender:self];
    } else
    //method overload
    
//    if (eligibleInstances.count>1) {
        ////NOT Consider  Method overload
//        NSMutableArray *overloadEligibleInstances = [NSMutableArray array];
//        for (Instance *overloadInstance in eligibleInstances) {
//            if ([self isArguments:arguments matchedFunction:overloadInstance.objectiveCModel]) {
//                [overloadEligibleInstances addObject:overloadInstance];
//            }
//        }
//        if (overloadEligibleInstances.count == 0) {
//            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Attempt to Call an Undefined Method"] sender:self];
//        } else if (overloadEligibleInstances.count > 1){//consider method override, arbitrarily select the firs
////            [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"More than one qualified function"] sender:self];
//            finalFunctionInst = overloadEligibleInstances.firstObject;
//        } else {
//            finalFunctionInst = overloadEligibleInstances.firstObject;
//        }
//    } else
        
    {
        finalFunctionInst = eligibleInstances.firstObject;
    }
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //execute function
    XFunction *func = ((XSXFunction *)finalFunctionInst.objectiveCModel).function;
    //create child instance
    Instance *childFunctionInstance = [[Instance alloc] init];
    
    
    Field *childField = [[Field alloc] init];
    [func.localVariables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [childField addInstance:[Instance newInstanceForVariable:obj projectAnalyzer:self.analyzer]];
    }];
    if (func.parameters.count != argumentInstances.count) {
        [self.messageDispatcher dispatchErrorMessage:[NSString stringWithFormat:@"Attempt to call method \"%@\" with incorrect number of arguments.", functionName] sender:self];
        return [Instance nilInstance];
    }
    [func.parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        [childField addInstance:[Instance newInstanceForVariable:obj projectAnalyzer:self.analyzer]];
        [childField addInstance:argumentInstances[idx] forEntryName:((XParameter *)obj).name.stringRepresentation];
#warning lacking assignment//FIXED assigned through the adding of instance in the field
    }];
    [func.localFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [childField addInstance:[Instance functionInstanceWithFunction:obj]];
    }];
    childFunctionInstance.field = childField;
    
    childFunctionInstance.messageDispatcher = self.messageDispatcher;
    childFunctionInstance.analyzer = self.analyzer;
    childFunctionInstance.baseInstance = self;
    childFunctionInstance.isSubInstance = YES;
    
    childFunctionInstance.parentInstance = self;
    self.childInstance = childFunctionInstance;
    
    self.currentlyRespondingToMethodName = functionName;
    NSLog(@"Responding to method: %@",functionName);
    NSArray *methodCallsToExecute = func.methodCalls;
    
    for (XMethodCall *mtdCall in methodCallsToExecute) {
        
        NSLog(@"SHOULD BRK: %d", mtdCall.shouldBreak);
        
        
        [[Stack sharedStack] willCallMethod:mtdCall.functionName.stringRepresentation onClass:childFunctionInstance.definingClass.name.stringRepresentation methodCall:mtdCall sendingInstance:childFunctionInstance];
        
        
        
        if ([[ThreadLockingManager sharedManager] shouldCancel]) {
            if ([[NSThread currentThread] isCancelled]) {
                self.shouldReturn = YES;
            }else
            {
                [[NSThread currentThread] cancel];
            }
        }
        
        if (mtdCall.shouldBreak == YES ||
            [[ThreadLockingManager sharedManager] shouldPause]
            ||
            [[ThreadLockingManager sharedManager] shouldPauseForInstance:self]
            ) {
            NSLog(@"Breaking");
            
//            dispatch_suspend(dispatch_get_current_queue());
//            [NSThread sleepForTimeInterval:10];
            ThreadLockingManager *lockManager = [ThreadLockingManager sharedManager];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CENTER_BREAK_POINT_NOTIFICATION object:self userInfo:@{@"info":self}];
            [lockManager.condition lock];
            lockManager.lock = YES;
            while(lockManager.lock)
            {
                NSLog(@"Will Wait");
                [lockManager.condition wait];
                
                // the "did wait" will be printed only when you have signaled the condition change in the sendNewEvent method
                NSLog(@"Did Wait");
            }
            [lockManager.condition unlock];
            // read your event from your event queue
            
            
            
            // lock the condition again
            
        }
        
         //performing method call
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CENTER_RESUMED_EXECUTION object:self];
        
        
        
        [childFunctionInstance performMethodCall:mtdCall];
        
        
        [[Stack sharedStack] didCallMethod:mtdCall.functionName.stringRepresentation onClass:childFunctionInstance.definingClass.name.stringRepresentation methodCall:mtdCall sendingInstance:childFunctionInstance];
        
        
       
        
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
    //check assignment
    
    
    
    
    Instance *instanceToPerformMethodOn = [Instance nilInstance];
    if (methodCall.instanceName) {
        instanceToPerformMethodOn = [self evaluateInstanceXName:methodCall.instanceName];
#warning TODO nil detection//FIXED name cannot be nil
    } else if (methodCall.instanceMethodCall) {
        [[Stack sharedStack] willCallMethod:methodCall.functionName.stringRepresentation onClass:instanceToPerformMethodOn.definingClass.name.stringRepresentation methodCall:methodCall sendingInstance:self];
        instanceToPerformMethodOn = [self performMethodCall:methodCall];
        [[Stack sharedStack] didCallMethod:methodCall.functionName.stringRepresentation onClass:instanceToPerformMethodOn.definingClass.name.stringRepresentation methodCall:methodCall sendingInstance:self];
        
    } else {
        instanceToPerformMethodOn = self;
    }
    
    //calculate arguments
    NSMutableArray *argumentInstances = [NSMutableArray array];
    [methodCall.arguments enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ([obj isKindOfClass:[XMethodCall class]]) {
            [[Stack sharedStack] willCallMethod:methodCall.functionName.stringRepresentation onClass:instanceToPerformMethodOn.definingClass.name.stringRepresentation methodCall:methodCall sendingInstance:self];
            [argumentInstances addObject:[self performMethodCall:obj]];
            [[Stack sharedStack] didCallMethod:methodCall.functionName.stringRepresentation onClass:instanceToPerformMethodOn.definingClass.name.stringRepresentation methodCall:methodCall sendingInstance:self];
        } else if ([obj isKindOfClass:[XArgument class]]){
            [argumentInstances addObject:[self evaluateInstanceXName:((XArgument *) obj).name]];
        } else if ([obj isKindOfClass:[NSString class]]){
            [argumentInstances addObject:[Instance stringInstanceWithString:obj]];
        } else {
            [argumentInstances addObject:[Instance nilInstance]];//should never be called
        }
    }];
    
    
    Instance *returnValue =  [instanceToPerformMethodOn respondToMethodCallWithName:methodCall.functionName.stringRepresentation andArgumets:argumentInstances];
    
    
    return returnValue;
}

- (Instance *)evaluateInstanceXName:(XName *)instanceName
{
    NSArray *availableInstances = [self.field instancesForName:instanceName.stringRepresentation];
    if (availableInstances.count == 0) {
        [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"Undefined Variable, %@", instanceName.stringRepresentation] sender:self];
    } else if (availableInstances.count > 2){
        [self.messageDispatcher dispatchErrorMessage:[NSString localizedStringWithFormat:@"More than one variable found on the instance with name %@", instanceName.stringRepresentation] sender:self];
    } else {
        return availableInstances.firstObject;
    }
    return [Instance nilInstance];
}

- (BOOL)isArguments:(NSArray *)arguments matchedFunction:(XFunction *)function//only check parameters match
{
   
    NSArray *parameters = function.parameters;
    if (arguments.count != parameters.count) {
        return NO;
    } else{
//    for (int i = 0; i < arguments.count; i ++) {
//        XArgument *arg = arguments[i];
//        XParameter *para = parameters[i];
//        if (![self.analyzer isArgumentType:arg.type matchedWithParameterType:para.type]) {
//#warning Just arg.Type May Create Problem as explicit type conversion might trick the analyzer
//            return NO;
//        }
//    }
        return YES;}
    
}




- (void)setField:(Field *)field
{
    _field = field;
    _field.inInstance = self;
}

#pragma mark - Initialization Codes

+ (instancetype)nilInstance
{
    return [[self alloc] init];
}
+ (instancetype)stringInstanceWithString:(NSString *)string
{
    return [[self alloc] initSelfWithString:string];
}

- (instancetype)initSelfWithString:(NSString *)string
{
    self = [self init];
    if (self) {
        XSString *xsstring = [[XSString alloc] initWithNSString:string];
        self.objectiveCModel = xsstring;
        self.isString = YES;
    }
    return self;
}

+ (instancetype)functionInstanceWithFunction:(XFunction *)function
{
    return [[self alloc] initSelfWithFunction:function];
}

- (instancetype)initSelfWithFunction:(XFunction *)function
{
    self = [self init];
    if (self) {
        self.objectiveCModel = [XSXFunction instanceWithXFunction:function];
        self.isFunction = YES;
        self.name = function.name.stringRepresentation;
    }
    return self;
}
+ (instancetype)newInstanceForVariable:(XVariable *)variable  projectAnalyzer:(ProjectAnalyzer *)analyzer
{
    return [[self alloc] initSelfWithVariable:variable projectAnalyzer:analyzer];
}

- (instancetype)initSelfWithVariable:(XVariable *)variable  projectAnalyzer:(ProjectAnalyzer *)analyzer;
{
    self = [self init];
    if (self) {
        self.name = variable.name.stringRepresentation;
        self.analyzer = analyzer;
        NSLog(@"Analyzing Type %@ on Instance %@", variable.type.stringRepresentation, self);
        XClass *definingClass = [self.analyzer classForName:variable.type.stringRepresentation];
        if (definingClass == nil) {
            [self.messageDispatcher dispatchErrorMessage:[NSString stringWithFormat:@"Undefined Type: %@.", variable.type.stringRepresentation] sender:self];
            return nil;
        }
        __block BOOL initMethodExists = NO;
        [definingClass.properties enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
            XProperty *prop = obj;
            [self.field addInstance:[Instance newInstanceForVariable:prop projectAnalyzer:analyzer]];
        }];
        [definingClass.methods enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
            XFunction *func = obj;
            if ([func.name.stringRepresentation isEqualToString:@"init"]) {
                initMethodExists = YES;
            }
            [self.field addInstance:[Instance functionInstanceWithFunction:func]];
        }];
        if (![definingClass.baseClass.stringRepresentation isEqualToString:@"Native"]) {
            self.baseInstance = [[Instance alloc] initWithTypeString:definingClass.baseClass.stringRepresentation projectAnalyzer:analyzer];
            self.baseInstance.analyzer = self.analyzer;
            self.baseInstance.messageDispatcher = self.messageDispatcher;
            self.baseInstance.field.thisResolver = self.field.thisResolver;
        }
        self.definingClass = definingClass;
        if (initMethodExists) {
            XMethodCall *mtdCall = [[XMethodCall alloc] init];
            mtdCall.instanceName = [[XName alloc] initWithString:@"this"];
            mtdCall.functionName = [[XName alloc] initWithString:@"init"];
            [self performMethodCall:mtdCall];
        }
        
    }
    return self;
}

- (instancetype)initWithTypeString:(NSString *)type projectAnalyzer:(ProjectAnalyzer *)analyzer;
{
    XVariable *var = [[XVariable alloc] init];
    var.name = [[XName alloc] initWithString:@"Base Instance"];
    var.type = [[XType alloc] initWithString:type];
        
    
    return [self initSelfWithVariable:var projectAnalyzer:analyzer];
}


#pragma mark - native method calls
- (Instance *)respondToNativeMethodCallWithArguments:(NSArray *)arguments
{
        NSString *nativeMethodCallName;
        id pseudoStirng = arguments.firstObject;
    //    if ([pseudoStirng isKindOfClass:[NSString class]]) {
    //
    //        nativeMethodCallName = pseudoStirng;
    //    }
    //    else/////never called
            if ([pseudoStirng isKindOfClass:[Instance class]]){
            Instance *pseudoStirngInst = pseudoStirng;
            if (pseudoStirngInst.isString) {
                nativeMethodCallName = ((XSString *)pseudoStirngInst.objectiveCModel).string;
            } else {
                [self.messageDispatcher dispatchErrorMessage:@"Native Method Call Argument Mismatch: First argument not a string." sender:self];
                return [Instance nilInstance];
//    #warning Should Declare Function, Consider Revising
            }
        } else {
            [self.messageDispatcher dispatchErrorMessage:@"Native Method Call Argument Mismatch: First argument not a string." sender:self];
            return [Instance nilInstance];
        }
    NativeMethodCall *nmc = [[NativeMethodCall alloc] init];
    nmc.firstStringIdentifier = nativeMethodCallName;
    nmc.allArguments = arguments;
    nmc.sendingInstance = self;

    return [self.objectiveCModel respondToNativeMethodCall:nmc];
}
//{
//    
//    //TODO
//    NSString *nativeMethodCallName;
//    id pseudoStirng = arguments.firstObject;
////    if ([pseudoStirng isKindOfClass:[NSString class]]) {
////        
////        nativeMethodCallName = pseudoStirng;
////    }
////    else/////never called
//        if ([pseudoStirng isKindOfClass:[Instance class]]){
//        Instance *pseudoStirngInst = pseudoStirng;
//        if (pseudoStirngInst.isString) {
//            nativeMethodCallName = ((XSString *)pseudoStirngInst.objectiveCModel).string;
//        } else {
//            [self.messageDispatcher dispatchErrorMessage:@"Native Method Call Argument Mismatch: First argument not a string." sender:self];
//            return [Instance nilInstance];
//#warning Should Declare Function, Consider Revising
//        }
//    } else {
//        [self.messageDispatcher dispatchErrorMessage:@"Native Method Call Argument Mismatch: First argument not a string." sender:self];
//        return [Instance nilInstance];
//    }
//    
//    NSArray *nativeNameComponents = [nativeMethodCallName componentsSeparatedByString:@"-"];
//    if (![nativeNameComponents[0] isEqualToString:@"native"]) {
//        [self.messageDispatcher dispatchErrorMessage:[NSString stringWithFormat:@"Calling native method with non native-leading identifier"] sender:self];
//        return [Instance nilInstance];
//    }
//    
//    
//#pragma mark  Object.print();
//    
//    if ([nativeMethodCallName isEqualToString:@"native-print"]) {
//        //not known what way is the arguemnt going to be
//        if ([self checkArguments:arguments forNumberOfString:1] == false) {
//            return [Instance nilInstance];
//        }
//        if ([arguments[1] isKindOfClass:[NSString class]]) {
//            [self.messageDispatcher dispatchInformationMessage:arguments[1] sender:self];
//            return [Instance nilInstance];
//        } else if ([arguments[1] isKindOfClass:[Instance class]]){
//            Instance *inst = arguments[1];
//            if ([inst isString]){
//                [self.messageDispatcher dispatchInformationMessage:inst.objectiveCModel sender:self];
//                return [Instance nilInstance];
//            }
//        }
//    }
//    
//    
//    
//#warning SERIOUS!!! BAD PRACTICE OF COPYING MATH CODES
//#pragma mark  Math
//    if ([nativeMethodCallName isEqualToString:@"native-math-add"]) {
//        if ([self checkArguments:arguments forNumberOfString:2] == false) {
//            return [Instance nilInstance];
//        }
//        NSArray *strings = [self strFromArguments:arguments];
//        return [Instance stringInstanceWithString:[NSString stringWithFormat:@"%f", [strings[1] floatValue]+[strings[2] floatValue]]];
//    }
//    
//    if ([nativeMethodCallName isEqualToString:@"native-math-subtract"]) {
//        if ([self checkArguments:arguments forNumberOfString:2] == false) {
//            return [Instance nilInstance];
//        }
//        NSArray *strings = [self strFromArguments:arguments];
//        return [Instance stringInstanceWithString:[NSString stringWithFormat:@"%f", [strings[1] floatValue]-[strings[2] floatValue]]];
//    }
//    
//    if ([nativeMethodCallName isEqualToString:@"native-math-multiply"]) {
//        if ([self checkArguments:arguments forNumberOfString:2] == false) {
//            return [Instance nilInstance];
//        }
//        NSArray *strings = [self strFromArguments:arguments];
//        return [Instance stringInstanceWithString:[NSString stringWithFormat:@"%f", [strings[1] floatValue]*[strings[2] floatValue]]];
//    }
//    
//    if ([nativeMethodCallName isEqualToString:@"native-math-divide"]) {
//        if ([self checkArguments:arguments forNumberOfString:2] == false) {
//            return [Instance nilInstance];
//        }
//        NSArray *strings = [self strFromArguments:arguments];
//        return [Instance stringInstanceWithString:[NSString stringWithFormat:@"%f", [strings[1] floatValue]/[strings[2] floatValue]]];
//    }
//#pragma mark  Array
//    if ([nativeNameComponents[1] isEqualToString:@"array"]) {
//        /* native-array-create */
//        if ([nativeMethodCallName isEqualToString:@"native-array-create"]) {
//            self.objectiveCModel = [NSMutableArray array];
//            return [Instance nilInstance];
//        }
//    }
//    
//#define STRING_BOOL_TRUE @"true"
//    //math true or false
//    if ([nativeMethodCallName isEqualToString:@"native-math-equal"]) {
//        if ([self checkArguments:arguments forNumberOfString:2] == false) {
//            return [Instance nilInstance];
//        }
//        NSArray *strings = [self strFromArguments:arguments];
//        return [Instance stringInstanceWithString:[NSString stringWithFormat:@"%@",  [strings[1] floatValue] == [strings[2] floatValue]?STRING_BOOL_TRUE:@"false"]];
//    }
//#pragma mark  Logics
//    //logics
//    if ([nativeMethodCallName isEqualToString:@"native-logics-if-then-end"]) {
//        if (arguments.count != 4) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Arguemtn Number Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        Instance *boolInst = arguments[1];
//        Instance *trueResponseFunc = arguments[2];
//        if (![boolInst.objectiveCModel isKindOfClass:[XSString class]]) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : First Argument Type Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        if ([boolInst.objectiveCModel isEqualToString:STRING_BOOL_TRUE]) {
//            if (trueResponseFunc.isFunction == false) {
//                [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Second Argument Type Mismatch", nativeMethodCallName] sender:self];
//                return [Instance nilInstance];
//            }
//            XFunction *funcToExec = trueResponseFunc.objectiveCModel;
//            [arguments[3] respondToMethodCallWithName:funcToExec.name.stringRepresentation andArgumets:nil];
//            return [Instance nilInstance];
//        }
//        
//    }
//    
//    if ([nativeMethodCallName isEqualToString:@"native-logics-for"]) {
//        if (arguments.count != 4) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Arguemtn Number Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        Instance *intInst = arguments[1];
//        Instance *execFunc = arguments[2];
//        if (![intInst.objectiveCModel isKindOfClass:[XSString class]]) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : First Argument Type Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        if (execFunc.isFunction == false) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Second Argument Type Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        
//        
//        XFunction *funcToExec = execFunc.objectiveCModel;
//        for (int i = 0; i < [intInst.objectiveCModel intValue]; i ++) {
//            
//            [arguments[3] respondToMethodCallWithName:funcToExec.name.stringRepresentation andArgumets:[NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%d", i]]]];
//        }
//        
//        return [Instance nilInstance];
//        
//    }
//    
//#pragma mark  Multithreading
//    /*
//     Arguments 
//     native-multithreading-dispatch-async(-onmainthread)
//     
//     function
//     target
//     arguments...
//     */
//     
//     
//    
//    if ([nativeNameComponents[1] isEqualToString:@"multithreading"]) {
//        if (arguments.count <= 3) {
//            [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//            return [Instance nilInstance];
//        }
//        Instance *funcInst = arguments[1];
//        Instance *target = arguments[2];
//        XFunction *funcToExec = funcInst.objectiveCModel;
//        
//        NSRange range;
//        range.location = 3;
//        range.length = arguments.count - 3;
//        
//        dispatch_queue_t queue;
//        if ([nativeMethodCallName isEqualToString:@"native-multithreading-dispatch-async"]) {
//            queue = dispatch_queue_create("queue created programmaticallly", NULL);
//        } else if ([nativeMethodCallName isEqualToString:@"native-multithreading-dispatch-async-onmainthread"]){
//            queue = dispatch_get_main_queue();
//        } else {
//            queue = dispatch_get_main_queue();
//        }
//        
//        dispatch_async(queue, ^{
//            [target respondToMethodCallWithName:funcToExec.name.stringRepresentation andArgumets:[NSMutableArray arrayWithArray:[arguments subarrayWithRange:range]]];
//        });
//    }
//    
//#pragma mark UI
//    
//    /*
//     Arguments
//     
//     native-ui-get-main-vc
//     
//     target
//     
//     */
//    
//    if ([nativeNameComponents[1] isEqualToString:@"ui"]) {
//        if (arguments.count != 2) {
//            [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//            return [Instance nilInstance];
//        }
//        Instance *target = arguments[1];
//        target.objectiveCModel = [[SharedRuntimeUI sharedRuntimeUI] sharedViewController];
//        return [Instance nilInstance];
//    }
//    
//#pragma mark  Language
//    //lang
//    if ([nativeMethodCallName isEqualToString:@"native-lang-assign"]) {
//        if (arguments.count != 3) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Arguemtn Number Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        Instance *toInst = arguments[1];
//        while (toInst.isSubInstance) {
//            toInst = toInst.baseInstance;
//        }
//        Instance *fromInst = arguments[2];
//        
//        
//        return [toInst assign:fromInst];
//        
//    }
//    
//    if ([nativeMethodCallName isEqualToString:@"native-lang-return"]) {
//        if (arguments.count != 2) {
//            [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Arguemtn Number Mismatch", nativeMethodCallName] sender:self];
//            return [Instance nilInstance];
//        }
//        Instance *returnInst = arguments[1];
//        [self.baseInstance.baseInstance returnObject:returnInst];
//        
//        return [Instance nilInstance];
//        
//    }
//    
//#pragma mark  ObjC (Real Native) (native-objc-...)
//    
//    if (nativeNameComponents.count >= 3) {
//        if ([nativeNameComponents[1] isEqualToString:@"objc"]) {
//            
//            /*
//             Arguments
//             native-objc-create-obj-c-model-012-argument,
//             onInstance,
//             className,
//             selectorName,
//             argument
//             createObjectiveCModel(onInstance, className, selectorName, argument);
//             */
//            if ([nativeMethodCallName isEqualToString:@"native-objc-create-obj-c-model-0-argument"]) {
//                //check count
//                if (arguments.count != 4) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               [NSString class]]]) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                Instance *className = arguments[2];
//                Instance *selectorName = arguments[3];
////                Instance *argument = arguments[4];
//                onInstance.objectiveCModel = [[NSClassFromString(className.objectiveCModel) alloc] performSelector:NSSelectorFromString(selectorName.objectiveCModel)];
//                return [Instance nilInstance];
//            }
//            if ([nativeMethodCallName isEqualToString:@"native-objc-create-obj-c-model-1-argument"]) {
//                //check count
//                if (arguments.count != 5) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               [NSString class],
//                                                               [NSObject class]]]) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                Instance *className = arguments[2];
//                Instance *selectorName = arguments[3];
//                Instance *argument = arguments[4];
//                onInstance.objectiveCModel = [[NSClassFromString(className.objectiveCModel) alloc] performSelector:NSSelectorFromString(selectorName.objectiveCModel) withObject:argument.objectiveCModel];
//                return [Instance nilInstance];
//            }
//            if ([nativeMethodCallName isEqualToString:@"native-objc-create-obj-c-model-2-argument"]) {
//                //check count
//                if (arguments.count != 6) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               [NSString class],
//                                                               [NSObject class],
//                                                               [NSObject class],
//                                                               [NSObject class]]]) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                Instance *className = arguments[2];
//                Instance *selectorName = arguments[3];
//                Instance *argument = arguments[4];
//                Instance *anotherArgument = arguments[5];
//                onInstance.objectiveCModel = [[NSClassFromString(className.objectiveCModel) alloc] performSelector:NSSelectorFromString(selectorName.objectiveCModel) withObject:argument.objectiveCModel withObject:anotherArgument.objectiveCModel];
//                return [Instance nilInstance];
//            }
//            /*
//             Arguments
//             native-objc-perform-method-call-012-argument,
//             onInstance,
//             
//             selectorName,
//             argument
//             createObjectiveCModel(onInstance, selectorName, argument);
//             */
//            if ([nativeMethodCallName isEqualToString:@"native-objc-perform-method-call-0-argument"]) {
//                //check count
//                if (arguments.count != 3) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               ]]) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                
//                Instance *selectorName = arguments[2];
////                Instance *argument = arguments[3];
//                Instance *returnInst = [[Instance alloc] init];
//                returnInst.objectiveCModel = [onInstance.objectiveCModel performSelector:NSSelectorFromString(selectorName.objectiveCModel)];
//                return returnInst;
//            }
//            if ([nativeMethodCallName isEqualToString:@"native-objc-perform-method-call-1-argument"]) {
//                //check count
//                if (arguments.count != 4) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               [NSObject class]]]) {
//                    [self throwNativeArgumentTypeMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                
//                Instance *selectorName = arguments[2];
//                Instance *argument = arguments[3];
//                Instance *returnInst = [[Instance alloc] init];
//                returnInst.objectiveCModel = [onInstance.objectiveCModel performSelector:NSSelectorFromString(selectorName.objectiveCModel) withObject:argument.objectiveCModel];
//                return returnInst;
//            }
//            if ([nativeMethodCallName isEqualToString:@"native-objc-perform-method-call-2-argument"]) {
//                //check count
//                if (arguments.count != 5) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                //check type
//                if (![self checkArguments:arguments forTypes:@[[NSString class],
//                                                               [NSObject class],
//                                                               [NSString class],
//                                                               [NSObject class],
//                                                               [NSObject class]]]) {
//                    [self throwNativeArgumentNumberMismatchError:nativeMethodCallName];
//                    return [Instance nilInstance];
//                }
//                Instance *onInstance = arguments[1];
//                
//                Instance *selectorName = arguments[2];
//                Instance *argument = arguments[3];
//                Instance *anothrArgument = arguments[4];
//                Instance *returnInst = [[Instance alloc] init];
//                returnInst.objectiveCModel = [onInstance.objectiveCModel performSelector:NSSelectorFromString(selectorName.objectiveCModel) withObject:argument.objectiveCModel withObject:anothrArgument.objectiveCModel];
//                return returnInst;
//            }
//            
//            
//            
//        }
//    }
//    
//
//    [self.messageDispatcher dispatchErrorMessage:[NSString stringWithFormat:@"Unrecognized Native Method Call, %@",nativeMethodCallName] sender:self];
//    return [Instance nilInstance];
//}

- (BOOL)checkArguments:(NSArray *)arguments forTypes:(NSArray *)types
{
    __block BOOL result = YES;
    [arguments enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ((![((Instance *)obj).objectiveCModel isKindOfClass:types[idx]])||(((Instance *)obj).objectiveCModel != nil)) {
            result = NO;
        }
    }];
    return YES;
}

- (void)throwNativeArgumentNumberMismatchError:(NSString *)nativeMethodCallName
{
    [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Argument Number Mismatch", nativeMethodCallName] sender:self];
}

- (void)throwNativeArgumentTypeMismatchError:(NSString *)nativeMethodCallName
{
    [self.messageDispatcher dispatchWarningMessage:[NSString stringWithFormat:@"Calling Native Method %@ : Argument Type Mismatch", nativeMethodCallName] sender:self];
}

- (Instance *)assign:(Instance *)valueToBeAssigned
{
    self.objectiveCModel = valueToBeAssigned.objectiveCModel;
    self.field = valueToBeAssigned.field;
    self.messageDispatcher = valueToBeAssigned.messageDispatcher;
    self.analyzer = valueToBeAssigned.analyzer;
    self.baseInstance = valueToBeAssigned.baseInstance;
    self.definingClass = valueToBeAssigned.definingClass;
    self.isNil = valueToBeAssigned.isNil;
    self.isFunction = valueToBeAssigned.isFunction;
    self.isString = valueToBeAssigned.isString;
    return valueToBeAssigned;
}

- (BOOL)checkArguments:(NSArray *)arguments forNumberOfString:(int)numberOfString//arguemnt includes 'native-...', number of strings does not include
{
    if (arguments.count-1 != numberOfString) {
        return false;
    }
    __block BOOL result = true;
    [arguments enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {

        if ([obj isKindOfClass:[Instance class]]) {
            Instance *instance = obj;
            if (instance.isString&&[instance.objectiveCModel isKindOfClass:[XSString class]]) {
                
            } else {
                result = false;
            }
        } else {
            result = false;
        }
    }];
    return result;
}

- (NSArray *)strFromArguments:(NSArray *)arguemnts//make sure to call checkArguments:forNumberOfStrings: before calling this mehtod, contains native method
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (Instance *inst in arguemnts) {
        [array addObject:inst.objectiveCModel];
    }
    return array;
}

#pragma mark - debugging

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"name: %@;\r\nobjcModel: %@\r\nDefining Class: %@\r\n", self.name, self.objectiveCModel, self.definingClass];
}

@end
