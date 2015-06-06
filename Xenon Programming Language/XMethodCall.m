//
//  XMethodCall.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XMethodCall.h"
#import "XName.h"
#import "XArgument.h"

@implementation XMethodCall

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
        return object;
    } else {
        return nil;
    }
}

@end
