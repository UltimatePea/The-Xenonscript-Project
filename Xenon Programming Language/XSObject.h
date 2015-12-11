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
/*!
 @class XSObject
 @brief A parent class for all Objects that are in XSKitRuntime, the type of the objectiveCModel property of Instance.h
 @discussion
 @see Instance.h
 */
@interface XSObject : NSObject <XSInterface>

/*!
 *  @author Ultimate Pea, 15-12-05 16:12:58
 *
 *  @brief message dispatcher associated with this XSObject. Lazily instantiated with singleton.
 */
@property (strong, nonatomic) MessageDispatcher *messageDispatcher;
@end
