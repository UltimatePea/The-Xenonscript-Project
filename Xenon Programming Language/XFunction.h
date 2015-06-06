//
//  XFunction.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XName;
@class XType;

@interface XFunction : NSObject

@property (strong, nonatomic) XName *name;
@property (strong, nonatomic) NSMutableArray *parameters;//of Type Parameters
@property (strong, nonatomic) NSMutableArray *methodCalls;//of Type MethodCalls
@property (strong, nonatomic) NSMutableArray *localVariables;//of Type LocalVariable
@property (strong, nonatomic) NSMutableArray *localFunctions;
@property (strong, nonatomic) XType *returnType;

@property (strong, nonatomic, readonly) NSString *stringRepresentation;

@end
