//
//  ProgramCompiler.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectAnalyzer.h"
#import "XProject.h"
#import "XClass.h"
#import "XName.h"

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

@end
