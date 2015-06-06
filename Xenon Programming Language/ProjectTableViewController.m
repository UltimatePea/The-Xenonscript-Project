//
//  ProjectTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "XFramework.h"
#import "XClass.h"
#import "XName.h"
#import "ClassTableViewController.h"

//test
#import "XFunction.h"
#import "XProperty.h"
#import "XClass.h"
#import "XFramework.h"
#import "XType.h"
#import "XArgument.h"
#import "XParameter.h"
#import "XMethodCall.h"
#import "XLocalVariable.h"

@interface ProjectTableViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ProjectTableViewController

- (void)viewDidLoad
{
    [self test];
    self.arrayToReturnCount = self.displayingFramework.classes;
}

- (void)test
{
    XFramework *fram = [self createRandomFramework];
    
    self.displayingFramework = fram;
    
}

- (XFramework *)createRandomFramework
{
    XProperty *pro = [[XProperty alloc] init];
    pro.name = [[XName alloc] initWithString: @"Test Property"];
    pro.type = [[XType alloc] initWithString:@"String"];
    XProperty *pro2 = [[XProperty alloc] init];
    pro2.name = [[XName alloc] initWithString: @"Test pro2perty"];
    pro2.type = [[XType alloc] initWithString:@"String"];
    
    XFunction *func = [[XFunction alloc] init];
    func.name = [[XName alloc] initWithString:@"Test Function"];
    func.returnType = [[XType alloc] initWithString:@"void"];
    
    XParameter *param = [[XParameter alloc] init];
    param.name = [[XName alloc] initWithString:@"Test Parameter Name"];
    param.type = [[XType alloc] initWithString:@"Int"];
    func.parameters = [NSMutableArray arrayWithArray:@[param]];
    
    XLocalVariable *lv = [[XLocalVariable alloc] init];
    lv.name = [[XName alloc] initWithString:@"Test Local Variable"];
    lv.type = [[XType alloc] initWithString:@"String"];
    func.localVariables = [[NSMutableArray alloc] initWithObjects:lv, nil];
    
    XMethodCall *methodCall = [[XMethodCall alloc] init];
    methodCall.instanceName = nil;
    methodCall.functionName = [[XName alloc] initWithString: @"trace"];
    func.methodCalls = [NSMutableArray arrayWithArray:@[methodCall]];
    XMethodCall *methodCall2 = [[XMethodCall alloc] init];
    methodCall2.functionName = [[XName alloc] initWithString:@"getValue"];
    methodCall.arguments = [NSMutableArray arrayWithArray:@[methodCall2]];
    
    XClass *cla = [[XClass alloc] init];
    cla.name = [[XName alloc] initWithString:@"Test Class"];
    cla.properties = [NSMutableArray arrayWithArray:@[pro, pro2]];
    cla.methods = [NSMutableArray arrayWithArray:@[func]];
    
    XFramework *fram = [[XFramework alloc] init];
    fram.classes = [NSMutableArray arrayWithArray:@[cla]];
    return fram;
}

- (NSString *)titleLabelForObjectInArray:(id)object
{
    XClass *xClass = object;
    return [xClass.name stringRepresentation];
}

- (BOOL)didSelectObjectInArray:(id)object
{
    //    ClassTableViewController *ctvc = [[ClassTableViewController alloc] initWithStyle:UITableViewStylePlain];
    ClassTableViewController *ctvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ClassTableViewController"];
    ctvc.displayingClass = object;
    ctvc.inFramework = self.displayingFramework;
    [self.navigationController pushViewController:ctvc animated:YES];
    return YES;
}

- (NSString *)reuseID
{
    return @"test";
}



@end
