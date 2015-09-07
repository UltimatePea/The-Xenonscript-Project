//
//  XSString.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/25/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSString.h"

@implementation XSString

- (instancetype)initWithNSString:(NSString *)nsString;
{
    self = [self init];
    if (self) {
        self.string = [ NSMutableString stringWithString:nsString];
    }
    return self;
}
@end
