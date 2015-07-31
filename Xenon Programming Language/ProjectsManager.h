//
//  ProjectsManager.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/2/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XProject;
@interface ProjectsManager : NSObject

@property (strong, nonatomic) NSURL *documentRootForProjects;

- (NSMutableArray *)projectsURLsAvailable;
- (NSURL *)urlForAddingProjectWithName:(NSString *)name;//returns the added project URL
- (NSURL *)mostRecentModifiedProjectURL;
- (NSMutableArray *)projectsURLsAvailableSortedByDate:(BOOL)latestFirst;
- (void)deleteProjectAtURL:(NSURL *)projectURL;
- (BOOL)openProjectURL:(NSURL *)url;
+ (instancetype)sharedProjectsManager;
@end
