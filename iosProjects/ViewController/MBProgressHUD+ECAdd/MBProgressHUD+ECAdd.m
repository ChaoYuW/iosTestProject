//
//  MBProgressHUD+ECAdd.m
//  StandardApplication
//
//  Created by chao on 2021/3/12.
//  Copyright © 2021 DTiOS. All rights reserved.
//

#import "MBProgressHUD+ECAdd.h"


@implementation MBProgressHUD (ECAdd)


/**
 *  =======显示 提示信息
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}
/**
 *  =======显示
 *  @param success 信息内容
 */
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
/**
 *  =======显示错误信息
 */
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}
/**
 *  显示提示 + 菊花
 *  @param message 信息内容
 *  @return 直接返回一个MBProgressHUD， 需要手动关闭(  ?
 */
+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}
/**
 *  显示一些信息
 *  @param message 信息内容
 *  @param view    需要显示信息的视图
 *  @return 直接返回一个MBProgressHUD，需要手动关闭
 */
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = YES;
    
    return hud;
}
+ (void)showText:(NSString *)text toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);

    [hud hideAnimated:YES afterDelay:3.f];
}
+ (void)showActivityIndicatorTitle:(NSString *)title detailTitle:(NSString *)detailTitle toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (title != nil) {
        hud.label.text = title;
    }
    if (detailTitle != nil) {
        hud.detailsLabel.text = detailTitle;
    }
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        sleep(3.);
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
    });
}
/**
 *  手动关闭MBProgressHUD
 */
+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
/**
 *  @param view    显示MBProgressHUD的视图
 */
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    
    [self hideHUDForView:view animated:YES];
}


/**
 *  =======显示信息
 *  @param text 信息内容
 *  @param icon 图标
 *  @param view 显示的视图
 */
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = text;
    hud.square = YES;
    hud.label.font = [UIFont systemFontOfSize:17.0];
    hud.userInteractionEnabled= NO;
//    hud.bezelView.backgroundColor = UIColor.grayColor;    //背景颜色
    UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:image];
    
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}



@end
