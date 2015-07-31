//
//  ProjectTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectTableViewController.h"
#import "XProject.h"

@implementation ProjectTableViewController

- (void)setDisplayingProject:(XProject *)displayingProject
{
    _displayingProject = displayingProject;
    [super setDisplayingFramework:displayingProject];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.displayingProject saveToURL:self.displayingProject.savingURL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillResignActiveNotification object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
        [self.displayingProject save];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"SAVE_PROJ" object:nil queue:nil usingBlock:^(NSNotification * __nonnull note) {
        [self.displayingProject save];
    }];
}

@end
