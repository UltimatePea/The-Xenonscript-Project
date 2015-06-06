//
//  VariablesTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/23/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "VariablesTableViewController.h"
#import "NewNameTypeTableViewController.h"
#import "XVariable.h"
#import "XName.h"
#import "XType.h"


@implementation VariablesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)setDisplayingVariables:(NSMutableArray *)displayingVariables
{
    _displayingVariables = displayingVariables;
    self.arrayToReturnCount = displayingVariables;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XVariable *variable = object;
    return [variable.name stringRepresentation];
}

- (BOOL)didSelectObjectInArray:(id)object
{
    return NO;
}



- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    XVariable *variable = object;
    return [variable.type stringRepresentation];
}


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
        completionBlock([self instanceForName:name andType:type]);
        [self.navigationController popViewControllerAnimated:YES];
        
#warning dependencies should be declared by initializer
    }];
    nnttvc.searchingFramework = self.inFramework;
    [self.navigationController pushViewController:nnttvc animated:YES];
}


@end
