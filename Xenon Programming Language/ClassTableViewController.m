//
//  ClassTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ClassTableViewController.h"
#import "XClass.h"
#import "XName.h"
#import "XType.h"
#import "PropertiesTableViewController.h"
#import "MethodsTableViewController.h"
#import "TypeSelectorTableViewController.h"
#import "EditAsScriptViewController.h"

@interface ClassTableViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableViewCell *propertiesTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *methodsTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *baseClassTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *editAsScriptTableViewCell;

@end

@implementation ClassTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.title = [self.displayingClass.name stringRepresentation];
    self.baseClassTableViewCell.detailTextLabel.text = self.displayingClass.baseClass.stringRepresentation;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.propertiesTableViewCell]) {
        UITableViewController *tvc;
        tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PropertiesTableViewController"];
//        tvc.title = [NSString stringWithFormat:@"%@ : Properties", self.displayingClass.name.stringRepresentation];
        ((PropertiesTableViewController *)tvc).displayingProperties = self.displayingClass.properties;
        ((PropertiesTableViewController *)tvc).inFramework = self.inFramework;
        [self.navigationController pushViewController:tvc animated:YES];
    } else if ([cell isEqual:self.methodsTableViewCell]){
        UITableViewController *tvc;
        tvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MethodsTableViewController"];
//        tvc.title = [NSString stringWithFormat:@"%@ : Methods", self.displayingClass.name.stringRepresentation];
        ((MethodsTableViewController *)tvc).displayingMethods = self.displayingClass.methods;
        ((MethodsTableViewController *)tvc).inFramework = self.inFramework;
        ((MethodsTableViewController *)tvc).inClass = self.displayingClass;
        [self.navigationController pushViewController:tvc animated:YES];
    } else if ([cell isEqual:self.baseClassTableViewCell]){
        TypeSelectorTableViewController *tpvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeSelectorTableViewController"];
        tpvc.inFramework = self.inFramework;
        [tpvc setCompletionBlock:^(XType *selectedType) {
            self.displayingClass.baseClass = selectedType;
        }];
        [self.navigationController pushViewController:tpvc animated:YES];

    } else if ([cell isEqual:self.editAsScriptTableViewCell]){
        EditAsScriptViewController *easvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([EditAsScriptViewController class])];
        easvc.displayingClass = self.displayingClass;
        [self.navigationController pushViewController:easvc animated:YES];
    }
    
    
    
    
    
    
    
    
}

@end
