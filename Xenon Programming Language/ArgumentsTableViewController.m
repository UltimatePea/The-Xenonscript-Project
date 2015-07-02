//
//  ArgumentsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/29/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ArgumentsTableViewController.h"
#import "MethodCallTableViewController.h"
#import "NameSelectorTableViewController.h"
#import "NewMethodCallTableViewController.h"
#import "XArgument.h"
#import "XMethodCall.h"
#import "XName.h"
#import "XType.h"
#import "UserPrompter.h"

@implementation ArgumentsTableViewController


- (void)setDisplayingArguments:(NSMutableArray *)displayingArguments
{
    _displayingArguments = displayingArguments;
    self.displayingVariables = displayingArguments;
}

- (NSString *)reuseID
{
    return @"argument";
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    if ([object isKindOfClass:[XArgument class]]) {
        return [super titleLabelForObjectInArray:object];
    } else if ([object isKindOfClass:[XMethodCall class]]){
        return ((XMethodCall *) object).stringRepresentation;
    } else if ([object isKindOfClass:[NSString class]]){
        return [NSString stringWithFormat:@"\"%@\"", object];
    }
    return nil;
}

- (BOOL)didSelectObjectInArray:(id)object
{
    if ([object isKindOfClass:[XArgument class]]) {
        return [super didSelectObjectInArray:object];
    } else if ([object isKindOfClass:[XMethodCall class]]){
        MethodCallTableViewController *mctvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodCallTableViewController"];
        mctvc.displayingMethodCall = object;
        mctvc.inFramework = self.inFramework;
        mctvc.inClass = self.inClass;
        mctvc.inFunction = self.inFunction;
        [self.navigationController pushViewController:mctvc animated:YES];
        return YES;
    } else if ([object isKindOfClass:[NSString class]]){
        return [super didSelectObjectInArray:object];
    }
    return [super didSelectObjectInArray:object];
    
}



- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object
{
    if ([object isKindOfClass:[XArgument class]]) {
        return [super titleLabelForObjectInArray:object];
    } else if ([object isKindOfClass:[XMethodCall class]]){
        return @"";
    } else if ([object isKindOfClass:[NSString class]]){
        return @"String";
    }
    return nil;
}

- (id)instanceForName:(id)name andType:(id)type
{
    XArgument *argument = [[XArgument alloc] init];
    argument.name = name;
    argument.type = type;
    return argument;
}
//override
- (void)addNewItem:(void (^)(id))completionBlock
{
    [UserPrompter actionSheetWithTitle:@"New Argument"
                               message:nil
                         normalActions:@[@"Variable or Property", @"Method Call", @"String"]
                         cancelActions:@[@"Cancel"]
                    destructiveActions:nil
                             sendingVC:self
                       completionBlock:^(NSUInteger selectedStringIndex, int actionType) {
        switch (actionType) {
            case ACTION_TYPE_DEFAULT:
                switch (selectedStringIndex) {
                    case 0:
                        [self selectName:completionBlock];
                        break;
                    case 1:
                        [self selectMethodCall:completionBlock];
                        break;
                    case 2:
                        [self selectString:completionBlock];
                        break;
                    default:
                        break;
                }
                break;
                
            default:
                break;
        }
    }];
}


#warning SERIOUS SEROIUS Code Duplication as NewMethodCallTVC
- (void)selectName:(void(^)(id addedItem))completionBlock
{
    NameSelectorTableViewController *nstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"NameSelectorTableViewController"];
    [nstvc setCompletionBlock:^(XName *name) {
        XArgument *arg = [[XArgument alloc] init];
        arg.name = name;
        completionBlock(arg);
    }];
    nstvc.inFramework = self.inFramework;
    nstvc.inFunction = self.inFunction;
    nstvc.inClass = self.inClass;
    [self.navigationController pushViewController:nstvc animated:YES];
}

- (void)selectMethodCall:(void(^)(id addedItem))completionBlock
{
#warning SERIOUS Code Duplication as MethodCallsTVC
    NewMethodCallTableViewController *nmctvc =
    [self.storyboard instantiateViewControllerWithIdentifier:@"NewMethodCallTableViewController"];
    [nmctvc setCompletionBlock:^(XMethodCall *newMethodCall) {
        completionBlock(newMethodCall);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    nmctvc.inFramework = self.inFramework;
    nmctvc.inFunction = self.inFunction;
    nmctvc.inClass = self.inClass;
    [self.navigationController pushViewController:nmctvc animated:YES];
}

- (void)selectString:(void(^)(id addedItem))completionBlock
{
    [UserPrompter getTextMessageFromUser:@"New String" withViewController:self completionBlock:^(NSString *enteredText) {
        completionBlock(enteredText);
    }];
}
                

@end
