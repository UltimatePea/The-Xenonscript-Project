//
//  FrameworkManager.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/2/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "FrameworkManager.h"

@implementation FrameworkManager

+ (instancetype)sharedFrameworkManager
{
    static FrameworkManager *sharedManger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManger = [[self alloc] init];
    });
    return sharedManger;
}

@end
