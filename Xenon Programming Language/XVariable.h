//
//  XVariable.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSerializationProtocol.h"
@class XName;
@class XType;

@interface XVariable : NSObject <XSerializationProtocol>

@property (strong, nonatomic) XName *name;
@property (strong, nonatomic) XType *type;

@end
