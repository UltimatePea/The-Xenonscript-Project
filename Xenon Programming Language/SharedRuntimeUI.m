//
//  SharedRuntimeUI.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/9/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "SharedRuntimeUI.h"

@implementation SharedRuntimeUI


+ (instancetype)sharedRuntimeUI;
{
    static SharedRuntimeUI *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SharedRuntimeUI alloc] init];
    });
    return sharedInstance;
}

@end
