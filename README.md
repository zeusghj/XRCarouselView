# XRCarouselView
The easiest way to use image circulate

超简单好用的图片轮播框架

仅仅两个imageView实现图片轮播

______

#如何集成XRCarouselView

####手动导入
将XRCarouselView文件夹中的所有文件添加到项目中
####cocoapods导入
pod 'XRCarouselView'

####使用
1.导入主头文件 XRCarouselView.h

2.创建XRCarouselView，设置图片(路径)数组

3.将XRCarouselView添加到要展示到view上面


#XRCarouselView的优点

1.一个文件就搞定，代码简洁

2.两个imageView实现轮播，占用内存小

3.同时支持本地图片与网络图片

4.自带网络图片缓存功能

#XRCarouselView的常用属性方法

1.imageArray：要轮播的图片数组，也可传递路径

2.time：设置每页的停留时间

3.pageContolPosition：设置分页控件的位置

4.pageControlHidden：隐藏分页控件

5.setPageImageView:andCurrentImage:：设置分页控件的图片

6.void(^imageClickBlock)(NSInteger index)：图片被点击后要执行的代码

#效果演示
![](http://ww2.sinaimg.cn/large/b68232a1gw1f208x08t45g20a80hz4kl.gif)



    