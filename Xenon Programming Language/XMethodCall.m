//
//  XMethodCall.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XMethodCall.h"
#import "XName.h"
#import "NSMutableArray+XSerialization.h"
#import "XArgument.h"


@implementation XMethodCall

- (NSMutableArray *)arguments
{
    if (!_arguments) {
        _arguments = [NSMutableArray array];
    }
    return _arguments;
}

- (NSString *)stringRepresentation
{
    return [NSString stringWithFormat:@"%@%@%@(%@)", [self instanceStringRepresentation], [[self instanceStringRepresentation] isEqualToString:INSTANCE_STRING_REP_NIL]?@"":@"." , [self.functionName stringRepresentation], [self argumentStringRepresentation]];
}

- (NSString *)instanceStringRepresentation
{
    if (self.instanceName) {
        return [self.instanceName stringRepresentation];
    } if (self.instanceMethodCall) {
        return [self.instanceMethodCall stringRepresentation];
    } else {
        return INSTANCE_STRING_REP_NIL;
    }
}

- (NSString *)argumentStringRepresentation
{
    __block NSMutableString *result = [[NSMutableString alloc] init];
    
    [self.arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result appendString:[NSString stringWithFormat:@"%@%@",(idx == 0)?@"":@", ", [self stringRepresentationForObject:obj]]];
    }];
    return result;
}

- (NSString *)stringRepresentationForObject:(id)object
{
    if ([object isKindOfClass:[XMethodCall class]]) {
        return [object stringRepresentation];
    } else if ([object isKindOfClass:[XArgument class]]){
        return [((XArgument *) object).name stringRepresentation];
    } else if ([object isKindOfClass:[NSString class]]){
        return [NSString stringWithFormat:@"\"%@\"",object];
    } else {
        return nil;
    }
}
#define KEY_INSTANCE_TYPE @"instanceType"
#define KEY_ARGUMENT_TYPE @"argumentType"
#define TYPE_XNAME @"type-xname"
#define TYPE_NSSTRING @"type-nsstring"
#define TYPE_XARGUMENT @"type-xargument"
#define TYPE_METHOD_CALL @"type-methodCall"
#define TYPE_UNKNOWN @"type-unknown"
#define KEY_INSTANCE @"instance"
#define KEY_FUNCTION_NAME @"function"
#define KEY_ARGUMENTS @"arguments"
- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self getInstanceType] forKey:KEY_INSTANCE_TYPE];
    [dic setObject:[self.functionName JSONObject] forKeyedSubscript:KEY_FUNCTION_NAME];
    [dic setObject:[(self.instanceName?self.instanceName:self.instanceMethodCall) JSONObject]forKeyedSubscript:KEY_INSTANCE];
    [dic setObject:[self getArgumentsTypes] forKeyedSubscript:KEY_ARGUMENT_TYPE];
    [dic setObject:[self.arguments JSONObject] forKeyedSubscript:KEY_ARGUMENTS];
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if (self) {
        NSString *instType = [jsonObject objectForKey:KEY_INSTANCE_TYPE];
        if ([instType isEqualToString:TYPE_XNAME]) {
            self.instanceName = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:KEY_INSTANCE]];
        } else if ([instType isEqualToString:TYPE_METHOD_CALL]){
            self.instanceMethodCall = [[XMethodCall alloc] initWithJSONObject:[jsonObject objectForKey:KEY_INSTANCE]];
        } else {
            NSLog(@"Unable to init String, serious error");
        }
        self.functionName = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:KEY_FUNCTION_NAME]];
        NSArray *argTypes = [jsonObject objectForKey:KEY_ARGUMENT_TYPE];
        int i = 0;
        self.arguments = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_ARGUMENTS] generator:^id(id jsonObjectInTheArray) {
            NSString *argType = argTypes[i];
            if ([argType isEqualToString:TYPE_XARGUMENT]) {
                return [[XArgument alloc] initWithJSONObject:jsonObjectInTheArray];
            } else if ([argType isEqualToString:TYPE_METHOD_CALL]){
                return [[XMethodCall alloc] initWithJSONObject:jsonObjectInTheArray];
            } else if ([argType isEqualToString:TYPE_NSSTRING]){
                return jsonObject;
            } else {
                NSLog(@"error when initialize arguements in xmethod call");
                return nil;
            }
        }];

    }
    return self;
}

- (NSString *)getInstanceType
{
    if (self.instanceName) {
        return TYPE_XNAME;
    } if (self.instanceMethodCall) {
        return TYPE_METHOD_CALL;
    } else {
        NSLog(@"Unable to get Instance Type");
        return TYPE_UNKNOWN;//should never be called
        
    }
}

- (NSArray *)getArgumentsTypes
{
    NSMutableArray *result = [NSMutableArray array];
    [self.arguments enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ([obj isKindOfClass:[XArgument class]]) {
            [result addObject:TYPE_XARGUMENT];
        } else if ([obj isKindOfClass:[XMethodCall class]]){
            [result addObject:TYPE_METHOD_CALL];
        } else if ([obj isKindOfClass:[NSString class]]){
            [result addObject:TYPE_NSSTRING];
        } else {
            [result addObject:TYPE_UNKNOWN];//should not be called
            NSLog(@"Unable to get argument type");
        }
    }];
    return result;
}

@end
