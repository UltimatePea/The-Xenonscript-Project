//
//  ProgramExecuter.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/7/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XProject;
@class ProgramLoader;

/*!
 *  @author Ultimate Pea, 15-12-11 19:12:46
 *
 *  @brief The delegate should implement this delegate in order to receive output string from the program loader and program executer. However, program should also listen to the notification center for out putstring from MessageDispatcher
 */
@protocol ProgramLoaderDelegate <NSObject>

@required
/*!
 *  @author Ultimate Pea, 15-12-11 19:12:55
 *
 *  @brief this method is called when
 *
 *  @param loader the sender of the method call, the delegator
 *  @param string the string to be printed onto the screen
 */
- (void)programLoader:(ProgramLoader *)loader outputString:(NSString *)string;

@end

/*!
 @class ProgramLoader
 @brief Reponsible for loading the program, (looking for Start class, create instance and execute start method, )
 @discussion You should first initialize the Program Loader with a project. And then, invoke start method.
 @code [[[ProgramLoader alloc] initWithProject:xProject delegate:self] start];
 */
@interface ProgramLoader : NSObject

/*!
 *  @author Ultimate Pea, 15-12-11 20:12:35
 *
 *  @brief Initialize the loader with a xproject
 *
 *  @param project         the xproject that the loader is responsible for loading
 *  @param programDelegate the delegate implementing ProgramLoaderDelegate protocol
 *
 *  @return instancetype
 */
- (instancetype)initWithProject:(XProject *)project delegate:(id<ProgramLoaderDelegate>)programDelegate;

/*!
 *  @author Ultimate Pea, 15-12-11 20:12:53
 *
 *  @brief start the program execution
 */
- (void)start;

@end
