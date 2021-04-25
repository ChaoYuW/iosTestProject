//
//  ECPreviewView.h
//  iosProjects
//
//  Created by chao on 2021/4/25.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ECPreviewViewDelegate <NSObject>
- (void)tappedToFocusAtPoint:(CGPoint)point;//聚焦
- (void)tappedToExposeAtPoint:(CGPoint)point;//曝光
- (void)tappedToResetFocusAndExposure;//点击重置聚焦曝光
@end

@interface ECPreviewView : UIView

//session用来关联AVCaptureVideoPreviewLayer 和 激活 AVCaptureSession
@property (strong, nonatomic) AVCaptureSession *session;
@property (weak, nonatomic) id<ECPreviewViewDelegate> delegate;

@property (nonatomic) BOOL tapToFocusEnabled;//是否聚焦
@property (nonatomic) BOOL tapToExposeEnabled;//是否曝光

@end

NS_ASSUME_NONNULL_END
