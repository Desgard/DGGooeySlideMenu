# DGGooeySlideMenu

![Platforms](https://cocoapod-badges.herokuapp.com/p/MZTimerLabel/badge.png)

DGGooeySlideMenu---模仿skype照相按钮弹出菜单弹簧效果

制作思路及代码解释可查看博文[Recreating Skype's Action Sheet Animation](http://desgard.com/2016/06/05/DGGooeySlideMenu/)

<img src="/Source/demo0.gif" alt="img" width="300px">

## 后续任务

* 根据弹簧效果的两个rect视图，计算弹簧序列。(`diff`序列) 【已完成】
* 重写`drawRect`函数，增加`runtime`频率刷新贝塞尔曲线视图。【已完成】
* 给出initWithTitles接口，传入多个button的Title
* 完成button的布局
