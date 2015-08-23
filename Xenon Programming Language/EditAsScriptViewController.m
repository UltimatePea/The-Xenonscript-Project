//
//  EditAsScriptViewController.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/17/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "EditAsScriptViewController.h"

@interface EditAsScriptViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) NSArray<UIBarButtonItem *> *toolBarItems;
@end

@implementation EditAsScriptViewController

- (UIToolbar *)toolBar
{
    if (!_toolBar) {
        _toolBar = [[UIToolbar alloc] init];
        
        _toolBar.items = self.toolBarItems;
    }
    return _toolBar;
}

- (NSArray<UIBarButtonItem *> *)toolBarItems
{
    NSMutableArray *array = [NSMutableArray array];
    
    //set up tap button
    UIBarButtonItem  *tabButton = [[UIBarButtonItem alloc] initWithTitle:@"➡️" style:UIBarButtonItemStylePlain target:self action:@selector(keyBoardTab:)];
    [array addObject:tabButton];
    return array;
}

- (void)keyBoardTab:(id)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.inputAccessoryView = self.toolBar;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
