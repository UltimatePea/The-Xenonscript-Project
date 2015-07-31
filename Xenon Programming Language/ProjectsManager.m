//
//  ProjectsManager.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 7/2/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectsManager.h"
#import "UserPrompter.h"
#import "XProject.h"
#import "XName.h"

@interface ProjectsManager ()
@property (strong, nonatomic) NSFileManager *fileManager;
@end


@implementation ProjectsManager


- (NSFileManager *)fileManager
{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (void)deleteProjectAtURL:(NSURL *)projectURL;
{
    NSError *error;
    [self.fileManager removeItemAtURL:projectURL error:&error];
    if (error) {
        [UserPrompter promptUserMessage:@"Unable to delete project" withViewController:nil];
    }
}


- (NSURL *)documentRootForProjects
{
    if (!_documentRootForProjects) {
        NSFileManager *fm = self.fileManager;
        NSURL *documentRoot = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
        NSURL *documentSaveDomain = [documentRoot URLByAppendingPathComponent:@"projects/"];
        if (![fm fileExistsAtPath:documentSaveDomain.path]) {
            NSError *error;
            [fm createDirectoryAtURL:documentSaveDomain withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                [UserPrompter promptUserMessage:@"Cannot Create Root Document Directory" withViewController:nil];
            }
        }
       
        _documentRootForProjects = documentSaveDomain;
    }
    return _documentRootForProjects;
    
}
#define XENON_SCRIPT_PATH_EXTENSION_XSPROJ @"xsproj"


- (NSURL *)mostRecentModifiedProjectURL;

{
    return [self projectsURLsAvailableSortedByDate:YES].firstObject;
    
}



- (NSMutableArray *)projectsURLsAvailableSortedByDate:(BOOL)latestFirst;
{
    NSArray *urls = [self eligibleURLsForAvailableProjects];
    urls =  [urls sortedArrayUsingComparator:^NSComparisonResult(id  __nonnull obj1, id  __nonnull obj2) {
        NSURL *url1 = obj1, *url2 = obj2;
        NSError *error1, *error2;
        NSDate *date1=[self.fileManager attributesOfItemAtPath:url1.path error:&error1][NSFileModificationDate],
        *date2=[self.fileManager attributesOfItemAtPath:url2.path error:&error2][NSFileModificationDate];
        if (error1||error2) {
            [UserPrompter promptUserMessage:@"Cannot get attributes for a project file" withViewController:nil];
        }
        return [date1 compare:date2]==NSOrderedAscending?NSOrderedDescending:NSOrderedAscending;
    }];
    
    
    return [NSMutableArray arrayWithArray:urls];
    
}

- (NSMutableArray *)projectsURLsAvailable;
{
    return [self eligibleURLsForAvailableProjects];
}

//- (NSMutableArray *)projectsForURLs:(NSArray *)urls
//{
//    NSMutableArray *projects =  [NSMutableArray array];
//    [urls enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
//        NSURL *url = obj;
//        XProject *proj = [[XProject alloc] initWithURL:url];
//        [projects addObject:proj];
//    }];
//    return projects;
//}

- (NSMutableArray *)eligibleURLsForAvailableProjects
{
    NSMutableArray *urls =  [NSMutableArray array];
    NSURL *documentSaveDomain = self.documentRootForProjects;
    NSError *err;
    NSArray *files = [self.fileManager contentsOfDirectoryAtURL:documentSaveDomain includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&err];
    if (err) {
        [UserPrompter promptUserMessage:@"Cannnot Read Root Document Directory" withViewController:nil];
    }
    [files enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        NSURL *url = obj;
        if ([url.pathExtension isEqualToString:XENON_SCRIPT_PATH_EXTENSION_XSPROJ]) {
            [urls addObject:url];
        };
    }];
    return urls;
}

- (NSURL *)urlForAddingProjectWithName:(NSString *)name;//returns the added project URL
{
    XProject *proj = [[XProject alloc] init];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Foundation" withExtension:@"xsproj"];
    proj = [[XProject alloc] initWithURL:url];
   
    proj.name = [[XName alloc] initWithString:name];
    NSURL *saveURL = [self.documentRootForProjects URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",name, XENON_SCRIPT_PATH_EXTENSION_XSPROJ]];
    [self.fileManager createFileAtPath:saveURL.path contents:nil attributes:nil];
    proj.savingURL = saveURL;
    [proj saveToURL:saveURL];
    return saveURL;
}


+ (instancetype)sharedProjectsManager
{
    static ProjectsManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
