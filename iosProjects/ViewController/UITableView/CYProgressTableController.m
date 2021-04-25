//
//  CYProgressTableController.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "CYProgressTableController.h"
#import "MBProgressHUD+ECAdd.h"

@interface CYProgressTableController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_datas;
    
    NSIndexPath *_inp;
}
@end

@implementation CYProgressTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MBProgressHUD+ECAdd" ;
    
    UITableView *tbv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbv.dataSource =self;
    tbv.delegate =self;
    [self.view addSubview:tbv];
    
    
    _datas = [[NSArray alloc]initWithObjects:@"成功",@"失败",@"显示风火轮",@"显示text于底部",@"1",@"1",@"1",@"1",nil];
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    switch (indexPath.row) {
        case 0:
        {
            [MBProgressHUD showSuccess:@"成功"];
        }
            break;
        case 1:
        {
            [MBProgressHUD showError:@"失败"];
        }
            break;
        case 2:
        {
            [MBProgressHUD showActivityIndicatorTitle:nil detailTitle:nil toView:self.view];
        }
            break;
        case 3:
        {
            [MBProgressHUD showText:@"显示底部消失" toView:self.view];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas count] ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"myCellId" ;
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:idCell] ;
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idCell] ;
        myCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *titleString = _datas[indexPath.row] ;
    myCell.textLabel.text = titleString ;
    return myCell ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
