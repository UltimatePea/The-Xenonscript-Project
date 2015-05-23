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
@property (strong, nonatomic) NSArray *parameters;//of Type Parameters
@property (strong, nonatomic) NSArray *methodCalls;//of Type MethodCalls
@property (strong, nonatomic) XType *returnType;

@end
