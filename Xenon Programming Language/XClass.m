//
//  XClass.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XClass.h"
#import "NSMutableArray+XSerialization.h"
#import "XProperty.h"
#import "XFunction.h"
#import "XName.h"
#import "XType.h"
@implementation XClass

- (NSMutableArray *)properties
{
    if (!_properties) {
        _properties = [[NSMutableArray alloc] init];
    }
    return _properties;
}

- (NSMutableArray *)methods
{
    if (!_methods) {
        _methods = [[NSMutableArray alloc] init];
    }
    return _methods;
}
#define PROPERTIES_KEY @"properties"
#define METHODS_KEY @"methods"
#define NAME_KEY @"name"
#define BASE_TYPE_KEY @"baseClass"
- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.properties JSONObject] forKey:PROPERTIES_KEY];
    [dic setObject:[self.methods JSONObject] forKey:METHODS_KEY];
    [dic setObject:[self.name JSONObject] forKey:NAME_KEY];
    [dic setObject:[self.baseClass JSONObject] forKey:BASE_TYPE_KEY];
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if (self) {
        self.properties = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:PROPERTIES_KEY] generator:^id(id jsonObjectInTheArray) {
            return [[XProperty alloc] initWithJSONObject:jsonObject];
#warning name-spacing
        }];
        self.methods = [[NSMutableArray alloc] initWithJSONObject:[jsonObject objectForKey:METHODS_KEY] generator:^id(id jsonObjectInTheArray) {
            return [[XFunction alloc] initWithJSONObject:jsonObject];
        }];
        self.name = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:NAME_KEY]];
        self.baseClass = [[XType alloc] initWithJSONObject:[jsonObject objectForKey:BASE_TYPE_KEY]];
    }
    return self;
}

@end
