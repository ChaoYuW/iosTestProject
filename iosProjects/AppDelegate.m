//
//  AppDelegate.m
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#import "AppDelegate.h"
#import "CYMainController.h"
#import <DYRZ/DYRZSDK.h>
#import <DYRZ/DYErrMacro.h>

static NSString *txKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAJaDl7Cgydun0dZncRTwcY6/7hshl26tXaEBEGOFYo8nksJ0V1bgWq1RO154b9IvH6QfOKHsJseuu1pACxnIbbRMTRayrJr61tzOWjT21pWO0oHzHwdMDceKqwHAS7oM01nKAN8m3fbRjZ1iklFE1t+F20tbrUonHRTKajNNGEHrAgMBAAECgYBM7YUiKYwCUIvXYZdSdHIV29L+2vRjBQjNuZV+yDXPpRJFgOEC7jhqTRJi/ntomd06LRrs554KgSwQvJrv2pj2vO/qq7RQws4egH7qtWyg+s48KZnB1QKRF0B1KsmYrLVio2AItZHJFFkTCWQWauzzBFNmroO8m4XoJgwIqoKqwQJBAM+iClLR8K4T2iHc8ECjlxxYsh194LQ1YyN5nTmnG+0+k1usukeJEFa4gVGrkhIf3/Gor+nJus0Yj1UUV/ubq5cCQQC5k1QQ3e7JApZ2tFUgKabGPvC63YhOkGHClny2lmgGpnM2Hn3aDezaUbiR2xH9zTVfsGnn0AgsU12voe0+cjbNAkBjm4j4Ul70I/HxbNyVJeXIY4SPQWQbD8GPszgKAHEVT3/B6wsyZj7AW6MuWvCoYUI93H8H2Q8UdUPNvQS4X+XhAkARCyHmZquelHlDL669xHWHsZIkZ2I0bPg9idqsXkXxjmn4Z3aBh1PgfS7pXmhZmfYz8pzXaHjHsWRiVAnY+V5lAkEAxdNqSJoqRuCE1jZAvA7Yhishq/h3Bd5Q+IAvq/T+6O+jde3FlXCyfY+clHmkQnfqfVeJpRspva1EiY8oM/mcyQ==";


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    //支付宝
    [DYRZSDK alipayAuthSetUrlSchemes:@"com.custle.iosdyrzdemo"];

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"上海CA_东方网融媒体平台" ofType:@"license"];
//    HuiYanSDKKit *hyKit = [HuiYanSDKKit sharedInstance];
//    AuthConfig *authConfig = AuthConfig.new;
//    authConfig.licencePath = filePath;
//
//    [hyKit startHuiYanAuthWithAuthConfig:authConfig withProcessSucceedBlock:^(id  _Nonnull resultInfo, id  _Nullable reserved) {
//
//    } withProcessFailedBlock:^(NSError * _Nonnull error, id  _Nullable reserved) {
//        NSLog(@"error : %@",error);
//    }];
//
//
//
//
//    [DYRZSDK faceAuth:@"sh193826-g9ka-78q7-b5e0-c8f3by987898" appKey:txKey build:BUILD_DEBUG name:@"王二超" idNo:@"412722199010015712" transactionId:@"sd" resultBlock:^(DYRZResultBean *resultBean) {
//        NSLog(@" resultBean = %@",resultBean);
//    }];
    
    
    
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    [self.window makeKeyAndVisible] ;
    
    CYMainController *mainVC = [[CYMainController alloc] init] ;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainVC] ;
    self.window.rootViewController = navController ;
    
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        [DYRZSDK alipayAuthHandleOpenURL:url];
    }
    
    return YES;
}

// iOS9以后
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        [DYRZSDK alipayAuthHandleOpenURL:url];
    }
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
