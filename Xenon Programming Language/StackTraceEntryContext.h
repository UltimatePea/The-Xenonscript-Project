//
//  StackTraceEntryContext.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/11/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFunction;
@class XMethodCall;
@class Instance;
@interface StackTraceEntryContext : NSObject

@property (strong, nonatomic) XFunction *inFunction;
@property (strong, nonatomic) XMethodCall *showingMethodCall;
@property (strong, nonatomic) Instance *instance;
@end
