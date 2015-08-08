//
//  StepInBarItem.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "StepInBarItem.h"

@implementation StepInBarItem

+ (instancetype)stepInBarItem
{
    return [[StepInBarItem alloc] initWithDefaultConfiguration];
}

- (void)stepIn
{
    
}

- (instancetype)initWithDefaultConfiguration
{
    return self = [super initWithTitle:@"⤵️" style:UIBarButtonItemStylePlain target:self action:@selector(stepIn)];
}

@end
