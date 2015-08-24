//
//  EditAsScriptStringValidator.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/23/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "EditAsScriptStringValidator.h"
#import "Xenon.h"
#import "Line.h"
@interface EditAsScriptStringValidator ()

@property (strong, nonatomic) XClass *productClass;

@end

@implementation EditAsScriptStringValidator

- (XClass *)validateString:(NSMutableString *)string
{
    NSArray *components = [string componentsSeparatedByString:@"\r\n"];
    self.productClass = [[XClass alloc] init];
    [components enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *lineStr = obj;
        Line *line = [[Line alloc] initWithString:lineStr];
        [self analyzeLine:line];
    }];
    return nil;
}

- (void)analyzeLine:(Line *)line
{
    //pattern match
    //matching class
    if ([line isClassDefinition]) {
        
    }
    
}

@end
