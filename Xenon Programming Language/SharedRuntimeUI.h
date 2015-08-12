//
//  SharedRuntimeUI.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/9/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;
@interface SharedRuntimeUI : NSObject

+ (instancetype)sharedRuntimeUI;
@property (strong, nonatomic) UIViewController *sharedViewController;

@end
