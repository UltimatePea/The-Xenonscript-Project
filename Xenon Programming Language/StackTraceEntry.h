//
//  StackTraceName.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/2/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;
@class XMethodCall;

@interface StackTraceEntry : NSObject

@property (strong, nonatomic) NSString *className, *callingMethodName;
@property (strong, nonatomic) Instance *creatingInstance;
@property (strong, nonatomic) XMethodCall *methodCall;

@end
