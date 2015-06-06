//
//  MethodsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "MethodsTableViewController.h"
#import "FunctionTableViewController.h"
#import "NewNameTypeTableViewController.h"
#import "XFunction.h"
#import "XName.h"
#import "XType.h"

@implementation MethodsTableViewController

- (void)viewDidLoad
{
    self.arrayToReturnCount = self.displayingMethods;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XFunction *func = object;
    return [func.name stringRepresentation];
}

- (BOOL)didSelectObjectInArray:(id)object
{
    FunctionTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"FunctionTableViewController"];
    ftvc.displayingFunction = object;
    ftvc.title = [self.title stringByAppendingString:[NSString stringWithFormat:@": %@", [ftvc.displayingFunction.name stringRepresentation]]];
    ftvc.inFramework = self.inFramework;
    ftvc.inClass = self.inClass;
    [self.navigationController pushViewController:ftvc animated:YES];
    return YES;
}

- (NSString *)reuseID
{
    return @"method";
}

- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    XFunction *func = object;
    return [func.returnType stringRepresentation];
}

#warning same codes as VariablesTVC - consider add codes to Generic TVC

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
    NewNameTypeTableViewController *nnttvc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NewNameTypeTableViewController"];
    [nnttvc setCompletionBlock:^(XName *name, XType *type) {
        XFunction *func = [[XFunction alloc] init];
        func.returnType = type;
        func.name = name;
        completionBlock(func);
        [self.navigationController popViewControllerAnimated:YES];
        
#warning dependencies should be declared by initializer
    }];
    nnttvc.searchingFramework = self.inFramework;
    [self.navigationController pushViewController:nnttvc animated:YES];
}

@end
