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
#import "Instance.h"
#import "MessageDispatcher.h"
#import "Stack.h"
#import "Console.h"
#import "ThreadLockingManager.h"
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
        _compiler = [[ProjectAnalyzer alloc] initWithProject:self.rootProject];
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
    MessageDispatcher *dispatcher =[MessageDispatcher sharedMessgeDispatcher];
    XClass *cla = [self.compiler classForName:@"Start"];
    if (!cla) {
//        [self.loaderDelegate programLoader:self outputString:@"No entry point to the program. Class \"Start\" not found in the project."];
        [dispatcher dispatchErrorMessage:@"No entry point to the program. Class \"Start\" not found in the project." sender:self];
        return;
    }
    XType *startType = [[XType alloc] initWithString:@"Start"];
    XVariable *var = [[XVariable alloc] init];
    var.type = startType;
    var.name = [[XName alloc] initWithString:@"Program Loader Initialization String"];
    Instance *inst = [Instance newInstanceForVariable:var projectAnalyzer:self.compiler];
    inst.messageDispatcher = dispatcher;
    //initialization
    [[Stack sharedStack] clear];
    [[Console sharedConsole] clear];
    [[ThreadLockingManager sharedManager] clear];
    
    NSDate *dateStart = [NSDate dateWithTimeIntervalSinceNow:0];
    [inst respondToMethodCallWithName:@"start" andArgumets:nil];
    NSDate *dateEnd = [NSDate dateWithTimeIntervalSinceNow:0];
    [dispatcher dispatchInformationMessage:[NSString stringWithFormat:@"Execution Finished in %f seconds.", [dateEnd timeIntervalSinceDate:dateStart]] sender:self];
}

@end
