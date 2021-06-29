//
//  DyrzResultViewController.m
//  iOSDyrzDemo
//
//  Created by lic&z on 2020/1/6.
//  Copyright © 2020 lic&z. All rights reserved.
//

#import "DyrzResultViewController.h"

@interface DyrzResultViewController ()

@property (strong, nonatomic) UITextView *resultTV;

@end

@implementation DyrzResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.resultTV];
    self.resultTV.frame = CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 200);
    
    
    _resultTV.text = self.reuslt;
}

- (UITextView *)resultTV
{
    if (_resultTV == nil) {
        _resultTV = UITextView.new;
        _resultTV.editable = NO;
        _resultTV.textColor = UIColor.blackColor;
    }
    return _resultTV;
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
