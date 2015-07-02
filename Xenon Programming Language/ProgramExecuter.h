////
////  ProgramExecuter.h
////  Xenon Programming Language
////
////  Created by Chen Zhibo on 6/11/15.
////  Copyright (c) 2015 Chen Zhibo. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//@class XMethodCall;
//@class Instance;
//@class Field;
//@class ProgramExecuter;
//
//typedef enum : NSUInteger {
//    ProgramExecuterOutputMessageTypeNormal,
//    ProgramExecuterOutputMessageTypeWarning,
//    ProgramExecuterOutputMessageTypeError,
//} ProgramExecuterOutputMessageType;
//
//@protocol ProgramExecuterDelegate <NSObject>
//
//
//@required
//- (void)programExecuter:(ProgramExecuter *)executer outputString:(NSString *)string withType:(ProgramExecuterOutputMessageType)messageType;
//- (void)programExecuter:(ProgramExecuter *)executer finishedExecutionWithReturnValue:(id)returnValue;//return value might be nil
//
//@end
//
//
//@interface ProgramExecuter : NSObject
//
//- (instancetype)initWithStartingInstance:(Instance *)startingInstance methodCall:(XMethodCall *)methodCall field:(Field *)field delegate:(id<ProgramExecuterDelegate>)delegate;
//
//- (Instance *)executeForResult;//should not return nil
//
//@end
