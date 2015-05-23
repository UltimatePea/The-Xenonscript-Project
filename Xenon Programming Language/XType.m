//
//  XType.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XType.h"

@interface XType ()
@property (strong, nonatomic) NSString *str;

@end

@implementation XType

- (NSString *)stringRepresentation
{
    return self.str;
}

- (instancetype)initWithString:(NSString *)aString
{
    self = [super init];
    if (self) {
        self.str = aString;
    }
    return self;
}
@end
