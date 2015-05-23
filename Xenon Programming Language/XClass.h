//
//  XClass.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XName;

@interface XClass : NSObject

@property (strong, nonatomic) XName *name;
@property (strong, nonatomic) NSArray *properties;//of Type XProperty
@property (strong, nonatomic) NSArray *methods;//of Type XFunction

@end
