# YBOrientationTool

### 横竖屏切换工具，使用陀螺仪检测手机设备方向，锁屏状态也可以检测

项目：[YBOrientationTool](https://github.com/wangyingbo/YBOrientationToolDemo.git) 

![image](https://raw.githubusercontent.com/wangyingbo/YBOrientationToolDemo/master/gif.gif)


在多个页面中，如果只有单个页面支持横屏，并且需要在刚进页面的时候根据设备状态改变页面方向的话，可以用此工具；

### features
> 横竖屏切换工具特点

+ 使用陀螺仪检测手机设备方向，锁屏状态也可以检测，准确率高；
+ 完全解耦，只需要调用一行代码即可完成；

### 使用方法
导入OrientationTool文件夹，导入`OrientationTool.h`头文件，然后在`viewWillAppear`里设置：

    [OrientationTool orientationMaskAll];

在`viewWillDisappear`里设置：

    [OrientationTool orientationMaskPortrait];

即可完成。

### Others

[MotionOrientation](https://github.com/tastyone/MotionOrientation)

[ScreenRotator](https://github.com/Rogue24/ScreenRotator)


### 下载链接：[DEMO](https://github.com/wangyingbo/YBOrientationToolDemo.git) ，欢迎star。
