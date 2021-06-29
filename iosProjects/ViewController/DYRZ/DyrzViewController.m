//
//  DyrzViewController.m
//  iOSDyrzDemo
//
//  Created by lic&z on 2020/1/6.
//  Copyright © 2020 lic&z. All rights reserved.
//

#import "DyrzViewController.h"
#import <DYRZ/DYRZSDK.h>
#import <DYRZ/DYErrMacro.h>
#import "DyrzResultViewController.h"
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, ITEM)
{
    ITEM_AUTH_PHONE = 1,
    ITEM_AUTH_BANK,
    ITEM_AUTH_FACE,
    ITEM_AUTH_FACE_BUSINESS,
    ITEM_AUTH_FACE_BUSINESS_FK,
    ITEM_AUTH_ALIPAY
};

#define SetUserDefaults(key, value)     [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
#define GetUserDefaults(key)            [[NSUserDefaults standardUserDefaults] objectForKey:key]

//测试环境参数
#define APP_ID_T        @"sh193826-g9ka-78q7-b5e0-c8f3by987898"       // 平台分配
#define PRI_KEY_T       @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJaDl7Cgydun0dZncRTwcY6/7hshl26tXaEBEGOFYo8nksJ0V1bgWq1RO154b9IvH6QfOKHsJseuu1pACxnIbbRMTRayrJr61tzOWjT21pWO0oHzHwdMDceKqwHAS7oM01nKAN8m3fbRjZ1iklFE1t+F20tbrUonHRTKajNNGEHrAgMBAAECgYBM7YUiKYwCUIvXYZdSdHIV29L+2vRjBQjNuZV+yDXPpRJFgOEC7jhqTRJi/ntomd06LRrs554KgSwQvJrv2pj2vO/qq7RQws4egH7qtWyg+s48KZnB1QKRF0B1KsmYrLVio2AItZHJFFkTCWQWauzzBFNmroO8m4XoJgwIqoKqwQJBAM+iClLR8K4T2iHc8ECjlxxYsh194LQ1YyN5nTmnG+0+k1usukeJEFa4gVGrkhIf3/Gor+nJus0Yj1UUV/ubq5cCQQC5k1QQ3e7JApZ2tFUgKabGPvC63YhOkGHClny2lmgGpnM2Hn3aDezaUbiR2xH9zTVfsGnn0AgsU12voe0+cjbNAkBjm4j4Ul70I/HxbNyVJeXIY4SPQWQbD8GPszgKAHEVT3/B6wsyZj7AW6MuWvCoYUI93H8H2Q8UdUPNvQS4X+XhAkARCyHmZquelHlDL669xHWHsZIkZ2I0bPg9idqsXkXxjmn4Z3aBh1PgfS7pXmhZmfYz8pzXaHjHsWRiVAnY+V5lAkEAxdNqSJoqRuCE1jZAvA7Yhishq/h3Bd5Q+IAvq/T+6O+jde3FlXCyfY+clHmkQnfqfVeJpRspva1EiY8oM/mcyQ=="       // 平台分配

//正式环境参数
#define APP_ID          @"sh193826-g9ka-78q7-b5e0-c8f3by987898"       // 平台分配
#define PRI_KEY         @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJaDl7Cgydun0dZncRTwcY6/7hshl26tXaEBEGOFYo8nksJ0V1bgWq1RO154b9IvH6QfOKHsJseuu1pACxnIbbRMTRayrJr61tzOWjT21pWO0oHzHwdMDceKqwHAS7oM01nKAN8m3fbRjZ1iklFE1t+F20tbrUonHRTKajNNGEHrAgMBAAECgYBM7YUiKYwCUIvXYZdSdHIV29L+2vRjBQjNuZV+yDXPpRJFgOEC7jhqTRJi/ntomd06LRrs554KgSwQvJrv2pj2vO/qq7RQws4egH7qtWyg+s48KZnB1QKRF0B1KsmYrLVio2AItZHJFFkTCWQWauzzBFNmroO8m4XoJgwIqoKqwQJBAM+iClLR8K4T2iHc8ECjlxxYsh194LQ1YyN5nTmnG+0+k1usukeJEFa4gVGrkhIf3/Gor+nJus0Yj1UUV/ubq5cCQQC5k1QQ3e7JApZ2tFUgKabGPvC63YhOkGHClny2lmgGpnM2Hn3aDezaUbiR2xH9zTVfsGnn0AgsU12voe0+cjbNAkBjm4j4Ul70I/HxbNyVJeXIY4SPQWQbD8GPszgKAHEVT3/B6wsyZj7AW6MuWvCoYUI93H8H2Q8UdUPNvQS4X+XhAkARCyHmZquelHlDL669xHWHsZIkZ2I0bPg9idqsXkXxjmn4Z3aBh1PgfS7pXmhZmfYz8pzXaHjHsWRiVAnY+V5lAkEAxdNqSJoqRuCE1jZAvA7Yhishq/h3Bd5Q+IAvq/T+6O+jde3FlXCyfY+clHmkQnfqfVeJpRspva1EiY8oM/mcyQ=="       // 平台分配


@interface DyrzViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UISegmentedControl *envSegCtrl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *faceSegCtrl;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *idNOTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *bankTF;
@property (weak, nonatomic) IBOutlet UICollectionView *dyrzCollectionView;

@property (strong, nonatomic) NSArray *itemArr;

@property (strong, nonatomic) NSString *strAppId;
@property (strong, nonatomic) NSString *strAppKey;
@property (assign, nonatomic) BUILD buildType;

- (IBAction)dyrzEnvSelAction:(id)sender;

@property (strong, nonatomic) MBProgressHUD *m_hud;

@end

@implementation DyrzViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.itemArr = @[@{@"title":@"手机号认证", @"itemId":@(ITEM_AUTH_PHONE)},
                     @{@"title":@"银行卡认证", @"itemId":@(ITEM_AUTH_BANK)},
                     @{@"title":@"人脸识别认证", @"itemId":@(ITEM_AUTH_FACE)},
                     @{@"title":@"人脸识别商业库认证", @"itemId":@(ITEM_AUTH_FACE_BUSINESS)},
                     @{@"title":@"人脸识别商业库风控认证", @"itemId":@(ITEM_AUTH_FACE_BUSINESS_FK)},
                     @{@"title":@"支付宝认证", @"itemId":@(ITEM_AUTH_ALIPAY)}];
    
    self.strAppId = (self.envSegCtrl.selectedSegmentIndex == 0) ? APP_ID_T : APP_ID;
    self.strAppKey = (self.envSegCtrl.selectedSegmentIndex == 0) ? PRI_KEY_T : PRI_KEY;
    self.buildType = (self.envSegCtrl.selectedSegmentIndex == 0) ? BUILD_DEBUG : BUILD_RELEASE;
    
    if (GetUserDefaults(@"USER_NAME") != nil) {
        self.nameTF.text = GetUserDefaults(@"USER_NAME");
    }
    
    if (GetUserDefaults(@"USER_IDNO") != nil) {
        self.idNOTF.text = GetUserDefaults(@"USER_IDNO");
    }
    
    if (GetUserDefaults(@"USER_PHONE") != nil) {
        self.phoneTF.text = GetUserDefaults(@"USER_PHONE");
    }
    
    if (GetUserDefaults(@"USER_BANK") != nil) {
        self.bankTF.text = GetUserDefaults(@"USER_BANK");
    }
    
    self.dyrzCollectionView.dataSource = self;
    self.dyrzCollectionView.delegate = self;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [self.dyrzCollectionView setCollectionViewLayout:layout];
    [self.dyrzCollectionView registerNib:[UINib nibWithNibName:@"DYRZItemCell" bundle:nil] forCellWithReuseIdentifier:@"DYRZItemCell"];
}

- (void)hiddenKeyboardAction:(UIGestureRecognizer *)sender {
    [self.nameTF resignFirstResponder];
    [self.idNOTF resignFirstResponder];
    [self.phoneTF resignFirstResponder];
    [self.bankTF resignFirstResponder];
}

#pragma mark - collection view data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DYRZItemCell" forIndexPath:indexPath];
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    titleLabel.text = self.itemArr[indexPath.row][@"title"];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (self.view.bounds.size.width - 30)/2;
    CGFloat cellHight = 35;
    CGSize size = {cellWidth, cellHight};
    return size;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10.f, 10.f, 0.f, 10.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat fSpacing = 10.f;
    return fSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CGFloat fSpacing = 10.f;
    return fSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self hiddenKeyboardAction:nil];
    
    NSString *name = self.nameTF.text;
    NSString *idNo = self.idNOTF.text;
    NSString *mobileNo = self.phoneTF.text;
    NSString *bankNo = self.bankTF.text;
    NSString *transactionId = [NSString stringWithFormat:@"DYRZDemo-%@", [self getUUID]];
    
    SetUserDefaults(@"USER_NAME", name);
    SetUserDefaults(@"USER_IDNO", idNo);
    SetUserDefaults(@"USER_PHONE", mobileNo);
    SetUserDefaults(@"USER_BANK", bankNo);
    
    if (_m_hud == nil) {
        _m_hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _m_hud.removeFromSuperViewOnHide = true;
        _m_hud.label.text = @"认证中...";
        _m_hud.label.font = [UIFont systemFontOfSize:14];
    }
    
    NSInteger itemId = [self.itemArr[indexPath.row][@"itemId"] integerValue];
    switch (itemId) {
        case ITEM_AUTH_PHONE: {
            [DYRZSDK mobileAuth:self.strAppId appKey:self.strAppKey build:self.buildType name:name idNo:idNo mobileNo:mobileNo transactionId:transactionId resultBlock:^(DYRZResultBean *resultBean) {
                [self showResult:resultBean];
            }];
            break;
        }
        case ITEM_AUTH_BANK: {
            [DYRZSDK bankAuth:self.strAppId appKey:self.strAppKey build:self.buildType name:name idNo:idNo mobileNo:mobileNo bankNo:bankNo transactionId:transactionId resultBlock:^(DYRZResultBean *resultBean) {
                [self showResult:resultBean];
            }];
            break;
        }
        case ITEM_AUTH_FACE_BUSINESS_FK: {
            NSLog(@"人脸识别商业库风控认证 输入 appID=%@ appKey=%@ name= %@,idNo=%@,transactionId=%@",self.strAppId,self.strAppKey,name,idNo,transactionId);
            [DYRZSDK faceBusinessFKAuth:self.strAppId appKey:self.strAppKey build:self.buildType name:name idNo:idNo transactionId:transactionId resultBlock:^(DYRZResultBean *resultBean) {
                [self showResult:resultBean];
            }];
            break;
        }
        case ITEM_AUTH_ALIPAY: {
            [DYRZSDK ailPayAuth:self.strAppId appKey:self.strAppKey build:self.buildType transactionId:transactionId resultBlock:^(DYRZResultBean *resultBean) {
                [self showResult:resultBean];
            }];
            break;
        }
        case ITEM_AUTH_FACE:{
            [DYRZSDK faceAuth:self.strAppId appKey:self.strAppKey build:self.buildType name:name idNo:idNo controller:self transactionId:transactionId resultBlock:^(DYRZResultBean *resultBean) {
                [self showResult:resultBean];
            }];
        }
        default:
        {
            if (_m_hud != nil) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                _m_hud = nil;
            }
        }
            break;
    }
}

- (NSString *)getUUID{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    NSString *UUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return UUID;
}

- (IBAction)dyrzEnvSelAction:(id)sender {
    self.strAppId = (self.envSegCtrl.selectedSegmentIndex == 0) ? APP_ID_T : APP_ID;
    self.strAppKey = (self.envSegCtrl.selectedSegmentIndex == 0) ? PRI_KEY_T : PRI_KEY;
    self.buildType = (self.envSegCtrl.selectedSegmentIndex == 0) ? BUILD_DEBUG : BUILD_RELEASE;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
    hud.mode = MBProgressHUDModeText;
    if (self.envSegCtrl.selectedSegmentIndex == 0) {
        hud.label.text = @"已切换到测试环境";
    } else {
        hud.label.text = @"已切换到生产环境";
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1.0];
}

- (void)showResult:(DYRZResultBean *)bean {
    
    if (bean.code == SDK_AUTH_PROCESS) {
        // 认证进行中
        NSLog(@"认证界面释放，后台处理中.....");
    } else {
        if (_m_hud != nil) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            _m_hud = nil;
        }
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.detailsLabel.font = [UIFont systemFontOfSize:14.0f];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = bean.msg;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:1.0];
        
        NSLog(@"authType: %ld", (long)bean.authType);
        NSLog(@"code: %ld", (long)bean.code);
        NSLog(@"msg: %@", bean.msg);
        NSLog(@"token: %@", bean.token);
        
        
        NSString *authType = nil;
        switch (bean.authType) {
            case 1:
                authType = @"手机号认证";
                break;
            case 2:
                authType = @"银行卡认证";
                break;
            case 4:
                authType = @"支付宝认证";
                break;
            case 10:
                authType = @"人脸识别商业认证";
                break;
            default:
                authType = @"其它";
                break;
        }
        
        NSString *resultStr = [NSString stringWithFormat:@"code: %ld\r\nmsg: %@\r\ntype: %@\r\ntoken: %@\r\n", (long)bean.code, bean.msg, authType, bean.token];
//        [self performSegueWithIdentifier:@"SEGUE_DYRZ_RESULT" sender:resultStr];
        DyrzResultViewController *controller = DyrzResultViewController.new;
        controller.reuslt = resultStr;
        [self.navigationController pushViewController:controller animated:NO];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DyrzResultViewController *controller = [segue destinationViewController];
    controller.reuslt = sender;
}


@end
