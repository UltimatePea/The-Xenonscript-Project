//
//  ProgramCompiler.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectAnalyzer.h"
#import "Xenon.h"
@interface ProjectAnalyzer ()

@property (strong, nonatomic) XProject *project;

@end

@implementation ProjectAnalyzer

- (instancetype)initWithProject:(XProject *)project
{
    self = [super init];
    if (self) {
        self.project = project;
    }
    return self ;
}

- (XClass *)classForName:(NSString *)className;
{
    __block XClass *result;
    [self.project.classes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XClass *class = obj;
        if ([class.name.stringRepresentation isEqualToString:className]) {
            result = obj;
        }
    }];
    return result;
}

- (BOOL)isArgumentType:(XType *)argType matchedWithParameterType:(XType *)paraType
{
    return YES;
#warning SERIOUS Incomplete Method Implementation
}

- (XFunction *)functionWhichMethodCallIsIn:(XMethodCall *)methodCall
{
    __block XFunction *result;
    [self.project.classes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XClass *class = obj;
        [class.methods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XFunction *function = obj;
            XFunction *calculatedResult = [self functionAnalysisForMethodCall:methodCall analyzingFunction:function];
            if (calculatedResult) {
                result = calculatedResult;
            }
            
        }];
    }];
    return result;
}

- (XFunction *)functionAnalysisForMethodCall:(XMethodCall *)methodCall analyzingFunction:(XFunction *)function
{
    __block XFunction *result;
    [function.methodCalls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:methodCall]) {
            result = function;
        }
    }];
    if (result == nil) {
        [function.localFunctions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XFunction *func = [self functionAnalysisForMethodCall:methodCall analyzingFunction:obj];
            if (func) {
                result = func;
            }
        }];
    }
    
    return  result;
}

@end
