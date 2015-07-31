//
//  NSArray+PerformSelectorAndAssign.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "NSArray+PerformSelectorAndAssign.h"

@implementation NSArray (PerformSelectorAndAssign)
- (instancetype)arrayByReplacingObjectsUsingBlock:(id (^)(id objectInTheArray))block
{
    NSMutableArray *array = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [array addObject:block(obj)];
    }];
    return array;
}
@end
