//
//  SearchTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/2/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "SearchTableViewController.h"

@interface SearchTableViewController ()<UISearchResultsUpdating, UISearchBarDelegate>
@property (strong, nonatomic) UISearchController *searchController;


@end

@implementation SearchTableViewController
- (void)awakeFromNib
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    //    self.searchController.searchBar.scopeButtonTitles = @[NSLocalizedString(@"ScopeButtonCountry",@"Country"),
    //                                                          NSLocalizedString(@"ScopeButtonCapital",@"Capital")];
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    [self.searchController.searchBar sizeToFit];
    
    
    
    
}

- (void)searchForText:(NSString *)searchString
{
//    if ([searchString isEqualToString: @""]) {
//        self.arrayToReturnCount = self.dataSource;
//        return;
//    }
}
- (void)viewWillAppear:(BOOL)animated
{
    self.arrayToReturnCount = [self getObjects];
    self.dataSource = self.arrayToReturnCount;
    [super viewWillAppear:animated];//which is calling update
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    if ([searchString isEqualToString:@""]) {
        self.arrayToReturnCount = self.dataSource;
    } else {
        [self searchForText:searchString];
    }
    
    [self.tableView reloadData];
}

- (NSString *)searchBarText
{
    return self.searchController.searchBar.text;
}
@end
