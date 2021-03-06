//
//  ECPreviewImageView.h
//  iosProjects
//
//  Created by chao on 2021/4/26.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^CloseBlock)(void);
typedef void (^FinishBlock) (void);

@interface ECPreviewImageView : UIView



@property (nonatomic, copy) CloseBlock closeBlock;
@property (nonatomic, copy) FinishBlock finishBlock;
@property (nonatomic, strong) UIImage *image;

@end

NS_ASSUME_NONNULL_END
