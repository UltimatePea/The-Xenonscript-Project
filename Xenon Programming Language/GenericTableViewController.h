//
//  GenericTableViewController.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 5/22/15.
//  Copyright (c) 2015 Chen Zhibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenericTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *arrayToReturnCount;
- (NSString *)titleLabelForObjectInArray:(id)object;

- (BOOL)didSelectObjectInArray:(id)object;//return NO if you want to deselect
- (NSString *)reuseID;

//optional
- (NSString *)detailLabelForObjectInArrayIfApplicable:(id)object;
@end
