//
//  MethodCallsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "MethodCallsTableViewController.h"
#import "MethodCallTableViewController.h"
#import "NewMethodCallTableViewController.h"
#import "XMethodCall.h"
#import "XName.h"

@implementation MethodCallsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.arrayToReturnCount = self.displayingMethodCalls;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XMethodCall *mc = object;
    return mc.stringRepresentation;
}

- (BOOL)didSelectObjectInArray:(id)object;//return NO if you want to deselect
{
    MethodCallTableViewController *mctvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodCallTableViewController"];
    mctvc.displayingMethodCall = object;
    mctvc.inFramework = self.inFramework;
    mctvc.inClass = self.inClass;
    mctvc.inFunction = self.inFunction;
    [self.navigationController pushViewController:mctvc animated:YES];
    return YES;
}
- (NSString *)reuseID
{
    return @"methodCall";
}

//optional
//- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object;
- (BOOL)canEditTable
{
    return YES;
}

- (BOOL)canAddItem
{
    return YES;
}

- (void)addNewItem:(void (^)(id addedItem))completionBlock
{
    NewMethodCallTableViewController *nmctvc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NewMethodCallTableViewController"];
    [nmctvc setCompletionBlock:^(XMethodCall *newMethodCall) {
        completionBlock(newMethodCall);
        [self.navigationController popViewControllerAnimated:YES];
        
#warning dependencies should be declared by initializer
    }];
    nmctvc.inFramework = self.inFramework;
    nmctvc.inFunction = self.inFunction;
    nmctvc.inClass = self.inClass;
    [self.navigationController pushViewController:nmctvc animated:YES];
}

@end
