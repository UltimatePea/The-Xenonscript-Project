//
//  ProgramCompiler.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XProject;
@class XClass;
@class XType;
@interface ProjectAnalyzer : NSObject

- (instancetype)initWithProject:(XProject *)project;
- (XClass *)classForName:(NSString *)className;
- (BOOL)isArgumentType:(XType *)argType matchedWithParameterType:(XType *)paraType;

@end
