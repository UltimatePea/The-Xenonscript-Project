//
//  ReceivedMessageView.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/8/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ReceivedMessageView.h"

@implementation ReceivedMessageView

- (void)drawRect:(CGRect)rect
{
    NSString *imageTitle;
    switch (self.msgType) {
        case MessageTypeInfo:
            imageTitle = @"Bubble-Gray.png";
            break;
        case MessageTypeWarning:
            imageTitle = @"Bubble-Yellow.png";
            break;
        case MessageTypeErr:
            imageTitle = @"Bubble-Red.png";
            break;
        default:
            imageTitle = @"Bubble-Gray.png";
            break;
    }
    UIImage *background = [[UIImage imageNamed:imageTitle] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 30, 20, 30) resizingMode:UIImageResizingModeTile];
//    background.size = rect.size;
    [background drawInRect:rect];
    
    
}



@end
