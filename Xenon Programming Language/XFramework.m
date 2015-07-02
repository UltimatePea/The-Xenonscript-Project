//
//  XFramework.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XFramework.h"
#import "XClass.h"
#import "XName.h"
#import "NSMutableArray+XSerialization.h"
@implementation XFramework
- (NSMutableArray *)classes
{
    if (!_classes) {
        _classes = [NSMutableArray array];
    }
    return _classes;
}

- (NSMutableArray *)linkedFrameworks
{
    if (!_linkedFrameworks) {
        _linkedFrameworks = [NSMutableArray array];
    }
    return _linkedFrameworks;
}

#define KEY_CLASSES @"classes"
#define KEY_NAME @"name"
- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.classes JSONObject] forKey:KEY_CLASSES];
    [dic setObject:[self.name JSONObject] forKey:KEY_NAME];
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if (self) {
        self.classes = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:KEY_CLASSES] generator:^id(id jsonObjectInTheArray) {
            return [[XClass alloc] initWithJSONObject:jsonObjectInTheArray];
        }];
        self.name = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:KEY_NAME]];
        
    }
    return self;
}
@end
