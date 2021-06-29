//
//  YtUtil.h
//  yt-ios-verification
//
//  Created by marxwang(王小松) on 2020/5/18.
//  Copyright © 2020 Tecnet.Youtu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#pragma once
#ifndef WeakRef
#define WeakRef(weakVar, strongVar) __weak __typeof(&*strongVar) weakVar = strongVar
#endif
#ifndef WeakSelf
#define WeakSelf() WeakRef(weakSelf, self)
#endif
#ifndef StrongRef
#define StrongRef(strongVar, weakVar) __strong __typeof(&*weakVar) strongVar = weakVar
#endif
#ifndef StrongSelf
#define StrongSelf() StrongRef(strongSelf,weakSelf)
#endif

@interface YtUtil : NSObject
+ (uint64_t)nowMs;
+ (uint64_t)nowUs;
+ (NSString *)encodeBase64:(NSData *)data;
+ (NSString *)checksum:(NSData *)jpegData;
+ (UIImage *)UIImageWithCVMat:(void *)frameMat;
+ (NSString*)getBase64Image:(UIImage*)frameUIImage;
@end
