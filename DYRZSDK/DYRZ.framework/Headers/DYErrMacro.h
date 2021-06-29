//
//  DYErrMacro.h
//  DYRZ
//
//  Created by lic&z on 2019/8/6.
//  Copyright © 2019 lic&z. All rights reserved.
//

#ifndef DYErrMacro_h
#define DYErrMacro_h

#define AUTH_SUCCESS                            0           // 认证成功
#define AUTH_CANCEL                             1           // 认证取消
#define PARAM_ERR                               2           // 参数错误

#define APP_INIT_ERR                            1001        // 初始化错误
#define AUTH_MOBILE_ERR                         1002        // 手机号认证错误
#define AUTH_BANK_ERR                           1003        // 银行卡认证错误
#define AUTH_FACE_ERR                           1004        // 人脸识别认证错误
#define AUTH_TOKEN_ERR                          1005        // 获取token错误
#define AUTH_EID_ERR                            1006        // EID认证错误
#define AUTH_ALIPAY_ERR                         1007        // 支付宝认证错误
#define AUTH_ESHIMIN_ERR                        1009        // 市民云认证错误
#define AUTH_FACE_ALIPAY_ERR                    1010        // 支付宝人脸识别认证错误
#define AUTH_WECHAT_EZT_ERR                     1011        // 腾讯E证通认证错误

#define VERIFY_SIGN_ERR                         2002        // 验签错误
#define PROCESS_ERR                             2003        // 进程错误
#define INPUT_INFO_ERR                          2004        // 输入错误
#define APP_INIT_STOP_ERR                       2005        // 商户停用
#define APP_ITEM_NOT_FIND_ERR                   2006        // 认证未授权
#define OPEN_ENVELOP_ERR                        2007        // 解数字信封错误
#define COMPARISON_ERR                          2008        // 身份比对错误
#define FACE_CHECK_ERR                          2009        // 人脸检测失败
#define FACE_LIVE_ERR                           2010        // 活体检测失败
#define SIGN_ERR                                2011        // 签名错误
#define WECHAT_CANCAL_ERR                       2012        // 微信取消错误
#define WECHAT_DENIED_ERR                       2013        // 微信拒绝错误

#define NET_ERR                                 3001        // 网络错误
#define JSON_ERR                                3003        // json错误

#define AUTH_VERIFY_MATCH_ERR                   5000        // 比对不一致
#define AUTH_VERIFY_NAME_ID_MATCH_ERR           5001        // 身份证号姓名不一致
#define AUTH_VERIFY_NOT_FINE_DATA_ERR           5002        // 未查询到数据
#define AUTH_VERIFY_USER_MATCH_NOT_PHOTO_ERR    5003        // 身份比对一致，库中无照片
#define AUTH_VERIFY_BANK_PHONE_ERR              5004        // 银行卡号一致，手机号不一致
#define AUTH_VERIFY_BANK_INVALID_ERR            5005        // 无效银行卡
#define AUTH_VERIFY_PHONE_INVALID_ERR           5006        // 无效手机号
#define AUTH_VERIFY_FACE_MATCH_ERR              5007        // 人脸识别比对不一致
#define AUTH_VERIFY_NOT_AUTH_ERR                5008        // 未实名
#define AUTH_VERIFY_AUTH_ERR                    5009        // 比对失败（或认证失败）
#define AUTH_VERIFY_DETECT_MULTIPLE_FACE_ERR    5010        // 人脸识别检测多张人脸
#define AUTH_VERIFY_FACE_SIMILAR_LOW_ERR        5011        // 人脸识别相识度低
#define AUTH_VERIFY_SAVE_FAIL_ERR               5012        // 保存失败
#define AUTH_VERIFY_NOT_VERIFY_ERR              5013        // 无法验证
#define AUTH_VERIFY_ID_FORMAT_ERR               5014        // 证件号格式错误
#define AUTH_VERIFY_ID_FORMAT_INVALID_ERR       5015        // 证件号格式失效
#define AUTH_VERIFY_NO_QUERY_RESULT_ERR         5016        // 暂无查询结果
#define AUTH_VERIFY_DETECT_FACE_ERR             5017        // 检测人脸失败

#define INTERFACE_AUTH_FAIL_ERR                 6000        // 鉴权失败
#define INTERFACE_INVALID_TRANSACTION_ERR       6001        // 业务流水号不正确
#define INTERFACE_INVALID_ARRANGEMENT_ERR       6002        // 无有效合约
#define INTERFACE_INVALID_OPENID_ERR            6003        // open_id参数错误
#define INTERFACE_INVALID_PARAM_ERR             6004        // 参数错误
#define INTERFACE_SYSTEM_ERR                    6005        // 系统错误
#define INTERFACE_TRANSACTION_EXPIRED_ERR       6006        // 业务流水号已过期

#define SYS_MISS_TEMPLATE_PARAM_ERR             7000        // 缺少授权模板参数
#define SYS_INVOKE_EXCESS_LIMITATION_ERR        7001        // 应用调用服务次数超限
#define SYS_INVOKE_ISP_ERR                      7002        // 调用服务接口错误
#define SYS_INVOKE_OPENID_ERR                   7003        // 无效的open_id参数
#define SYS_CACHE_PAGE_PARAM_ERR                7004        // 缓存签名参数错误
#define SYS_SIGN_SYSTEM_PARAM_ERR               7005        // 服务平台私钥加签返回结果错误
#define SYS_SIGN_PAGE_PARAM_ERR                 7006        // 服务平台私钥加签页面参数错误
#define SYS_VERIFY_SIGN_ERR                     7007        // 用商户公钥验签错误
#define SYS_DECODE_PRIKEY_ERR                   7008        // 服务平台私钥解密错误
#define SYS_MISSING_INTERFACE_CONFIG_ERR        7009        // 缺少对应的接口配置信息
#define SYS_INVALID_CHARSET_PARAM_ERR           7010        // 无效charset参数
#define SYS_MISSING_CHARSET_PARAM_ERR           7011        // 缺少charset参数
#define SYS_MISSING_SIGN_PARAM_ERR              7012        // 缺少sign参数
#define SYS_MISSING_PARAMS_PARAM_ERR            7013        // 缺少params参数
#define SYS_INVALID_CHANNEL_PARAM_ERR           7014        // 无效的channel参数
#define SYS_INVALID_APP_STATUS_ERR              7015        // 应用生命周期状态错误
#define SYS_INVALID_RUNTIME_STATE_ERR           7016        // 应用运行状态错误
#define SYS_INVALID_PLATFORM_APPID_ERR          7017        // 无效的渠道商app_id参数
#define SYS_MISSING_PLATFORM_APPID_ERR          7018        // 缺少渠道商的app_id参数
#define SYS_UNKNOW_ERR                          7019        // 未知错误
#define SYS_INVALID_APPID_PARAM_ERR             7020        // 无效的app_id参数
#define SYS_MISSING_APPID_PARAM_ERR             7021        // 缺少app_id参数
#define SYS_TOKEN_INVALID_ERR                   7022        // token已经失效
#define SYS_USER_NOT_REGIST_ERR                 7023        // 用户未注册
#define SYS_OTHER_ERR                           7024        // 其它错误

#define SDK_AUTH_PROCESS                        10000       // 正在认证中

// 人脸识别商业库SDK错误码(参考https://cloud.tencent.com/document/product/1007/35877)
// 人脸识别商业库风控SDK错误码(参考https://cloud.tencent.com/document/product/1007/47912)
#define FACE_SDK_BUSSINESS_BASE_ERR             100000      // 光线人脸识别
#define FACE_PERMISSIONS_NOT_ERR                FACE_SDK_BUSSINESS_BASE_ERR + 42002    // 权限异常，未获取权限
#define FACE_CAMERA_ERR                         FACE_SDK_BUSSINESS_BASE_ERR + 42003    // 相机运行中出错
#define FACE_RECORD_ERR                         FACE_SDK_BUSSINESS_BASE_ERR + 42004    // 视频录制中出错
#define FACE_GET_IMAGE_ERR                      FACE_SDK_BUSSINESS_BASE_ERR + 42005    // 请勿晃动人脸，保持姿势
#define FACE_VIDEO_SAMLL_ERR                    FACE_SDK_BUSSINESS_BASE_ERR + 42006    // 视频大小不满足要求
#define FACE_TIMEOUT_ERR                        FACE_SDK_BUSSINESS_BASE_ERR + 42007    // 超时
#define FACE_OUTSIDE_ERR                        FACE_SDK_BUSSINESS_BASE_ERR + 42008    // 检测中人脸移出框外
#define FACE_LOCAL_ERR                          FACE_SDK_BUSSINESS_BASE_ERR + 42009    // 光线活体本地错误
#define FACE_SAFE_ERR                           FACE_SDK_BUSSINESS_BASE_ERR + 42010    // 风险控制超出次数
#define FACE_NUMBER_NOT_ERR                     FACE_SDK_BUSSINESS_BASE_ERR + 42011    // 没有检测到读数声音
#define FACE_SDK_BUSSINESS_OTHER_ERR            FACE_SDK_BUSSINESS_BASE_ERR + 50000    // 其它错误


#endif /* DYErrMacro_h */
