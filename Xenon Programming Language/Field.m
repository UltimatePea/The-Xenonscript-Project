//
//  Field.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/11/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "Field.h"
#import "Instance.h"

@interface Field ()


@property (strong, nonatomic) NSMutableArray *subFields;
@property (strong, nonatomic) NSMutableArray *instances;

@end


@implementation Field

- (NSMutableArray *)instances
{
    if (!_instances) {
        _instances = [NSMutableArray array];
    }
    return _instances;
}
- (void)addInstance:(Instance *)instance
{
    [self.instances addObject:instance];
}

- (NSArray<Instance *> *)instancesForName:(NSString *)name
{
    NSMutableArray *result = [NSMutableArray array];
    [self.instances enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        Instance *inst = obj;
        if ([inst.name isEqualToString:name]) {
            [result addObject:obj];
        }
    }];
    [result addObjectsFromArray:[self.inInstance.baseInstance.field instancesForName:name]];
    return result;
}




@end
