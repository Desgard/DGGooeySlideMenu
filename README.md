# DGGooeySlideMenu

![Platforms](https://cocoapod-badges.herokuapp.com/p/MZTimerLabel/badge.png)

DGGooeySlideMenu---模仿skype照相按钮弹出菜单弹簧效果

制作思路及代码解释可查看博文[Recreating Skype's Action Sheet Animation](http://desgard.com/2016/06/05/DGGooeySlideMenu/)

<img src="/Source/demo0.gif" alt="img" width="300px">

## 计算弹性数组序列

先要确定我们的目标：**构造一个连续序列，这个序列的末状态是0，过程中先增大，再减小，再增大……重复以上过程，因为阻尼衰减，到最后会停留在0，则序列结束。**这个连续序列就好比缓动函数中的[EaseOutElastic](http://www.xuanfengge.com/easeing/easeing/#easeOutElastic)。

在iOS7之后，Apple在[UIView Class Refference](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/#//apple_ref/occ/clm/UIView/animateWithDuration:delay:usingSpringWithDamping:initialSpringVelocity:options:animations:completion:)增加了弹簧动画效果。

```Objective-C
+ (void)animateWithDuration: (NSTimeInterval)duration
                      delay: (NSTimeInterval)delay
     usingSpringWithDamping: (CGFloat)dampingRatio
      initialSpringVelocity: (CGFloat)velocity
                    options: (UIViewAnimationOptions)options
                 animations: (void (^)(void))animations
                 completion: (void (^)(BOOL finished))completion
```

我们的灵感来自于官方的这个函数。这里在构造序列的时候，**通过两个视图在不同的时间内执行弹簧动画**，即可得到我们所需要的序列（文字说的不明白，可以看我录制图）。这种方法在Kitten-Yang的书中第二章也详细的介绍了，被称作**辅助视图(Side Helper View)**法。这里我把效果放慢，大家观察两个不同颜色的Rect在Y轴上的距离变化：

![](/Source/demo3.gif)

## 后续任务

* 根据弹簧效果的两个rect视图，计算弹簧序列。(`diff`序列) 【已完成】
* 重写`drawRect`函数，增加`runtime`频率刷新贝塞尔曲线视图。【已完成】
* 给出initWithTitles接口，传入多个button的Title
* 完成button的布局
