//
//  NSArray+PerformSelectorAndAssign.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PerformSelectorAndAssign)

- (instancetype)arrayByReplacingObjectsUsingBlock:(id (^)(id objectInTheArray))block;

@end
