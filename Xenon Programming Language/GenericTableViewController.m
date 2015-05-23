//
//  GenericTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"

@implementation GenericTableViewController


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
