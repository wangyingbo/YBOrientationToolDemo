//
//  UINavigationController+Autorotate.m
//  FBSmartBI
//
//  Created by 王迎博 on 2018/9/27.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import "UINavigationController+Autorotate.h"

@implementation UINavigationController (Autorotate)

- (BOOL)shouldAutorotate
{
    return [self.topViewController shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations
{
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}


@end
