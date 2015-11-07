//
//  XSObject.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XSInterface.h"
@class MessageDispatcher;
@interface XSObject : NSObject <XSInterface>
@property (strong, nonatomic) MessageDispatcher *messageDispatcher;
@end
