//
//  SilentLivenessState.hpp
//  yt-ios-verification-sdk
//
//  Created by Marx Wang on 2019/9/5.
//  Copyright © 2019 Tencent.Youtu. All rights reserved.
//

#pragma once
#import <YtSDKKitFramework/YtFSMState.h>
#include <vector>

//遮挡判断
typedef enum  {
    YT_SHELTER_PARAM_ERROR = -2,
    YT_SHELTER_PARAM_NULL = -1,
    YT_SHELTER_PASS = 0,
    YT_SHELTER_LEFTFACE = 1,
    YT_SHELTER_CHIN = 2,
    YT_SHELTER_MOUTH = 3,
    YT_SHELTER_RIGHTFACE = 4,
    YT_SHELTER_NOSE = 5,
    YT_SHELTER_RIGHTEYE = 6,
    YT_SHELTER_LEFTEYE = 7,
}YtShelterJudge;

typedef enum {
    YT_ADVISE_PASS = 0,                //当前位置在所选框中
    YT_ADVISE_NO_FACE = 1,             //没有人脸
    YT_ADVISE_TOO_FAR = 2,             //人脸距离太远
    YT_ADVISE_TOO_CLOSE = 3,           //人脸距离太近
    YT_ADVISE_NOT_IN_RECT = 4,         //不在指定的框中
    YT_ADVISE_INCORRECT_POSTURE = 5,   //不是正脸，如左右歪、上下歪、左右看
    YT_ADVISE_CLOSE_EYE = 7,           //闭眼了
    YT_ADVISE_TOO_MANY_FACE = 8,
    YT_ADVISE_INCOMPLETE_FACE = 9,
    YT_ADVISE_INBUFFER_PASS = 10,
    YT_ADVISE_COUNT = 11
}YtFacePreviewingAdvise;

struct YtFaceStatus {
    int x;
    int y;
    int h;
    int w;
    float pitch;
    float yaw;
    float roll;
    int illuminiationScore;
    float leftEyeOpenScore;
    float rightEyeOpenScore;
    float mouthOpenScore;
    std::vector<float> landmark;
    std::vector<float> landmarkVis;
};


YT_SDK_EXPORT @interface SilentLivenessState : BaseState
-(BOOL)updateParam:(NSString*)paramName withValue:(id)value;
-(id)getParam:(NSString*)paramName;
+ (NSString *)parseAdvise:(int)advise;
@end
