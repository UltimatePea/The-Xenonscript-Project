//
//  TypeSelectorTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/30/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "TypeSelectorTableViewController.h"

#import "XFramework.h"
#import "XType.h"
#import "XClass.h"


////test
//
//#import "ProjectTableViewController.h"
@interface TypeSelectorTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TypeSelectorTableViewController


- (NSMutableArray *)getObjects
{
    return [self getTypes:self.inFramework];
}




- (NSMutableArray *)getTypes:(XFramework *)xFramework;
{
    NSMutableArray *types = [NSMutableArray array];
    
    [self analyzeFramework:xFramework newTypeHandler:^(XType *discoveredType) {
        [types addObject:discoveredType];
    }];
    return types;
}

- (void)analyzeFramework:(XFramework *)frameWork newTypeHandler:(void(^)(XType *discoveredType))handler
{
    [frameWork.classes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XClass *cla = obj;
        XType *newType = [[XType alloc] initWithXName:cla.name];
        handler(newType);
    }];
    [frameWork.linkedFrameworks enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self analyzeFramework:obj newTypeHandler:handler];
    }];
}

- (void)searchForText:(NSString *)searchString
{
    [super searchForText:searchString];
    NSMutableArray *searchResult = [NSMutableArray array];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XType *type = obj;
        if (!([[type stringRepresentation] rangeOfString:searchString options:NSCaseInsensitiveSearch].location == NSNotFound)) {
            [searchResult addObject:type];
        }
    }];
    [searchResult addObject:[NSString stringWithFormat:@"Use %@ as a type and leave a warning", searchString]];
    self.arrayToReturnCount = searchResult;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    if ([object isKindOfClass:[XType class]]) {
        return [object stringRepresentation];
    } else if([object isKindOfClass:[NSString class]]) {
        return object;
    } else {
        return nil;
    }
    
}

- (NSString *)reuseID
{
    return @"type";
}

- (BOOL)didSelectObjectInArray:(id)object
{
    if ([object isKindOfClass:[XType class]]) {
        self.completionBlock(object);
    } else {
        self.completionBlock([[XType alloc] initWithString:[self searchBarText]]);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}

@end
