//
//  EditAsScriptTextView.h
//  Xenonscript
//
//  Created by Chen Zhibo on 8/23/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XClass;

@interface EditAsScriptTextView : UITextView

@property (strong, nonatomic) XClass *displayingClass;
- (NSString *)stringForClass:(XClass *)xclass;
@end
