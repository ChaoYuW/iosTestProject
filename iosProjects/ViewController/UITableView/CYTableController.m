//
//  CYTableController.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "CYTableController.h"

@interface CYTableController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_datas;
    
    NSIndexPath *_inp;
}
@end

@implementation CYTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UITableview 刷新方法" ;
    
    UITableView *tbv = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbv.dataSource =self;
    tbv.delegate =self;
    [self.view addSubview:tbv];
    
    
    _datas = [[NSArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",nil];
    
    
}
#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_inp) {
        
        if (_inp.section == indexPath.section && _inp.row == indexPath.row) {

            _inp = nil;
            return 60 *2.0;
            
            
            
        }
        
    }
    
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    
    
    
    //获取当前indexPath并判断对应的Cell是否被选中
    
    
    _inp = indexPath;
    
    
    
    //最神奇的地方！！
    
    [tableView beginUpdates];
    
    [tableView endUpdates];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
