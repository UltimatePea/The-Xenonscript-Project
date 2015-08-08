//
//  DebugProgramControllToolbar.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/7/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "DebugProgramControllToolbar.h"

#import "PauseBarItem.h"
#import "PlayBarItem.h"
#import "StepOverBarItem.h"
#import "StepInBarItem.h"
#import "FlexibleSpaceBarItem.h"
@implementation DebugProgramControllToolbar

+ (instancetype)sharedToolbar;
{
    static DebugProgramControllToolbar *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.items =
    @[
      [PauseBarItem pauseBarItem],
      [FlexibleSpaceBarItem flexibleSpaceBarItem],
      [PlayBarItem playBarItem],
      [FlexibleSpaceBarItem flexibleSpaceBarItem],
      [StepOverBarItem stepOverBarItem],
      [FlexibleSpaceBarItem flexibleSpaceBarItem],
      [StepInBarItem stepInBarItem]
      
      ];
}




@end
