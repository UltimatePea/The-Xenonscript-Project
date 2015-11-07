//
//  NativeMethodCall.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;
@class XSString;

@interface NativeMethodCall : NSObject

@property (nonatomic, strong) NSString *firstStringIdentifier;// "CLASSNAME-CALLID" "XSObject-assignObjCObject", the first element of arguments
@property (strong, nonatomic) Instance *sendingInstance;
@property (nonatomic, strong) NSArray<Instance *> *allArguments;

@end
