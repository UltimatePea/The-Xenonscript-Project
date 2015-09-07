//
//  NativeMethodCall.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;

@interface NativeMethodCall : NSObject

@property (nonatomic, strong) NSString *firstStringIdentifier;
@property (nonatomic, strong) NSArray<Instance *> *allArguments;

@end
