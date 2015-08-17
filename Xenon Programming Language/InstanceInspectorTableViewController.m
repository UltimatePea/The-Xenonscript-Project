//
//  InstanceInspectorTableViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/17/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "InstanceInspectorTableViewController.h"
#import "Instance.h"
#import "Field.h"
#import "InstanceFieldEntry.h"

@interface InstanceInspectorTableViewController ()

@property (strong, nonatomic) NSMutableArray<InstanceFieldEntry *> *entries;

@end

@implementation InstanceInspectorTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self update];
    
}

- (void)update
{
    NSArray *entries =  self.displayingInstance.field.instanceEntries;
    InstanceFieldEntry *fieldEntry = [[InstanceFieldEntry alloc] init];
    fieldEntry.name = @"parent";
    fieldEntry.containingInstance = self.displayingInstance.baseInstance;
    self.entries = [NSMutableArray arrayWithArray:[entries arrayByAddingObject:fieldEntry]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.entries.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%@", NSStringFromClass([self class]), @"Cell"] forIndexPath:indexPath];
    InstanceFieldEntry *instEntry = self.entries[indexPath.row];
    cell.textLabel.text = instEntry.name;
   
    if(instEntry.containingInstance.isString){
        cell.detailTextLabel.text = instEntry.containingInstance.objectiveCModel;
    } else {
        cell.detailTextLabel.text = @"";
    }
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    InstanceInspectorTableViewController *iitvc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
    iitvc.displayingInstance = self.entries[indexPath.row].containingInstance;
    [self.navigationController pushViewController:iitvc animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
