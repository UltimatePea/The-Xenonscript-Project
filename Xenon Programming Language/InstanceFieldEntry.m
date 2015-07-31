//
//  InstanceFieldEntry.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/5/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "InstanceFieldEntry.h"
#import "Instance.h"

@implementation InstanceFieldEntry
- (instancetype)initWithInstance:(Instance *)instance
{
    return [self initWithInstance:instance name:instance.name];
}
- (instancetype)initWithInstance:(Instance *)instance name:(NSString *)name
{
    self = [self init];
    if (self) {
        self.containingInstance = instance;
        self.name = name;
    }
    return self;
}
@end
