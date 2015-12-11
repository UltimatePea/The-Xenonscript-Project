//
//  XSMathOperation.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/25/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XSBoolean;

@class XSNumber;


/*!
 *  @author Ultimate Pea, 15-12-05 17:12:03
 *
 *  @brief Defines basic Math operations that number classes should implement
 */
@protocol XSMathOperation <NSObject>

- (void)add:(XSNumber *)number;
- (XSNumber *)numberAddedByNumber:(XSNumber *)number;

- (void)subtract:(NSNumber *)number;
- (XSNumber *)numberSubtractedByNumber:(XSNumber *)number;

- (void)multiply:(NSNumber *)number;
- (XSNumber *)numberMultipliedByNumber:(XSNumber *)number;

- (void)divide:(NSNumber *)number;
- (XSNumber *)numberDividedByNumber:(XSNumber *)number;

- (XSBoolean *)isEqualToNumber:(XSNumber *)number;

@end
