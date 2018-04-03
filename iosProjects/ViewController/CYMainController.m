//
//  CYMainController.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "CYMainController.h"

@interface CYMainController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (nonatomic, strong) NSMutableArray *dataMuArray ;
@end

@implementation CYMainController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试用例" ;
    
    _dataMuArray = [NSMutableArray arrayWithCapacity:0] ;
    
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain] ;
    myTableView.delegate = self ;
    myTableView.dataSource = self ;
    [self.view addSubview:myTableView] ;
    
    
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataMuArray count] ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"myCellId" ;
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:idCell] ;
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idCell] ;
        myCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return myCell ;
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
