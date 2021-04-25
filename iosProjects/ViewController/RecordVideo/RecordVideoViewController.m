//
//  RecordVideoViewController.m
//  iosProjects
//
//  Created by chao on 2021/4/25.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import "RecordVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ECPreviewView.h"
#import "ECCameraButton.h"
#import "enum.h"

#define START_VIDEO_ANIMATION_DURATION 0.3f                         // 录制视频前的动画时间
#define TIMER_INTERVAL 0.01f                                        // 定时器记录视频间隔
#define VIDEO_RECORDER_MAX_TIME 10.0f                               // 视频最大时长 (单位/秒)
#define VIDEO_RECORDER_MIN_TIME 1.0f                                // 最短视频时长 (单位/秒)
#define START_VIDEO_ANIMATION_DURATION 0.3f                         // 录制视频前的动画时间
#define DEFAULT_VIDEO_ZOOM_FACTOR 3.0f                              // 默认放大倍数

#define VIDEO_FILEPATH                                              @"video"

@interface RecordVideoViewController ()<ECPreviewViewDelegate,AVCaptureAudioDataOutputSampleBufferDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>


@property (nonatomic, strong) AVCaptureSession *captureSession;//捕捉会话
@property (nonatomic, weak)   AVCaptureDeviceInput *activeVideoInput;//输入
@property (nonatomic, strong) AVCaptureStillImageOutput *imageOutput;//
@property (nonatomic, strong) dispatch_queue_t videoQueue;//视频队列
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureAudioDataOutput *audioDataOutput;

@property (nonatomic, strong) AVAssetWriter *assetWriter;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterVideoInput;
@property (nonatomic, strong) AVAssetWriterInput *assetWriterAudioInput;
@property (nonatomic, strong) NSDictionary *videoCompressionSettings;
@property (nonatomic, strong) NSDictionary *audioCompressionSettings;
@property (assign, nonatomic) UIDeviceOrientation shootingOrientation;                 //拍摄中的手机方向
@property (nonatomic, assign) BOOL canWrite;
@property (nonatomic, strong) ECPreviewView *previewView;

@property (assign, nonatomic) Boolean isShooting;//正在拍摄
@property (strong, nonatomic) ECCameraButton *cameraButton;

@property (nonatomic, strong) NSTimer *timer;//记录录制时间
@property (strong, nonatomic) NSURL *videoURL;                                           //视频文件地址

@end

@implementation RecordVideoViewController{
    CGFloat timeLength;             //时间长度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.previewView];
    [self.view addSubview:self.cameraButton];
    
    __weak typeof(self) weakSelf = self;
    [self.cameraButton configureTapCameraButtonEventWithBlock:^(UITapGestureRecognizer * _Nonnull tapGestureRecognizer) {
        [weakSelf takePhotos:tapGestureRecognizer];
    }];
    [self.cameraButton configureLongPressCameraButtonEventWithBlock:^(UILongPressGestureRecognizer * _Nonnull longPressGestureRecognizer) {
        [weakSelf longPressCameraButtonFunc:longPressGestureRecognizer];
    }];
    NSError *error;
    if ([self setupSession:&error]) {
        [self.previewView setSession:self.captureSession];
        self.previewView.delegate = self;
        [self startSession];
    }else
    {
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;
}
- (void)startSession {

    //检查是否处于运行状态
    if (![self.captureSession isRunning]) {
        //使用同步调用会损耗一定的时间，则用异步的方式处理
        dispatch_async(self.videoQueue, ^{
            [self.captureSession startRunning];
        });
    }
}

- (void)stopSession {
    //检查是否处于运行状态
    if (![self.captureSession isRunning]) {
        //使用异步处理 停止运行
        dispatch_async(self.videoQueue, ^{
            [self.captureSession stopRunning];
        });
    }
}

- (BOOL)setupSession:(NSError **)error
{
    self.captureSession = [[AVCaptureSession alloc] init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    
    // 添加摄像头和麦克风设备
    BOOL isVideoOK = [self _addInputWithSession:self.captureSession mediaType:AVMediaTypeVideo error:error];
    BOOL isAudioOK = [self _addInputWithSession:self.captureSession mediaType:AVMediaTypeAudio error:error];
    
    if (!isVideoOK || !isAudioOK) {
        return NO;
    }
    // AVCaptureStillImageOutput 实例 从摄像头捕捉静态图片
    self.imageOutput = [[AVCaptureStillImageOutput alloc] init];
    //配置字典 ：希望捕捉到JPEG格式图片
    self.imageOutput.outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG};
    if ([self.captureSession canAddOutput:self.imageOutput]) {
        [self.captureSession addOutput:self.imageOutput];
    }
    self.videoQueue = dispatch_queue_create("ec.VideoQueue", NULL);
    
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    self.videoDataOutput.alwaysDiscardsLateVideoFrames = YES; //立即丢弃旧帧，节省内存，默认YES
    [self.videoDataOutput setSampleBufferDelegate:self queue:self.videoQueue];
    if ([self.captureSession canAddOutput:self.videoDataOutput])
    {
        [self.captureSession addOutput:self.videoDataOutput];
    }
    
    self.audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    [self.audioDataOutput setSampleBufferDelegate:self queue:self.videoQueue];
    if([self.captureSession canAddOutput:self.audioDataOutput])
    {
        [self.captureSession addOutput:self.audioDataOutput];
    }
    
    
    return YES;
    
}
-(BOOL)_addInputWithSession:(AVCaptureSession *)sesstion mediaType:(AVMediaType)type error:(NSError **)error{
    AVCaptureDevice *device  = [AVCaptureDevice defaultDeviceWithMediaType:type];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:error];
    if (input) {//这里为什么要判断？因为上面的方法都有一个error参数，意思就是有可能返回出错。
        if ([sesstion canAddInput:input]) {
            [sesstion addInput:input];
            if ([type isEqualToString:AVMediaTypeVideo]) {
                self.activeVideoInput = input;
            }
            return YES;
        }
    }
    return NO;
}
- (void)tappedToExposeAtPoint:(CGPoint)point {
    
}

- (void)tappedToFocusAtPoint:(CGPoint)point {
    
}

- (void)tappedToResetFocusAndExposure {
    
}
#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    @autoreleasepool
    {
        //视频
        if (connection == [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo])
        {
            @synchronized(self)
            {
                if (_isShooting)
                {
                    [self appendSampleBuffer:sampleBuffer ofMediaType:AVMediaTypeVideo];
                }
            }
        }
        
        //音频
        if (connection == [self.audioDataOutput connectionWithMediaType:AVMediaTypeAudio])
        {
            @synchronized(self)
            {
                if (_isShooting)
                {
                    [self appendSampleBuffer:sampleBuffer ofMediaType:AVMediaTypeAudio];
                }
            }
        }
    }
}
/**
 *  开始写入数据
 */
- (void)appendSampleBuffer:(CMSampleBufferRef)sampleBuffer ofMediaType:(NSString *)mediaType
{
    if (sampleBuffer == NULL)
    {
        NSLog(@"empty sampleBuffer");
        return;
    }
    
//    CFRetain(sampleBuffer);
//    dispatch_async(self.videoQueue, ^{
        @autoreleasepool
        {
            if (!self.canWrite && mediaType == AVMediaTypeVideo)
            {
                [self.assetWriter startWriting];
                [self.assetWriter startSessionAtSourceTime:CMSampleBufferGetPresentationTimeStamp(sampleBuffer)];
                self.canWrite = YES;
            }
            
            //写入视频数据
            if (mediaType == AVMediaTypeVideo)
            {
                if (self.assetWriterVideoInput.readyForMoreMediaData)
                {
                    BOOL success = [self.assetWriterVideoInput appendSampleBuffer:sampleBuffer];
                    if (!success)
                    {
                        @synchronized (self)
                        {
                            [self stopVideoRecorder];
                        }
                    }
                }
            }
            
            //写入音频数据
            if (mediaType == AVMediaTypeAudio)
            {
                if (self.assetWriterAudioInput.readyForMoreMediaData)
                {
                    BOOL success = [self.assetWriterAudioInput appendSampleBuffer:sampleBuffer];
                    if (!success)
                    {
                        @synchronized (self)
                        {
                            [self stopVideoRecorder];
                        }
                    }
                }
            }
//            CFRelease(sampleBuffer);
        }
//    });
}
#pragma mark - 拍照功能

/**
 *  拍照方法
 */
- (void)takePhotos:(UITapGestureRecognizer *)tapGestureRecognizer
{
    AVCaptureConnection *captureConnection = [self.imageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    [self.imageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer)
        {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            
//            [self previewPhotoWithImage:image];
        }
    }];
}
#pragma mark - 视频录制

/**
 *  录制视频方法
 */
- (void)longPressCameraButtonFunc:(UILongPressGestureRecognizer *)sender
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return;
    }
    
    //判断用户是否允许访问麦克风权限
    authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)
    {
        return;
    }
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self startVideoRecorder];
            break;
        case UIGestureRecognizerStateCancelled:
            [self stopVideoRecorder];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopVideoRecorder];
            break;
        case UIGestureRecognizerStateFailed:
            [self stopVideoRecorder];
            break;
        default:
            break;
    }
}
/**
 *  开始录制视频
 */
- (void)startVideoRecorder
{
    _isShooting = YES;
    [self.cameraButton startShootAnimationWithDuration:START_VIDEO_ANIMATION_DURATION];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(START_VIDEO_ANIMATION_DURATION * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSURL *url = [NSURL fileURLWithPath:[weakSelf createVideoFilePath]];
        self.videoURL = url;
//
        [self setUpWriter];
        
        [weakSelf timerFired];
        
    });
}
/**
 *  结束录制视频
 */
- (void)stopVideoRecorder
{
    if (_isShooting)
    {
        _isShooting = NO;
        self.cameraButton.progressPercentage = 0.0f;
        [self.cameraButton stopShootAnimation];
        [self timerStop];
        
        __weak __typeof(self)weakSelf = self;
        if(_assetWriter && _assetWriter.status == AVAssetWriterStatusWriting)
        {
//            dispatch_async(self.videoQueue, ^{
                [_assetWriter finishWritingWithCompletionHandler:^{
                    weakSelf.canWrite = NO;
                    weakSelf.assetWriter = nil;
                    weakSelf.assetWriterAudioInput = nil;
                    weakSelf.assetWriterVideoInput = nil;
                }];
//            });
        }
        if (timeLength < VIDEO_RECORDER_MIN_TIME)
        {
            return;
        }
        
        [self.cameraButton setHidden:YES];
        
    }
}
/**
 *  设置写入视频属性
 */
- (void)setUpWriter
{
    if (self.videoURL == nil)
    {
        return;
    }
    self.assetWriter = [AVAssetWriter assetWriterWithURL:self.videoURL fileType:AVFileTypeMPEG4 error:nil];
    //写入视频大小
    NSInteger numPixels = SCREEN_WIDTH * SCREEN_HEIGHT;
    
    //每像素比特
    CGFloat bitsPerPixel = 12.0;
    NSInteger bitsPerSecond = numPixels * bitsPerPixel;
    
    // 码率和帧率设置
    NSDictionary *compressionProperties = @{ AVVideoAverageBitRateKey : @(bitsPerSecond),
                                             AVVideoExpectedSourceFrameRateKey : @(15),
                                             AVVideoMaxKeyFrameIntervalKey : @(15),
                                             AVVideoProfileLevelKey : AVVideoProfileLevelH264BaselineAutoLevel };
    CGFloat width = SCREEN_HEIGHT;
    CGFloat height = SCREEN_WIDTH;
    if (IS_IPhoneX)
    {
        width = SCREEN_HEIGHT - 146;
        height = SCREEN_WIDTH;
    }
    //视频属性
    self.videoCompressionSettings = @{ AVVideoCodecKey : AVVideoCodecH264,
                                       AVVideoWidthKey : @(width * 2),
                                       AVVideoHeightKey : @(height * 2),
                                       AVVideoScalingModeKey : AVVideoScalingModeResizeAspectFill,
                                       AVVideoCompressionPropertiesKey : compressionProperties };
    
    _assetWriterVideoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:self.videoCompressionSettings];
    //expectsMediaDataInRealTime 必须设为yes，需要从capture session 实时获取数据
    _assetWriterVideoInput.expectsMediaDataInRealTime = YES;
    
    if (self.shootingOrientation == UIDeviceOrientationLandscapeRight)
    {
        _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(M_PI);
    }
    else if (self.shootingOrientation == UIDeviceOrientationLandscapeLeft)
    {
        _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(0);
    }
    else if (self.shootingOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(M_PI + (M_PI / 2.0));
    }
    else
    {
        _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
    }
    
    // 音频设置
    self.audioCompressionSettings = @{ AVEncoderBitRatePerChannelKey : @(28000),
                                       AVFormatIDKey : @(kAudioFormatMPEG4AAC),
                                       AVNumberOfChannelsKey : @(1),
                                       AVSampleRateKey : @(22050) };
    
    _assetWriterAudioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:self.audioCompressionSettings];
    _assetWriterAudioInput.expectsMediaDataInRealTime = YES;
    
    if ([_assetWriter canAddInput:_assetWriterVideoInput])
    {
        [_assetWriter addInput:_assetWriterVideoInput];
    }
    else
    {
        NSLog(@"AssetWriter videoInput append Failed");
    }
    
    if ([_assetWriter canAddInput:_assetWriterAudioInput])
    {
        [_assetWriter addInput:_assetWriterAudioInput];
    }
    else
    {
        NSLog(@"AssetWriter audioInput Append Failed");
    }
    
    _canWrite = NO;
    
}
/**
 *  绿色转圈百分比计算
 */
- (void)timerRecord
{
    if (!_isShooting)
    {
        [self timerStop];
        return ;
    }
    
    // 时间大于VIDEO_RECORDER_MAX_TIME则停止录制
    if (timeLength > VIDEO_RECORDER_MAX_TIME)
    {
        [self stopVideoRecorder];
    }
    
    timeLength += TIMER_INTERVAL;
    
    //    NSLog(@"%lf", timeLength / VIDEO_RECORDER_MAX_TIME);
    
    self.cameraButton.progressPercentage = timeLength / VIDEO_RECORDER_MAX_TIME;
    
}
/**
 *  停止定时器
 */
- (void)timerStop
{
    if ([self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (NSString *)createVideoFilePath
{
    // 创建视频文件的存储路径
    NSString *filePath = [self createVideoFolderPath];
    if (filePath == nil)
    {
        return nil;
    }
    
    NSString *videoType = @".mp4";
    NSString *videoDestDateString = [self createFileNamePrefix];
    NSString *videoFileName = [videoDestDateString stringByAppendingString:videoType];
    
    NSUInteger idx = 1;
    /*We only allow 10000 same file name*/
    NSString *finalPath = [NSString stringWithFormat:@"%@/%@", filePath, videoFileName];
    
    while (idx % 10000 && [[NSFileManager defaultManager] fileExistsAtPath:finalPath])
    {
        finalPath = [NSString stringWithFormat:@"%@/%@_(%lu)%@", filePath, videoDestDateString, (unsigned long)idx++, videoType];
    }
    
    return finalPath;
}

- (NSString *)createVideoFolderPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *homePath = NSHomeDirectory();
    
    NSString *tmpFilePath;
    
    if (homePath.length > 0)
    {
        NSString *documentPath = [homePath stringByAppendingString:@"/Documents"];
        if ([fileManager fileExistsAtPath:documentPath isDirectory:NULL] == YES)
        {
            BOOL success = NO;
            
            NSArray *paths = [fileManager contentsOfDirectoryAtPath:documentPath error:nil];
            
            //offline file folder
            tmpFilePath = [documentPath stringByAppendingString:[NSString stringWithFormat:@"/%@", VIDEO_FILEPATH]];
            if ([paths containsObject:VIDEO_FILEPATH] == NO)
            {
                success = [fileManager createDirectoryAtPath:tmpFilePath withIntermediateDirectories:YES attributes:nil error:nil];
                if (!success)
                {
                    tmpFilePath = nil;
                }
            }
            return tmpFilePath;
        }
    }
    
    return false;
}
/**
 *  创建文件名
 */
- (NSString *)createFileNamePrefix
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    destDateString = [destDateString stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    destDateString = [destDateString stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    destDateString = [destDateString stringByReplacingOccurrencesOfString:@":" withString:@"-"];
    
    return destDateString;
}
- (ECPreviewView *)previewView
{
    if (_previewView)
        return _previewView;
    _previewView = [[ECPreviewView alloc] initWithFrame:self.view.bounds];
    return _previewView;
}
- (ECCameraButton *)cameraButton
{
    if (_cameraButton) {
        return _cameraButton;
    }
    _cameraButton = [ECCameraButton defaultCameraButton];
    CGFloat cameraBtnX = (SCREEN_WIDTH - _cameraButton.bounds.size.width) / 2;
    CGFloat cameraBtnY = SCREEN_HEIGHT - _cameraButton.bounds.size.height - 60 - SafeViewBottomHeight;    //距离底部60
    _cameraButton.frame = CGRectMake(cameraBtnX, cameraBtnY, _cameraButton.bounds.size.width, _cameraButton.bounds.size.height);
    return _cameraButton;
}
/**
 *  开启定时器
 */
- (void)timerFired
{
    timeLength = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
}
@end
