//
//  FlexibleSpaceBarItem.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "FlexibleSpaceBarItem.h"

@implementation FlexibleSpaceBarItem

+ (instancetype)flexibleSpaceBarItem
{
    return [[FlexibleSpaceBarItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}


@end
