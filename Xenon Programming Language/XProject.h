//
//  XProject.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XFramework.h"
#import "XSerializationProtocol.h"

@interface XProject : XFramework <XSerializationProtocol>
@property (strong, nonatomic) NSURL *savingURL;
- (void)saveToURL:(NSURL *)url;
- (instancetype)initWithURL:(NSURL *)url;
- (void)save;

@end
