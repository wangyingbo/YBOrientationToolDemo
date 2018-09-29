//
//  OrientationTool.h
//  FBSmartBI
//
//  Created by 王迎博 on 2018/9/27.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UINavigationController+Autorotate.h"
#import "UITabBarController+Autorotate.h"

/**
 屏幕方向的枚举值，可增加
 */
typedef NS_ENUM(NSUInteger, YBOrientationType) {
    /**竖向*/
    YBOrientationMaskPortrait = 0,
    /**自适应*/
    YBOrientationMaskAll,
};

@interface OrientationTool : NSObject

#pragma mark - singltonInstance
+ (instancetype)sharedInstance;

#pragma mark - public

/**
 设置默认的旋转方向

 @param orientationMask 方向
 */
+ (void)setDefaultOrientationMask:(UIInterfaceOrientationMask)orientationMask;

/**
 取默认的旋转方向

 @return 默认方向
 */
+ (UIInterfaceOrientationMask)getDefaultOrientationMask;

/**
 屏幕方向

 @return 返回屏幕方向的值
 */
+ (NSUInteger)getOrientationType;

/**
 屏幕方向自适应
 */
+ (void)orientationMaskAll;

/**
 屏幕方向竖向
 */
+ (void)orientationMaskPortrait;

@end
