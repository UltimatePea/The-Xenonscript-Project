//
//  ProjectsTableViewController.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "ProjectTableViewController.h"
#import "XProject.h"
#import "XName.h"
#import "UserPrompter.h"

@interface ProjectsTableViewController ()

@property (strong, nonatomic) NSFileManager *fileManager;
@property (strong, nonatomic) NSURL *documentRoot;

@end

@implementation ProjectsTableViewController

- (NSFileManager *)fileManager
{
    if (!_fileManager) {
        _fileManager = [NSFileManager defaultManager];
    }
    return _fileManager;
}

- (NSURL *)documentRoot
{
    NSFileManager *fm = self.fileManager;
    NSURL *documentRoot = [[fm URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSURL *documentSaveDomain = [documentRoot URLByAppendingPathComponent:@"projects/"];
    if (![fm fileExistsAtPath:documentSaveDomain.path]) {
        NSError *error;
        [fm createDirectoryAtURL:documentSaveDomain withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            [UserPrompter promptUserMessage:@"Cannot Create Root Document Directory" withViewController:self];
        }
    }
    return documentSaveDomain;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDisplayingProjects];
    self.arrayToReturnCount = self.displayingProjects;
}
#define XENON_SCRIPT_PATH_EXTENSION_XSPROJ @"xsproj"
- (void)loadDisplayingProjects
{
    self.displayingProjects = [NSMutableArray array];
    NSURL *documentSaveDomain = self.documentRoot;
    NSError *err;
    NSArray *files = [self.fileManager contentsOfDirectoryAtURL:documentSaveDomain includingPropertiesForKeys:nil options:NSDirectoryEnumerationSkipsHiddenFiles error:&err];
    if (err) {
        [UserPrompter promptUserMessage:@"Cannnot Read Root Document Directory" withViewController:self];
    }
    [files enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        NSURL *url = obj;
        if ([url.pathExtension isEqualToString:XENON_SCRIPT_PATH_EXTENSION_XSPROJ]) {
            XProject *proj = [[XProject alloc] initWithURL:url];
            [self.displayingProjects addObject:proj];
        };
    }];
}


- (NSString *)titleLabelForObjectInArray:(id)object
{
    XProject *proj = object;
    return proj.name.stringRepresentation;
}

- (BOOL)didSelectObjectInArray:(id)object//return NO if you want to deselect
{
    ProjectTableViewController *ftvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProjectTableViewController"];
    ftvc.displayingProject = object;
    [self.navigationController pushViewController:ftvc animated:YES];
    return YES;
}
- (NSString *)reuseID
{
    return @"project";
}

- (BOOL)canAddItem
{
    return YES;
}

- (BOOL)canEditTable
{
    return YES;
}

- (void)addNewItem:(void (^)(id))completionBlock
{
    [UserPrompter getTextMessageFromUser:@"New Project Name" withViewController:self completionBlock:^(NSString *enteredText) {
        XProject *proj = [[XProject alloc] init];
        
        proj.name = [[XName alloc] initWithString:enteredText];
        NSURL *saveURL = [self.documentRoot URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",enteredText, XENON_SCRIPT_PATH_EXTENSION_XSPROJ]];
        [self.fileManager createFileAtPath:saveURL.path contents:nil attributes:nil];
        proj.savingURL = saveURL;
        [proj saveToURL:saveURL];
        
        completionBlock(proj);
    }];
}



@end
