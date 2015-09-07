//
//  XSXFunction.m
//  Xenonscript
//
//  Created by Chen Zhibo on 9/7/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSXFunction.h"

@implementation XSXFunction

+ (instancetype)instanceWithXFunction:(XFunction *)function;
{
    return [[XSXFunction alloc] initWithXFunction:function];
}

- (instancetype)initWithXFunction:(XFunction *)function
{
    self = [self init];
    if (self) {
        self.function = function;
    }
    return self;
}

@end
