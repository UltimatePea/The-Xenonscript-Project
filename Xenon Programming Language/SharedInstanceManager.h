//
//  SharedInstanceManager.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/13/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;

@interface SharedInstanceManager : NSObject

- (Instance *)sharedInstanceForTypeName:(NSString *)typeName;

@end
