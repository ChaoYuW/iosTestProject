//
//  ECPreviewImageView.m
//  iosProjects
//
//  Created by chao on 2021/4/26.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import "ECPreviewImageView.h"
#import "enum.h"

@interface ECPreviewImageView ()

@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *finishBtn;

@end

@implementation ECPreviewImageView

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
    [self addSubview:self.imageView];
    [self addSubview:self.returnBtn];
    [self addSubview:self.finishBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addLayout];
}
- (void)addLayout
{
    self.returnBtn.frame = CGRectMake(20,NAVBAR_HEIGHT , 38, 38);
    self.imageView.frame = self.bounds;
    self.finishBtn.frame = CGRectMake(SCREEN_WIDTH-60-25,SCREEN_HEIGHT - 30-25 , 60, 30);
}
- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
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
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = UIImageView.new;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
@end
