//
//  RepositorySelector.h
//  Xenonscript
//
//  Created by Chen Zhibo on 7/31/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

@import Foundation;
@class UIViewController;
@class UAGithubEngine;

@interface RepositorySelector : NSObject

+ (void)startRepositorySelectionWithEngine:(UAGithubEngine *)engine
                            viewController:(UIViewController *)vc
                           completionBlock:(void (^)(NSString *selectedRepositoryName))block;

@end
