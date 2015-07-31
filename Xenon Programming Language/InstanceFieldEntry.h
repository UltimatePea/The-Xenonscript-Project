//
//  InstanceFieldEntry.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/5/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Instance;


@interface InstanceFieldEntry : NSObject

@property (strong, nonatomic) Instance *containingInstance;
@property (strong, nonatomic) NSString *name;

- (instancetype)initWithInstance:(Instance *)instance;
- (instancetype)initWithInstance:(Instance *)instance name:(NSString *)name;

@end
