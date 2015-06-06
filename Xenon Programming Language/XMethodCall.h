//
//  XMethodCall.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XName;
#define INSTANCE_STRING_REP_NIL @""
@interface XMethodCall : NSObject
//one of instance must be defined
@property (strong, nonatomic) XName *instanceName, *functionName;
@property (strong, nonatomic) XMethodCall *instanceMethodCall;
@property (strong, nonatomic) NSMutableArray *arguments;//of type MethodCall or XName

@property (strong, nonatomic, readonly) NSString *stringRepresentation;
@property (strong, nonatomic, readonly) NSString *instanceStringRepresentation;
@end
