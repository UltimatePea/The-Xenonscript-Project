//
//  XSInterface.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NativeMethodCall;

@protocol XSInterface <NSObject>

- (void)respondToNativeMethodCall:(NativeMethodCall *)nativeMethodCall;
- (id)objectiveCModel;

@end
