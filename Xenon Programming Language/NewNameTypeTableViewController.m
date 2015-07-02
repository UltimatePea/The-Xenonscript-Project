//
//  NewNameTypeTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/31/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "NewNameTypeTableViewController.h"
#import "TypeSelectorTableViewController.h"
#import "UserPrompter.h"
#import "XType.h"
#import "XName.h"

@interface NewNameTypeTableViewController ()
@property (weak, nonatomic) IBOutlet UITableViewCell *nameTableViewCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *typeTableViewCell;

@property (strong, nonatomic) XType *selectedType;
@property (strong, nonatomic) XName *speicifiedName;

@end

@implementation NewNameTypeTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
#warning May not work
    [super viewWillAppear:animated];
    if (self.titlesForNameAndType) {
        self.nameTableViewCell.textLabel.text = self.titlesForNameAndType[0];
        self.typeTableViewCell.textLabel.text = self.titlesForNameAndType[1];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
}

- (void)done:(id)sender
{
    if (self.selectedType&&self.speicifiedName) {
        self.completionBlock(self.speicifiedName, self.selectedType);
    } else if ((!self.selectedType)&&(!self.speicifiedName)){
        [UserPrompter promptUserMessage:@"Please specify both a type and a name" withViewController:self];
    } else if (!self.selectedType){
        [UserPrompter promptUserMessage:@"Please specify a type" withViewController:self];
    } else if (!self.speicifiedName){
        [UserPrompter promptUserMessage:@"Please specify a name" withViewController:self];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isEqual:self.typeTableViewCell]) {
        TypeSelectorTableViewController *tstvc = [self.storyboard instantiateViewControllerWithIdentifier:@"TypeSelectorTableViewController"];
        [tstvc setCompletionBlock:^(XType *selectedType) {
            self.selectedType = selectedType;
            self.typeTableViewCell.detailTextLabel.text = [selectedType stringRepresentation];
        }];
        tstvc.inFramework = self.searchingFramework;
        [self.navigationController pushViewController:tstvc animated:YES];
    } else if ([cell isEqual:self.nameTableViewCell]){
        [UserPrompter getTextMessageFromUser:@"Please enter a name." withViewController:self completionBlock:^(NSString *enteredText) {
            self.speicifiedName = [[XName alloc] initWithString:enteredText];
            self.nameTableViewCell.detailTextLabel.text = enteredText;
            [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        }];
    }
}


@end
