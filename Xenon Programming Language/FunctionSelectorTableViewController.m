//
//  FunctionSelectorTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/4/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "FunctionSelectorTableViewController.h"
#import "XClass.h"
#import "XType.h"
#import "XFramework.h"
#import "XFunction.h"
#import "XName.h"

@implementation FunctionSelectorTableViewController

- (NSMutableArray *)getObjects
{
    NSMutableArray *result = [NSMutableArray array];
    [self.inFunction.localFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:obj];
    }];
    [self analyzeClass:self.inClass discoveredFunction:^(XFunction *function) {
        [result addObject:function];
    }];
    [self analyzeFramework:self.inFramework discoveredFunction:^(XFunction *function) {
        [result addObject:function];
    }];
    return result;
    
}



- (void)analyzeFramework:(XFramework *)framwork discoveredFunction:(void (^)(XFunction *function))block
{
    [framwork.classes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isEqual:self.inClass]) {
            return;
        }
        [self analyzeClass:obj discoveredFunction:block];
    }];
    [framwork.linkedFrameworks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self analyzeFramework:obj discoveredFunction:block];
    }];
    
}
- (void)analyzeClass:(XClass *)class discoveredFunction:(void (^)(XFunction *function))block
{
    [class.methods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[XFunction class]]) {
            block(obj);
        }
    }];
}

     

- (void)searchForText:(NSString *)searchString
{
    [super searchForText:searchString];
    NSMutableArray *searchResult = [NSMutableArray array];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XFunction *function = obj;
        if (!([[function stringRepresentation] rangeOfString:searchString options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            [searchResult addObject:function];
        }
    }];
    [searchResult addObject:[NSString stringWithFormat:@"Use %@ as a function and leave a warning", searchString]];
    self.arrayToReturnCount = searchResult;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    if ([object isKindOfClass:[XFunction class]]) {
        XFunction *func = object;
        return func.stringRepresentation;
    } else if([object isKindOfClass:[NSString class]]){
        return object;
    }
    return nil;
}

- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    if ([object isKindOfClass:[XFunction class]]) {
        XFunction *func = object;
        return func.returnType.stringRepresentation;
    } else if ([object isKindOfClass:[NSString class]]){
        return nil;
    }
    return nil;
}

- (NSString *)reuseID
{
    return @"function";
}

- (BOOL)didSelectObjectInArray:(id)object
{
    
    self.completionBlock([object isKindOfClass:[XFunction class]]?((XFunction *) object).name:[[XName alloc] initWithString:[self searchBarText]]);
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

@end
