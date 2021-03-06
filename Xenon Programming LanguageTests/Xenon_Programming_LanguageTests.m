//
//  Xenon_Programming_LanguageTests.m
//  Xenon Programming LanguageTests
//
//  Created by Chen Zhibo on 5/14/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ClassesTableViewController.h"
#import "TypeSelectorTableViewController.h"
#import "Line.h"
#import "Xenon.h"
@interface Xenon_Programming_LanguageTests : XCTestCase

@end

@implementation Xenon_Programming_LanguageTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFrameworkTVC
{
    
}

- (void)testXName
{
    XName *name = [[XName alloc] initWithString:@"Ella"];
    XCTAssertEqual([name.stringRepresentation isEqualToString:@"Ella"], YES);
}

- (void)testLineClass
{
    Line *line = [[Line alloc] initWithString:@"class Hel\\#$@ lo extends Object "];
    XCTAssertEqual([line isClassDefinitionValid], YES);
}

@end
