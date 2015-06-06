//
//  XFunction.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XFunction.h"
#import "XName.h"

@implementation XFunction

- (instancetype)init
{
    if (self = [super init]) {
        self.parameters = [[NSMutableArray alloc] init];
        self.methodCalls = [[NSMutableArray alloc] init];;
        self.localVariables = [[NSMutableArray alloc] init];
        self.localFunctions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString *)stringRepresentation
{
    return self.name.stringRepresentation;
}

@end
