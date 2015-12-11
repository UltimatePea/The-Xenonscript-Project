//
//  XSObject.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSObject.h"
#import "Instance.h"
#import "NativeMethodCall.h"
#import "MessageDispatcher.h"
#import "XSString.h"
@interface XSObject ()

@property (strong, nonatomic) NSObject *object;

@end

@implementation XSObject

- (id)objectiveCModel
{
    return self.object;
}

- (MessageDispatcher *)messageDispatcher
{
    if (!_messageDispatcher) {
        _messageDispatcher = [MessageDispatcher sharedMessgeDispatcher];
    }
    return _messageDispatcher;
}

//parents should call super if they cannot handle
- (Instance *)respondToNativeMethodCall:(NativeMethodCall *)nativeMethodCall
{
    NSString *methodCallName = [[nativeMethodCall.firstStringIdentifier componentsSeparatedByString:@"-"] objectAtIndex:1];
    SEL selector = NSSelectorFromString(methodCallName);
    if ([self respondsToSelector:selector]) {
        ////using conventional approach
        
        return [self performSelector:selector withObject:nativeMethodCall];
        
        
        ////using invocaton approach
//        NSInvocation *invoc = [NSInvocation invocationWithMethodSignature:[[self class] methodSignatureForSelector:selector]];
//        [invoc setTarget:self];
//        [invoc setSelector:selector];
//        for (int i = 0; i < nativeMethodCall.allArguments.count; i ++) {
//            Instance *argument = nativeMethodCall.allArguments[i];
//            [invoc setArgument:&argument atIndex:i + 2];
//        }
//        Instance * returnValue;
//        [invoc setReturnValue:&returnValue];
//        [invoc invoke];
//        return returnValue;
    } else {
        [self.messageDispatcher dispatchErrorMessage:[NSString stringWithFormat:@"Cannot respond to Native Method Call. %@", nativeMethodCall.firstStringIdentifier] sender:self];
    }
    return [Instance nilInstance];
}

- (Instance *)print:(NativeMethodCall *)nativeMethodCall
{
    Instance *strInst =  nativeMethodCall.allArguments[1];
    NSString *strToPrint = [strInst.objectiveCModel isKindOfClass:[XSString class]]?((XSString *)strInst.objectiveCModel).string:strInst.objectiveCModel.description;
    [self.messageDispatcher dispatchInformationMessage:strToPrint sender:self];
    return [Instance nilInstance];
}

- (Instance *)xsreturn:(NativeMethodCall *)nativeMethodCall
{
    Instance *returnInst = nativeMethodCall.allArguments[1];
    [nativeMethodCall.sendingInstance.baseInstance.baseInstance returnObject:returnInst];
    return [Instance nilInstance];
}

- (Instance *)assignXSTypedObjectToInstance:(NativeMethodCall *)nativeMethodCall // second string class name
{
    Instance *strInst = nativeMethodCall.allArguments[1];
    NSString *classname = ((XSString *) strInst.objectiveCModel).string;
    nativeMethodCall.sendingInstance.objectiveCModel = [[NSClassFromString(classname) alloc] init];
    return [Instance nilInstance];
}

- (Instance *)assignInstanceToInstance:(NativeMethodCall *)nativeMethodCall
{
    Instance *instanceWhoseValueUsedToAssign = nativeMethodCall.allArguments[1];
    [nativeMethodCall.sendingInstance assign:instanceWhoseValueUsedToAssign];
    return [Instance nilInstance];
}

- (BOOL)canRespondToMethodCall:(NativeMethodCall *)nativeMethodCall
{
    /**
     default implementation:
     
     */
    
    return [[nativeMethodCall.firstStringIdentifier componentsSeparatedByString:@"-"].firstObject isEqualToString:@"XSObject"];
    
    
}


@end
