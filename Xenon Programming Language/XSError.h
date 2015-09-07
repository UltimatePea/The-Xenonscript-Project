//
//  XSError.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/25/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSObject.h"

@interface XSError : XSObject

@property (strong, nonatomic) NSError *error;

@end
