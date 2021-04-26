//
//  ECPreviewVideoView.m
//  iosProjects
//
//  Created by chao on 2021/4/26.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import "ECPreviewVideoView.h"
#import <AVFoundation/AVFoundation.h>
#import "enum.h"

@interface ECPreviewVideoView ()
{
    AVPlayerLayer *_playerLayer;
    AVPlayerItem *_playerItem;
}
@property (assign, nonatomic) CGFloat currentVideoTimeLength;                             //当前小视频总时长
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation ECPreviewVideoView


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addChildViews];
        [self addLayout];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildViews];
        [self addLayout];
    }
    return self;
}
- (void)addChildViews
{
    [self addSubview:self.finishBtn];
    [self addSubview:self.returnBtn];
}
- (void)setVideoURL:(NSURL *)videoURL
{
    if (videoURL.absoluteString.length > 0) {
        [self playerWith:videoURL];
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addLayout];
}
- (void)addLayout
{
    self.returnBtn.frame = CGRectMake(20,NAVBAR_HEIGHT , 38, 38);
    self.finishBtn.frame = CGRectMake(SCREEN_WIDTH-60-25,SCREEN_HEIGHT - 30-25 , 60, 30);
}
#pragma mark - 初始化播放器
- (void)playerWith:(NSURL *)URL
{
    if (_playerLayer == nil) {
        
        // 2.创建AVPlayerItem
        _playerItem = [AVPlayerItem playerItemWithURL:URL];
        [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
        // 3.创建AVPlayer
        AVPlayer *player = [AVPlayer playerWithPlayerItem:_playerItem];
        // 4.添加AVPlayerLayer
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        playerLayer.backgroundColor = [UIColor clearColor].CGColor;
        playerLayer.frame = self.bounds;
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; //
        [self.layer insertSublayer:playerLayer atIndex:0];
        [player play];
        [self setUpNotification];
        _playerLayer = playerLayer;
    }
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        //取出status的新值
        AVPlayerItemStatus status = [change[NSKeyValueChangeNewKey]intValue];
        switch (status) {
            case AVPlayerItemStatusFailed:
                {
                    
                }
                break;
            case AVPlayerItemStatusReadyToPlay:
                {
                }
                break;
            case AVPlayerItemStatusUnknown:
                {
                    
                }
                break;
                
            default:
                break;
        }
    }
}
// 监听通知
- (void)setUpNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playDidEnd:(NSNotification *)Notification{
    AVPlayerItem*item = [Notification object];

    [item seekToTime:kCMTimeZero completionHandler:nil];
    [_playerLayer.player play];
}
- (void)returnClick:(UIButton *)sender
{
    if (self.closeBlock) {
        self.closeBlock();
    }
}
- (void)saveClick:(UIButton *)sender
{
    if (self.finishBlock) {
        self.finishBlock();
    }
}

- (UIButton *)returnBtn
{
    if (_returnBtn == nil) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setImage:[UIImage imageNamed:@"icon_return_n"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}
- (UIButton *)finishBtn
{
    if (_finishBtn == nil) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_finishBtn setBackgroundColor:[UIColor colorWithRed:28/255.0 green:184/255.0 blue:78/255.0 alpha:1]];
        [_finishBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    _playerItem = nil;
}
@end
