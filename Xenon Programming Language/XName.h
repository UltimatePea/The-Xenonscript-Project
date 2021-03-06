//
//  XName.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSerializationProtocol.h"

@interface XName : NSObject <XSerializationProtocol>
@property (strong, readonly) NSString *stringRepresentation;
- (NSString *)stringRepresentation;
- (instancetype)initWithString:(NSString *)aString;
@end
