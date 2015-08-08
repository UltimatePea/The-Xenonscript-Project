////
////  ConsoleAlertViewController.m
////  Xenon Programming Language
////
////  Created by Chen Zhibo on 7/4/15.
////  Copyright © 2015 Chen Zhibo. All rights reserved.
////
//
//#import "ConsoleAlertViewController.h"
//#import "MessageDispatcher.h"
//#import "MessageType.h"
//
//
//@interface ConsoleAlertViewController ()
//
//@property (strong, nonatomic) NSNotificationCenter *notificationCenter;
//@property (nonatomic) BOOL firstStatement;
//@end
//
//@implementation ConsoleAlertViewController
//
//
//
//- (NSNotificationCenter *)notificationCenter
//{
//    if (!_notificationCenter) {
//        _notificationCenter = [NSNotificationCenter defaultCenter];
//    }
//    return _notificationCenter;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    
//    //set up alert
//    
////    [self addTextFieldWithConfigurationHandler:^(UITextField * __nonnull textField) {
////        
////    }];
//    
//    UIAlertAction *quit = [UIAlertAction actionWithTitle:@"Quit" style:UIAlertActionStyleCancel handler:^(UIAlertAction * __nonnull action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [self addAction:quit];
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    //set up notifications
//    __weak ConsoleAlertViewController *weakSelf = self;
//    [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_INFORMATION_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
//        [weakSelf printMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeInfo];
//    }];
//    [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_WARNING_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
//        [weakSelf printMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeWarning];
//    }];
//    [self.notificationCenter addObserverForName:NOTIFICATION_CENTER_ERROR_FLAG object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
//        [weakSelf printMessage:note.userInfo[USER_INFO_KEY_MSG] withType:MessageTypeErr];
//    }];
//#warning SERIOUS no remove notif retain cycle
//    
//    
//}
//
//- (void)printMessage:(NSString *)msg withType:(int)type
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (self.firstStatement) {
//            self.firstStatement = false;
//        } else {
//            [self addStringToMessage:@"\r\n\r\n"];
//        }
//        
//        switch (type) {
//            case MessageTypeInfo:
//                [self addStringToMessage:@"😅"];
//                break;
//            case MessageTypeWarning:
//                [self addStringToMessage:@"😰"];
//                break;
//            case MessageTypeErr:
//                [self addStringToMessage:@"😱"];
//                break;
//            default:
//                break;
//        }
//        [self addStringToMessage:@"\r\n"];
//        [self addStringToMessage:msg];
//    });
//    
//}
//
//- (void)addStringToMessage:(NSString *)str
//{
//    self.message = [self.message stringByAppendingString:str];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (void)dealloc
//{
//    NSLog(@"ALERT DEALLOCED");
//}
//
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/
//
//@end
