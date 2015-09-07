//
//  XSString.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/25/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSObject.h"

@interface XSString : XSObject

@property (strong, nonatomic) NSMutableString *string;

- (instancetype)initWithNSString:(NSString *)nsString;

@end
