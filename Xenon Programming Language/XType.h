//
//  XType.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSerializationProtocol.h"
@class XName;
@interface XType : NSObject <XSerializationProtocol>

- (NSString *)stringRepresentation;
- (instancetype)initWithString:(NSString *)aString;
- (instancetype)initWithXName:(XName *)name;
@end
