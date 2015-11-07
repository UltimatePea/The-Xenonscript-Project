//
//  XSInterface.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NativeMethodCall;
@class Instance;

@protocol XSInterface <NSObject>
- (BOOL)canRespondToMethodCall:(NativeMethodCall *)nativeMethodCall;
- (Instance *)respondToNativeMethodCall:(NativeMethodCall *)nativeMethodCall;
- (id)objectiveCModel;

@end
