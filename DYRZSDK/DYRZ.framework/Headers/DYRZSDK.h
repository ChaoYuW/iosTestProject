//
//  DYRZSDK.h
//  DYRZ
//
//  Created by lic&z on 2017/8/30.
//  Copyright © 2017年 lic&z. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <DYRZ/DYRZResultBean.h>

typedef NS_ENUM(NSInteger, BUILD)
{
    BUILD_DEBUG = 1,
    BUILD_RELEASE
};

@interface DYRZSDK : NSObject

/**
 多源认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)dyrzAuth:(NSString *)appID
          appKey:(NSString *)appKey
           build:(BUILD)build
   transactionId:(NSString *)transactionId
     resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;



/**
 手机号认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param mobileNo 手机号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)mobileAuth:(NSString *)appID
            appKey:(NSString *)appKey
             build:(BUILD)build
              name:(NSString *)name
              idNo:(NSString *)idNo
        mobileNo:(NSString *)mobileNo
     transactionId:(NSString *)transactionId
       resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;



/**
 银行卡认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param mobileNo 手机号
 @param bankNo 银行卡号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)bankAuth:(NSString *)appID
          appKey:(NSString *)appKey
           build:(BUILD)build
            name:(NSString *)name
            idNo:(NSString *)idNo
        mobileNo:(NSString *)mobileNo
          bankNo:(NSString *)bankNo
   transactionId:(NSString *)transactionId
     resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 人脸识别认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param controller 视图
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)faceAuth:(NSString *)appID
          appKey:(NSString *)appKey
           build:(BUILD)build
            name:(NSString *)name
            idNo:(NSString *)idNo
      controller:(UIViewController *)controller
   transactionId:(NSString *)transactionId
     resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 人脸识别商业库认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)faceBusinessAuth:(NSString *)appID
                  appKey:(NSString *)appKey
                   build:(BUILD)build
                    name:(NSString *)name
                    idNo:(NSString *)idNo
           transactionId:(NSString *)transactionId
             resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 人脸识别商业库风控认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)faceBusinessFKAuth:(NSString *)appID
                    appKey:(NSString *)appKey
                     build:(BUILD)build
                      name:(NSString *)name
                      idNo:(NSString *)idNo
             transactionId:(NSString *)transactionId
               resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 支付宝认证设置跳转APP的URLSchemes
 @param scheme  app注册在info.plist中的scheme
 */
+ (void)alipayAuthSetUrlSchemes:(NSString *)scheme;

/**
 支付宝认证设置HandleOpenURL
 @param url 支付宝返回的url
 */
+ (void)alipayAuthHandleOpenURL:(NSURL *)url;

/**
 支付宝认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)ailPayAuth:(NSString *)appID
            appKey:(NSString *)appKey
             build:(BUILD)build
     transactionId:(NSString *)transactionId
       resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 支付宝认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)ailPayAuth:(NSString *)appID
            appKey:(NSString *)appKey
             build:(BUILD)build
              name:(NSString *)name
              idNo:(NSString *)idNo
     transactionId:(NSString *)transactionId
       resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 人脸识别和支付宝组合认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param controller 视图
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)faceWithAilpayAuth:(NSString *)appID
                    appKey:(NSString *)appKey
                     build:(BUILD)build
                      name:(NSString *)name
                      idNo:(NSString *)idNo
                controller:(UIViewController *)controller
             transactionId:(NSString *)transactionId
               resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;

/**
 三要素认证
 @param appID 应用标识
 @param appKey 应用密钥
 @param build 编译版本    BUILD_DEBUG:调试版本  BUILD_RELEASE:发布版本
 @param name 姓名
 @param idNo 身份证号
 @param transactionId 请求标识
 @param resultBlock 返回数据
 */
+ (void)userInfoAuth:(NSString *)appID
              appKey:(NSString *)appKey
               build:(BUILD)build
                name:(NSString *)name
                idNo:(NSString *)idNo
       transactionId:(NSString *)transactionId
         resultBlock:(void (^)(DYRZResultBean *resultBean)) resultBlock;


@end
