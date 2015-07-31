//
//  XFramework.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XName;
#import "XSerializationProtocol.h"

@interface XFramework : NSObject <XSerializationProtocol>
@property (strong, nonatomic) XName *name;
@property (strong, nonatomic) NSMutableArray *classes;//of Type XClass
@property (strong, nonatomic) NSMutableArray *linkedFrameworks;
//dependency: Framework Mianager
@end
