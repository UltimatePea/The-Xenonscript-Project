//
//  Line.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/23/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "Line.h"

@interface Line ()



@end

@implementation Line


- (instancetype)initWithString:(NSString *)string
{
    self = [super init];
    if (self) {
        self.string = string;
    }
    return self;
}
- (BOOL)isClassDefinition;
{
    return [self isLineClassDefinition:self.string];
}

- (BOOL)isClassDefinitionValid;
{
    return [self isPattern:@"class .+ extends [a-zA-Z0-9 ]+" foundInString:self.string];
}

- (BOOL)isLineClassDefinition:(NSString *)line
{
    return [self isPattern:@"class" foundInString:line];
}

- (BOOL)isPattern:(NSString *)pattern foundInString:(NSString *)string
{
    return [self checkRangeVadility:[self patternMatchRegex:pattern withString:string]];
}

- (BOOL)checkRangeVadility:(NSRange)range
{
    if (range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

- (NSRange)patternMatchRegex:(NSString *)regex withString:(NSString *)string
{
    return [string rangeOfString:regex options:NSRegularExpressionSearch];
}


@end
