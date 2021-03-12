//
//  MBProgressHUD+ECAdd.h
//  StandardApplication
//
//  Created by chao on 2021/3/12.
//  Copyright © 2021 DTiOS. All rights reserved.
//

#import "MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>


@interface MBProgressHUD (ECAdd)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)showText:(NSString *)text toView:(UIView *)view;

+ (void)showActivityIndicatorTitle:(NSString *)title detailTitle:(NSString *)detailTitle toView:(UIView *)view;

+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;


@end

