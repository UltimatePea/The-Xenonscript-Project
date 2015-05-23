//
//  XMethodCall.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XName;

@interface XMethodCall : NSObject

@property (strong, nonatomic) XName *instanceName, *functionName;
@property (strong, nonatomic) NSArray *argumentNames;

@end
