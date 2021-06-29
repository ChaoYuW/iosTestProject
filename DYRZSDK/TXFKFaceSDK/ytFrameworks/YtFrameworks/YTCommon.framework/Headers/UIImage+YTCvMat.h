#import <UIKit/UIKit.h>
#import "YTMacro.h"
#import <CoreMedia/CoreMedia.h>

#if IncludeUImageCvMat

#import <opencv2/opencv.hpp>

@interface UIImage (YTCvMat)

#pragma mark - UIImage to cv::Mat
- (cv::Mat)yt_mat;   //rgba
//-(cv::Mat)yt_rgbMat;  //not valud, please use yt_mat and then cvtColor
- (cv::Mat)yt_grayMat;

#pragma mark - cv::Mat to UIImage
+ (UIImage *)yt_imageWithCVMat:(const cv::Mat&)cvMat;
+ (UIImage *)yt_imageWithCVMatBGRA:(const cv::Mat&)cvMat;

#pragma mark - CMBuffer to cv::Mat
+ (cv::Mat)yt_bgraMatFromBuffer:(CMSampleBufferRef)buffer;
+ (UIImage *)yt_imageFromSampleBuffer:(CMSampleBufferRef) buffer;

#pragma mark - Deprecated Interface
// @deprecated use yt_mat instead
-(cv::Mat)getCVMat __attribute__((deprecated));
// @deprecated use yt_rgbMat instead
-(cv::Mat)getCVRGBMat __attribute__((deprecated));
// @deprecated use yt_grayMat instead
-(cv::Mat)getCVGrayscaleMat __attribute__((deprecated));
// @deprecated use yt_imageWithCVMat instead
+ (UIImage *)initWithCVMat:(const cv::Mat&)cvMat __attribute__((deprecated));


@end

#endif
