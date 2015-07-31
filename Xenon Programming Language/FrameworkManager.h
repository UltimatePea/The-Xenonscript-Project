//
//  FrameworkManager.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/2/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XFramework;

@interface FrameworkManager : NSObject


- (XFramework *)frameworkForName:(NSString *)name;
+ (instancetype)sharedFrameworkManager;
@end
