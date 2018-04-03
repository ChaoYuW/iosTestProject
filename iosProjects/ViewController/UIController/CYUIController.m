//
//  CYUIController.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "CYUIController.h"

@interface CYUIController ()

@end

@implementation CYUIController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UI部分" ;
    
    self.view.backgroundColor = [UIColor whiteColor] ;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.frame) ;
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 64, viewWidth-2*10, 150)] ;
    testLabel.text = @"最近准备给 VirtualView-iOS 的文本元素新增一个 lineHeight 属性，以便和 VirtualView-Android 配合时能更精确的保证双平台的一致性。面向 Google 以及 Stack Overflow 编程了一会后发现，能查到的资料大部分是介绍如何实现 lineSpacing 属性，而不是 lineHeight。但是我就是因为 iOS 和 Android 的默认 lineSpacing 不一致所以才想实现个 lineHeight 啊！还是需要自己动手丰衣足食，顺带整理成文章造福后人。" ;
    testLabel.numberOfLines = 0 ;
    [self.view addSubview:testLabel] ;
    
    testLabel.backgroundColor = [UIColor redColor] ;
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
