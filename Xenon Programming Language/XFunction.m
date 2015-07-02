//
//  XFunction.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XFunction.h"
#import "XName.h"
#import "XParameter.h"
#import "XMethodCall.h"
#import "XType.h"
#import "XLocalVariable.h"
#import "NSMutableArray+XSerialization.h"

@implementation XFunction

- (NSMutableArray *)parameters
{
    if (!_parameters) {
        _parameters = [[NSMutableArray alloc] init];
    }
    return _parameters;
}

- (NSMutableArray *)methodCalls
{
    if (!_methodCalls) {
        _methodCalls = [[NSMutableArray alloc] init];
    }
    return _methodCalls;
}

- (NSMutableArray *)localVariables
{
    if (!_localVariables) {
        _localVariables = [[NSMutableArray alloc] init];
    }
    return _localVariables;
}

- (NSMutableArray *)localFunctions
{
    if (!_localFunctions) {
        _localFunctions = [[NSMutableArray alloc] init];
    }
    return _localFunctions;
}

- (NSString *)stringRepresentation
{
    return self.name.stringRepresentation;
}
#define KEY_NAME @"name"
#define KEY_PARAMETERS @"parameters"
#define KEY_METHOD_CALLS @"methodCalls"
#define KEY_LOCAL_VARIABLES @"localVariables"
#define KEY_LOCAL_FUNCTIONS @"localFunctions"
#define KEY_RETURN_TYPE @"returnType"

- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.name JSONObject] forKey:KEY_NAME];
    [dic setObject:[self.returnType JSONObject] forKey:KEY_RETURN_TYPE];
    [dic setObject:[self.parameters JSONObject] forKey:KEY_PARAMETERS];
    [dic setObject:[self.localVariables JSONObject] forKey:KEY_LOCAL_VARIABLES];
    [dic setObject:[self.localFunctions JSONObject] forKey:KEY_LOCAL_FUNCTIONS];
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if (self) {
        self.name = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:KEY_NAME]];
        self.parameters = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_PARAMETERS] generator:^id(id jsonObjectInTheArray) {
            return [[XParameter alloc] initWithJSONObject:jsonObjectInTheArray];
        }];
        self.methodCalls = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_METHOD_CALLS] generator:^id(id jsonObjectInTheArray) {
            return [[XMethodCall alloc] initWithJSONObject:jsonObjectInTheArray];
        }];
        self.localVariables = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_LOCAL_VARIABLES] generator:^id(id jsonObjectInTheArray) {
            return [[XLocalVariable alloc] initWithJSONObject:jsonObjectInTheArray];
        }];
        self.localFunctions = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_LOCAL_FUNCTIONS] generator:^id(id jsonObjectInTheArray) {
            return [[XFunction alloc] initWithJSONObject:jsonObjectInTheArray];
        }];
        self.returnType = [[XType alloc] initWithJSONObject:[jsonObject objectForKey:KEY_RETURN_TYPE]];
    }
    return self;
}

@end
