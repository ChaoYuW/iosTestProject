//
//  YtSDKStats.h
//  yt-ios-verification
//
//  Created by marxwang(王小松) on 2020/7/30.
//  Copyright © 2020 Tecnet.Youtu. All rights reserved.
//

#pragma once
#import <Foundation/Foundation.h>
#import <YtSDKKitFramework/YtSDKCommonDefines.h>
@interface YtSDKStats : NSObject
{
    
}
@property (nonatomic, copy) OnYtFrameworkEventBlock onEventBlock;
+ (instancetype)sharedInstance;
+ (void)clearInstance;
- (void)registerStateName:(NSString *)stateName;
- (void)enterState:(NSString *)stateName;
- (void)updateState:(NSString *)stateName;
- (void)exitState;
- (void)reportError:(int)errorCode message:(NSString *)errorMessage;
- (void)reportInfo:(NSString *)infoMessage;
- (void)resetState;
@end
