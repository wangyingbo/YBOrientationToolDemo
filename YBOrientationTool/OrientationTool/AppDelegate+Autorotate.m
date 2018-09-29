//
//  AppDelegate+Autorotate.m
//  FBSmartBI
//
//  Created by 王迎博 on 2018/9/27.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import "AppDelegate+Autorotate.h"
#import "OrientationTool.h"

@implementation AppDelegate (Autorotate)

#pragma mark - 支持横竖屏
//此方法会在设备横竖屏变化的时候系统会调用
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if ([OrientationTool getOrientationType] == YBOrientationMaskAll) {
        return UIInterfaceOrientationMaskAll;
    } else {
        if ([OrientationTool getDefaultOrientationMask]>0) {
            return [OrientationTool getDefaultOrientationMask];
        }
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
