//
//  DYRZResultBean.h
//  DYRZ
//
//  Created by lic&z on 2017/5/8.
//  Copyright © 2017年 lic&z. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYRZResultBean : NSObject

@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSString *msg;
@property (assign, nonatomic) NSInteger authType;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *data;

@end
