//
//  GenericTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"

@implementation GenericTableViewController

- (void)viewDidLoad
{
#define BAR_TITLE_EDIT @"Edit"
    [super viewDidLoad];
    
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    NSMutableArray *barItems = [NSMutableArray array];
    if ([self respondsToSelector:@selector(canEditTable)]) {
        if ([self canEditTable]) {
            UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:BAR_TITLE_EDIT style:UIBarButtonItemStylePlain target:self action:@selector(editTableView:)];
            [barItems addObject:editButton];
        }
    }
    if ([self respondsToSelector:@selector(canAddItem)]) {
        if ([self canAddItem]) {
            UIBarButtonItem *addButtton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(addNew:)];
            [barItems addObject:addButtton];
        }
    }
    self.navigationItem.rightBarButtonItems = barItems;
}

- (void)addNew:(UIBarButtonItem *)item
{
    if ([self respondsToSelector:@selector(addNewItem:)]) {
        if ([self canAddItem]) {
            __weak GenericTableViewController *weakSelf = self;
           [self addNewItem:^(id addedItem) {
               [weakSelf.arrayToReturnCount addObject:addedItem];
               [weakSelf.tableView reloadData];
           }];
        }
    }
}
                                                                     
- (void)editTableView:(UIBarButtonItem *)item
{
    if ([self respondsToSelector:@selector(canEditTable)]) {
        if ([self canEditTable]) {
            BOOL setEdit = !self.tableView.editing;
            [self.tableView setEditing:setEdit animated:YES];
            [item setTitle:setEdit?@"Done":BAR_TITLE_EDIT];
        }
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editingStyle) {
        case UITableViewCellEditingStyleDelete:
            if ([self canEditTable]) {
                if ([self respondsToSelector:@selector(shouldDeleteObject:)]) {
                    if ([self shouldDeleteObject:[self.arrayToReturnCount objectAtIndex:indexPath.row]]) {
                        [self removeObjectAtIndexPath:indexPath];
                    }
                } else {
                    [self removeObjectAtIndexPath:indexPath];
                }
            }
            break;
            
        default:
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self respondsToSelector:@selector(canEditTable)]) {
        return [self canEditTable];
    }
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSMutableArray *mut = self.arrayToReturnCount;
    id object = [mut objectAtIndex:sourceIndexPath.row];
    [mut removeObject:object];
    [mut insertObject:object atIndex:destinationIndexPath.row];
    //self.arrayToReturnCount = [NSMutableArray arrayWithArray:mut];
    
    [self.tableView reloadData];
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *mut = self.arrayToReturnCount;
    [mut removeObjectAtIndex:indexPath.row];
   // self.arrayToReturnCount = [NSMutableArray arrayWithArray:mut];
    
    [self.tableView reloadData];
#warning COPY TO BE TESTED
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayToReturnCount.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseID] forIndexPath:indexPath];
    
    id object = [self.arrayToReturnCount objectAtIndex:indexPath.row];
    cell.textLabel.text = [self titleLabelForObjectInArray:object];
//    cell.textLabel.numberOfLines = 0;
    if ([self respondsToSelector:@selector(detailLabelForObjectInArrayIfApplicable:)]) {
        cell.detailTextLabel.text = [self detailLabelForObjectInArrayIfApplicable:object];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (![self didSelectObjectInArray:[self.arrayToReturnCount objectAtIndex:indexPath.row]]) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}


@end
