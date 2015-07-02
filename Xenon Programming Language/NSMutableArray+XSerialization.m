//
//  NSMutableArray+XSerialization.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "NSMutableArray+XSerialization.h"
#import "XSerializationProtocol.h"

@implementation NSMutableArray (XSerialization)

- (id)JSONObject;//object must conform to XSerializationProtocol
{
    NSMutableArray *result = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        [result addObject:[obj JSONObject]];
    }];
    return result;
}

- (instancetype)initWithJSONObject:(id)jsonObject generator:( id (^)( id jsonObjectInTheArray))generator;
{
    self = [self init];
    if (self) {
        NSArray *ary = jsonObject;
        [ary enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
            [self addObject:generator(obj)];
        }];
    }
    return self;
}


@end
