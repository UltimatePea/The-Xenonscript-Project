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
    XProperty *pro = [[XProperty alloc] init];
    pro.name = [[XName alloc] initWithString: @"Test Property"];
    pro.type = [[XType alloc] initWithString:@"String"];
    
    XFunction *func = [[XFunction alloc] init];
    func.name = [[XName alloc] initWithString:@"Test Function"];
    func.returnType = [[XType alloc] initWithString:@"void"];
    
    XParameter *param = [[XParameter alloc] init];
    param.name = [[XName alloc] initWithString:@"Test Parameter Name"];
    param.type = [[XType alloc] initWithString:@"Int"];
    func.parameters = @[param];
    
    XClass *cla = [[XClass alloc] init];
    cla.name = [[XName alloc] initWithString:@"Test Class"];
    cla.properties = @[pro];
    cla.methods = @[func];
    
    XFramework *fram = [[XFramework alloc] init];
    fram.classes = @[cla];
    
    self.displayingFramework = fram;
    
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
    [self.navigationController pushViewController:ctvc animated:YES];
    return YES;
}

- (NSString *)reuseID
{
    return @"test";
}



@end
