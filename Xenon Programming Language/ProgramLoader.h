//
//  ProgramExecuter.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/7/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XProject;
@class ProgramLoader;


@protocol ProgramLoaderDelegate <NSObject>

@required
- (void)programLoader:(ProgramLoader *)loader outputString:(NSString *)string;

@end


@interface ProgramLoader : NSObject

- (instancetype)initWithProject:(XProject *)project delegate:(id<ProgramLoaderDelegate>)programDelegate;
- (void)start;

@end
