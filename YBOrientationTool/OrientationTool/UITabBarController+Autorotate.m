//
//  UITabBarController+Autorotate.m
//  FBSmartBI
//
//  Created by 王迎博 on 2018/9/27.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import "UITabBarController+Autorotate.h"

@implementation UITabBarController (Autorotate)

- (BOOL)shouldAutorotate
{
    //是否允许转屏
    return [self.selectedViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    //所支持的全部旋转方向
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    //初始化方向
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
