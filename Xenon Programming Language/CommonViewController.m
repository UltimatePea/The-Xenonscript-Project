//
//  CommonViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 7/16/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "CommonViewController.h"
#import "Xenon.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *title = @"";
    BOOL titleHasChanged = NO;
    if ([self respondsToSelector:@selector(inFramework)]) {
        NSString *strToAppend =[[((XFramework *)[self performSelector:@selector(inFramework)]) name] stringRepresentation];
        if (strToAppend) {
            title = [title stringByAppendingString:strToAppend];
            titleHasChanged = YES;
        }
        
    }
    if ([self respondsToSelector:@selector(inClass)]) {
        
        NSString *strToAppend =[[((XClass *)[self performSelector:@selector(inClass)]) name] stringRepresentation];
        if (strToAppend) {
            title = [title stringByAppendingString:@" : "];
            title = [title stringByAppendingString:strToAppend];
            titleHasChanged = YES;
        }
        
    }
    if ([self respondsToSelector:@selector(inFunction)]) {
        
        NSString *strToAppend = [[((XFunction *)[self performSelector:@selector(inFunction)]) name] stringRepresentation];
        if (strToAppend) {
            title = [title stringByAppendingString:@" : "];
            title = [title stringByAppendingString:strToAppend];
            titleHasChanged = YES;
        }
        
    }
    if (titleHasChanged) {
        self.navigationItem.prompt = title;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
