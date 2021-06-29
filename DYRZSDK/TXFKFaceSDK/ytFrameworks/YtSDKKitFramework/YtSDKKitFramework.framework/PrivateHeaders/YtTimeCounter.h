//
//  YtTimeCounter.h
//  YtSDKKitFramework
//
//  Created by marxwang(王小松) on 2020/8/18.
//  Copyright © 2020 Tecnet.Youtu. All rights reserved.
//

#ifndef YtTimeCounter_h
#define YtTimeCounter_h
#import <Foundation/Foundation.h>
@interface YtTimerCounter  : NSObject
{
    uint64_t elaspeTimeMs;
    uint64_t targetTimeoutMs;
    BOOL needTimer;
    NSString *name;
    BOOL needShowTimer;
}
-(instancetype)initWith:(uint64_t) timeoutMS withName:(NSString *)timerName withTips:(BOOL)needShow;
-(void)start;
-(void)reset;
-(BOOL)checkTimeout;
-(void)cancel;
-(BOOL)isWorking;
@end


#endif /* YtTimeCounter_h */
