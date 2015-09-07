//
//  XSXFunction.h
//  Xenonscript
//
//  Created by Chen Zhibo on 9/7/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSObject.h"
@class XFunction;
/*!
 @class XSXFunction
 @brief: XSXFunction represents the runtime instance of function instances as class properties
 @discussion: this method may only be called by the runtime Edited at @September 7
 */
@interface XSXFunction : XSObject

@property (strong, nonatomic) XFunction *function;
+ (instancetype)instanceWithXFunction:(XFunction *)function;
@end
