//
//  XType.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XType.h"
#import "XName.h"

@interface XType ()
@property (strong, nonatomic) XName *str;

@end

@implementation XType

- (NSString *)stringRepresentation
{
    return [self.str stringRepresentation];
}

- (instancetype)initWithString:(NSString *)aString
{
    return [self initWithXName:[[XName alloc] initWithString:aString]];
}

- (instancetype)initWithXName:(XName *)name
{
    self = [super init];
    if (self) {
        self.str = name;
    }
    return self;
}


#define STR_REP @"type"
- (id)JSONObject
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[self.str JSONObject] forKey:STR_REP];
    return dic;
}

- (instancetype)initWithJSONObject:(id)jsonObject
{
    return [self initWithXName:[[XName alloc] initWithJSONObject:[jsonObject objectForKey:STR_REP]]];
}



@end
