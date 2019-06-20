//
//  OrientationTool.m
//  FBSmartBI
//
//  Created by 王迎博 on 2018/9/27.
//  Copyright © 2018年 com.fengbangstore. All rights reserved.
//

#import "OrientationTool.h"
#import <libkern/OSAtomic.h>
#import <CoreMotion/CoreMotion.h>

@interface OrientationTool ()
/**默认旋转方向*/
@property (nonatomic, assign) UIInterfaceOrientationMask orientationMask;
@property (nonatomic, assign) NSInteger allowRotate;
@property (nonatomic, strong) CMMotionManager *cmmotionManager;
@end

/**检测最大次数，自增*/
static int32_t _t_32_accelerometer = 0;
/**the max number which cmmotionManager can update*/
static NSInteger const kMaxAccelerometerUpdatesNumber = 3;

@implementation OrientationTool

#pragma mark - singltonInstance
+(instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public
+ (void)setDefaultOrientationMask:(UIInterfaceOrientationMask)orientationMask {
    [OrientationTool sharedInstance].orientationMask = orientationMask;
}

+ (UIInterfaceOrientationMask)getDefaultOrientationMask {
    return [OrientationTool sharedInstance].orientationMask;
}

+ (NSUInteger)getOrientationType {
    return [OrientationTool sharedInstance].allowRotate;
}


/**
 typedef NS_ENUM(NSInteger, UIDeviceOrientation) {
 UIDeviceOrientationUnknown,
 UIDeviceOrientationPortrait,            // Home按钮在下
 UIDeviceOrientationPortraitUpsideDown,  // Home按钮在上
 UIDeviceOrientationLandscapeLeft,       // Home按钮右
 UIDeviceOrientationLandscapeRight,      // Home按钮左
 UIDeviceOrientationFaceUp,              // 手机平躺，屏幕朝上
 UIDeviceOrientationFaceDown             //手机平躺，屏幕朝下
 } __TVOS_PROHIBITED;
 
 typedef NS_ENUM(NSInteger, UIInterfaceOrientation) {
 UIInterfaceOrientationUnknown            = UIDeviceOrientationUnknown,
 UIInterfaceOrientationPortrait           = UIDeviceOrientationPortrait,
 UIInterfaceOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
 UIInterfaceOrientationLandscapeLeft      = UIDeviceOrientationLandscapeRight,
 UIInterfaceOrientationLandscapeRight     = UIDeviceOrientationLandscapeLeft
 } __TVOS_PROHIBITED;
 
 */
+ (void)orientationMaskAll {
    [OrientationTool sharedInstance].allowRotate = YBOrientationMaskAll;
    _t_32_accelerometer = 0;
    
    //UIDeviceOrientation 是机器硬件的当前旋转方向 这个你只能取值 不能设置
    //使用UIDevice来获取屏幕方向（不推荐，第一次获取时会获得UIDeviceOrientationUnknown）
//    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
//        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    }
//    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
//    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    

    [OrientationTool sharedInstance].cmmotionManager = [[CMMotionManager alloc]init];
    if([OrientationTool sharedInstance].cmmotionManager.isDeviceMotionAvailable) {
        [[OrientationTool sharedInstance].cmmotionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            UIDeviceOrientation orientationNew;
            CMAcceleration acceleration = accelerometerData.acceleration;
            if (acceleration.x >= M_PI_4) {//home button left
                orientationNew = UIDeviceOrientationLandscapeRight;
            } else if (acceleration.x <= -M_PI_4) {//home button right
                orientationNew = UIDeviceOrientationLandscapeLeft;
            } else if (acceleration.y <= -M_PI_4) {
                orientationNew = UIDeviceOrientationPortrait;
            } else if (acceleration.y >= M_PI_4) {
                orientationNew = UIDeviceOrientationPortraitUpsideDown;
            } else {// Consider same as last time
                orientationNew = [UIDevice currentDevice].orientation;
            }
            OSAtomicIncrement32(&_t_32_accelerometer);
            if (_t_32_accelerometer > kMaxAccelerometerUpdatesNumber) {//检测几次以后稳定后不再检测
                [[OrientationTool sharedInstance] stopAccelerometerUpdates];
                [[OrientationTool sharedInstance] orientationLogicWithOrientation:orientationNew];
                return ;
            }
        }];
    }
}

/**
 停止陀螺仪检测
 */
- (void)stopAccelerometerUpdates {
    [[OrientationTool sharedInstance].cmmotionManager stopAccelerometerUpdates];
    _t_32_accelerometer = 0;
}

- (void)orientationLogicWithOrientation:(UIDeviceOrientation)orientation {
    
    //UIInterfaceOrientation 是你程序界面的当前旋转方向 这个可以设置
    UIInterfaceOrientation interfaceOriention = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(interfaceOriention)) {
    }else if (UIInterfaceOrientationIsPortrait(interfaceOriention)) {
    }
    
    if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {//水平
        //强制转为横屏
        [[OrientationTool sharedInstance] invocationMethodWithOrientation:(UIInterfaceOrientation)orientation];
    }else if (orientation == UIDeviceOrientationPortrait || orientation == UIDeviceOrientationPortraitUpsideDown) {//竖直
        //强制转为竖屏
        [[OrientationTool sharedInstance] invocationMethodWithOrientation:(UIInterfaceOrientation)orientation];
    }
}

+ (void)orientationMaskPortrait {
    [OrientationTool sharedInstance].allowRotate = YBOrientationMaskPortrait;
    [[OrientationTool sharedInstance] invocationMethodWithOrientation:UIDeviceOrientationPortrait];
}

- (void) invocationMethodWithOrientation:(int)orientation {
    if ([[UIDevice currentDevice]    respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

//#pragma mark - 支持横竖屏
//此方法会在设备横竖屏变化的时候系统会调用
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    if ([OrientationTool getOrientationType] == YBOrientationMaskAll) {
//        return UIInterfaceOrientationMaskAll;
//    }else{
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//// 返回是否支持设备自动旋转
//- (BOOL)shouldAutorotate
//{
//    if ([OrientationTool getOrientationType] == YBOrientationMaskAll) {
//        return YES;
//    }
//    return NO;
//}

@end
