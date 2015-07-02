//
//  XVariable.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XVariable.h"
#import "XName.h"
#import "XType.h"

@implementation XVariable
#define NAME_KEY @"name"
#define TYPE_KEY @"type"
- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.name JSONObject] forKey:NAME_KEY];\
    if (self.type) {
        [dic setObject:[self.type JSONObject] forKey:TYPE_KEY];
    }
    
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    self = [super init];
    if (self) {
        self.name = [[XName alloc] initWithJSONObject:[jsonObject objectForKey:NAME_KEY]];
        if ([jsonObject objectForKey:TYPE_KEY]) {
            self.type = [[XType alloc] initWithJSONObject:[jsonObject objectForKey:TYPE_KEY]];
        }  
        
    }
    return self;
}

@end
