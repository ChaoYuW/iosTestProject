//
//  enum.h
//  iosProjects
//
//  Created by QLMAC on 2018/4/3.
//  Copyright © 2018年 ChaoYuW. All rights reserved.
//

#ifndef enum_h
#define enum_h


typedef enum{
    ControllerTypeUI,
    ControllerTypeView,
    
}ControllerType;

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define NAVBAR_HEIGHT       (IS_IPhoneX ? 88.0f : 64.0f)
#define TABBAR_HEIGHT       (IS_IPhoneX ? 83.0f : 49.0f)

#define SafeViewBottomHeight (IS_IPhoneX ? 34.0f : 0.0f)

#endif /* enum_h */
