//
//  XSString.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/25/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "XSObject.h"
/*!
 *  @author Ultimate Pea, 15-12-05 16:12:29
 *
 *  @brief Mirror Type of NSMutableString
 */
@interface XSString : XSObject

/*!
 *  @author Ultimate Pea, 15-12-05 16:12:09
 *
 *  @brief the nsstring that is mirroring.
 */
@property (strong, nonatomic) NSMutableString *string;

/*!
 *  @author Ultimate Pea, 15-12-05 16:12:07
 *
 *  @brief initial lize
 *
 *  @param nsString NSString
 *
 *  @return a initialized XSString Object
 */
- (instancetype)initWithNSString:(NSString *)nsString;

@end
