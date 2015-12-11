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

/*!
 @protocol XSInterface
 @brief A interface implenmented by XSObject and all its subclasses, used for communication in the XS Runtime
 @discussion XSInterface is an interface that manages the basic and low-level method calls. It manages NativeCallResponse and the return of ObjectiveCModel
 */


@protocol XSInterface <NSObject>

/*!
 @brief whether it can respond to a given native method call
 @discussion Native method call usually sends in a form ==> ClassName-methodCallName <==
 The method call name is directly responded by the class via the invocation of [self perfromSelector].
 Implementations should first ask parent instance (super) whether super can respond, and hands over when super cannot.
 @param nativeMethodCall NativeMethodCall the native method call for the inquiry of ability to respond.
 @return returns YES if the native method call can be handled and NO if it cannot be handled
 */
- (BOOL)canRespondToMethodCall:(NativeMethodCall *)nativeMethodCall;

/*!
 @brief start the execution to respond to a specific native method call
 @discussion prior to the invocation of this method, [inst canRespondToMethodCall:] must be invoked in order to check the availability of the responses
 @param nativeMethodCall the native method call for the execution
 @return instance the result. return [Instance nilInstance] if there is no return value.
 */
- (Instance *)respondToNativeMethodCall:(NativeMethodCall *)nativeMethodCall;

/*!
 @brief returns the operation objectCModel.
 @discussion The objectiveCModel is different from the porperties in the Instance Class property. It is the true objective C model, from various kits and frameworks.
 @return returns the objective C model. (id)
 */
- (id)objectiveCModel;

@end
