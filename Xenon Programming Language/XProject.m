//
//  XProject.m
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/6/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import "XProject.h"

#import "FrameworkTableViewController.h"


@implementation XProject

#define KEY_VERSION_NUMBER @"Version"
#define CURRENT_VERSION_NUMBER @"1.0"
- (id)JSONObject
{
    NSMutableDictionary *dic = [super JSONObject];
    [dic setObject:CURRENT_VERSION_NUMBER forKey:KEY_VERSION_NUMBER];
    return dic;
}



- (void)saveToURL:(NSURL *)url
{
    NSError *error;
    [[NSJSONSerialization dataWithJSONObject:[self JSONObject] options:NSJSONWritingPrettyPrinted error:&error] writeToURL:url atomically:YES];
}

- (instancetype)initWithURL:(NSURL *)url
{
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingMutableContainers error:&error];
    if (jsonObject == nil || error) {
        NSLog(@"Project init Error");
    }
    self = [self initWithJSONObject:jsonObject];
    if (self) {
        self.savingURL = url;
    }
    return self;
}

@end
