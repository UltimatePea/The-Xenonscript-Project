//
//  Line.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/23/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject
@property (strong, nonatomic) NSString *string;
- (instancetype)initWithString:(NSString *)string;
- (BOOL)isClassDefinition;
- (BOOL)isClassDefinitionValid;
- (BOOL)isLineClassDefinition:(NSString *)line;
- (BOOL)isPattern:(NSString *)pattern foundInString:(NSString *)string;
- (BOOL)checkRangeVadility:(NSRange)range;
- (NSRange)patternMatchRegex:(NSString *)regex withString:(NSString *)string;
@end
