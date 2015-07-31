//
//  QuickStorage.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/30/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickStorage : NSObject

+ (void)storeObject:(id)object forKey:(NSString *)key;
+ (id)objectForKey:(NSString *)key;
+ (BOOL)isObjectStoredWithKey:(NSString *)key;
+ (void)deleteObjectForKey:(NSString *)key;
@end
