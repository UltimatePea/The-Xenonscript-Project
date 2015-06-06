//
//  SearchTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "GenericTableViewController.h"

@interface SearchTableViewController : GenericTableViewController

@property (strong, nonatomic) NSMutableArray *dataSource;//instance should use this property to access the original database
- (NSMutableArray *)getObjects;//instance must return all objects
- (void)searchForText:(NSString *)searchString;//instance should set arrayToReturnCount, call super before searching
- (NSString *)searchBarText;//user entered text in the search bar
@end
