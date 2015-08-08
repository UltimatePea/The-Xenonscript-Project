//
//  ConsoleDelegate.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>


@class Console;
@class ConsoleEntry;


@protocol ConsoleDelegate <NSObject>

- (void)console:(Console *)consle didAppendEntry:(ConsoleEntry *)entry;

@end
