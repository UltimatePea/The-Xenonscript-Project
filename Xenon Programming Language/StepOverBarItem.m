//
//  StepOverBarItem.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "StepOverBarItem.h"

@implementation StepOverBarItem

- (void)stepOver
{
    
}

- (instancetype)initWithDefaultConfiguration
{
    return self = [super initWithTitle:@"➡️" style:UIBarButtonItemStylePlain target:self action:@selector(stepOver)];
}

+ (instancetype)stepOverBarItem
{
    return [[StepOverBarItem alloc] initWithDefaultConfiguration];
}

@end
