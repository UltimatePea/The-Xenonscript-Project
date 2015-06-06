//
//  NameSelectorTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "NameSelectorTableViewController.h"
#import "XClass.h"
#import "XProperty.h"
#import "XType.h"
#import "XFunction.h"
#import "XLocalVariable.h"
#import "XName.h"
#import "XParameter.h"

#define X_TYPE_STRING @"String"
#define X_TYPE_FUNCTION @"Function"

@implementation NameSelectorTableViewController

- (NSMutableArray *)getObjects
{
    NSMutableArray *result = [NSMutableArray array];
    [self.inClass.properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XProperty *property = obj;
        [result addObject:property];
    }];
    [self.inFunction.localVariables enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XLocalVariable *lv = obj;
        [result addObject:lv];
    }];
    [self.inFunction.parameters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XParameter *param = obj;
        [result addObject:param];
    }];
    [self.inFunction.localFunctions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XFunction *func = obj;
        [result addObject:func];
    }];
    [self.inClass.methods enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        XFunction *func = obj;
        [result addObject:func];
    }];
    return result;
}

- (void)searchForText:(NSString *)searchString
{
    [super searchForText:searchString];
    NSMutableArray *searchResult = [NSMutableArray array];
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if([obj isKindOfClass:[XVariable class]]){
            XVariable *var = obj;
            XName *name = var.name;
            if (([[name stringRepresentation] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)) {
                [searchResult addObject:var];
            }
        } else if ([obj isKindOfClass:[XFunction class]]){
            XFunction *func = obj;
            XName *name = func.name;
            if (([[name stringRepresentation] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound)) {
                [searchResult addObject:func];
            }
#warning code duplicaton above
        } else
        {
            return;
        }
        
    }];
    [searchResult addObject:[NSString stringWithFormat:@"Use %@ as a name and leave a warning", searchString]];
    self.arrayToReturnCount = searchResult;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    if ([object isKindOfClass:[XName class]]) {
        return [object stringRepresentation];
    } else if([object isKindOfClass:[NSString class]]) {
        return object;
    } else if([object isKindOfClass:[XVariable class]]){
        XVariable *var = object;
        return var.name.stringRepresentation;
    } else if([object isKindOfClass:[XFunction class]]){
        XFunction *func = object;
        return func.name.stringRepresentation;
    } else {
        return nil;
    }
}

- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    if ([object isKindOfClass:[XName class]]) {
        return [object stringRepresentation];
    } else if([object isKindOfClass:[NSString class]]) {
        return X_TYPE_STRING;
    } else if([object isKindOfClass:[XVariable class]]){
        XVariable *var = object;
        return var.type.stringRepresentation;
    } else if([object isKindOfClass:[XFunction class]]){
        XFunction *func = object;
        return X_TYPE_FUNCTION;
    } else {
        return nil;
    }
}

- (NSString *)reuseID
{
    return @"name";
}

- (BOOL)didSelectObjectInArray:(id)object
{
    if ([object isKindOfClass:[XVariable class]]) {
        self.completionBlock(((XVariable *) object).name);
    } else if([object isKindOfClass:[NSString class]]){
        self.completionBlock([[XName alloc] initWithString:[self searchBarText]]);
    } else if([object isKindOfClass:[XFunction class]]){
        self.completionBlock(((XFunction *) object).name);
        
        }
    else {
        return NO;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    return YES;
}


@end
