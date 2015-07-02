//
//  ProgramExecuter.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/7/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProgramLoader.h"
#import "Xenon.h"
#import "ProjectAnalyzer.h"

@interface ProgramLoader ()

@property (strong, nonatomic) XProject *rootProject;
@property (strong, nonatomic) id<ProgramLoaderDelegate> loaderDelegate;
@property (strong, nonatomic) ProjectAnalyzer *compiler;

@end


@implementation ProgramLoader

#pragma mark - lazy instantiation

- (ProjectAnalyzer *)compiler
{
    if (!_compiler) {
        _compiler = [[ProjectAnalyzer alloc] init];
    }
    return _compiler;
}

- (instancetype)initWithProject:(XProject *)project delegate:(id<ProgramLoaderDelegate>)programDelegate
{
    self = [super init];
    if (self) {
        self.rootProject = project;
        self.loaderDelegate = programDelegate;
    }
    return self;
}

- (void)start
{
    XClass *cla = [self.compiler classForName:@"Start"];
    if (!cla) {
        [self.loaderDelegate programLoader:self outputString:@"No entry point to the program. Class \"Start\" not found in the project."];
        return;
    }
    
}

@end
