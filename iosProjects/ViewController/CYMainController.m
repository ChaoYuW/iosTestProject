//
//  CYMainController.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "CYMainController.h"

#import "CYUIController.h"
#import "CYTableController.h"
#import "CYProgressTableController.h"
#import "RecordVideoViewController.h"
#import "OffscreenRenderingTableViewController.h"

@interface CYMainController ()<UITableViewDelegate,UITableViewDataSource>
{
    ControllerType _controllerType;
}
@property (nonatomic, strong) NSMutableArray *dataMuArray;
@end

@implementation CYMainController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"测试用例";
    
    _dataMuArray = [NSMutableArray arrayWithCapacity:0];
    
    [_dataMuArray addObject:@"UI部分"];
    [_dataMuArray addObject:@"UITableview 刷新方法"];
    [_dataMuArray addObject:@"MBProgressHUD+ECAdd"];
    [_dataMuArray addObject:@"录制视频"];
    [_dataMuArray addObject:@"人脸识别"];
    [_dataMuArray addObject:@"离屏渲染"];
    
    UITableView *myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = _dataMuArray[indexPath.row];
    if ([title isEqualToString:@"UI部分"]) {
        [self gotoCYUIController];
    }else if ([title isEqualToString:@"UITableview 刷新方法"])
    {
        [self gotoCYTableController];
    }else if ([title isEqualToString:@"MBProgressHUD+ECAdd"])
    {
        [self gotoProgressController];
    }else if ([title isEqualToString:@"录制视频"])
    {
        [self gotoRecordVideoController];
    }else if ([title isEqualToString:@"离屏渲染"])
    {
        [self gotoRenderingController];
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataMuArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idCell = @"myCellId";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:idCell];
    if (myCell == nil) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idCell];
        myCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    NSString *titleString = _dataMuArray[indexPath.row];
    myCell.detailTextLabel.text = titleString;
    return myCell;
}

#pragma mark --
- (void)gotoCYUIController
{
    CYUIController * vc = [[CYUIController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)gotoCYTableController
{
    CYTableController * vc = [[CYTableController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)gotoProgressController
{
    CYProgressTableController * vc = [[CYProgressTableController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}
- (void)gotoRecordVideoController
{
    RecordVideoViewController *vc = RecordVideoViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)gotoRenderingController
{
    OffscreenRenderingTableViewController *vc = OffscreenRenderingTableViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
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
