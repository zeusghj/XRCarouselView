//
//  XRCarouselView.h
//  test
//
//  Created by ibos on 16/3/17.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XRCarouselView : UIView
//轮播的图片数组，可以全是图片，也可以全是网络路径，不能既有图片又有路径
@property (nonatomic, strong) NSArray *imageArray;
//每一页停留时间，默认为1s
@property (nonatomic, assign) NSTimeInterval time;
//隐藏分页控件
@property (nonatomic, assign) BOOL pageControlHidden;
//点击图片后要执行的操作，会返回图片在数组中的索引
@property (nonatomic, copy) void(^imageClickBlock)(NSInteger);
//设置分页控件的位置，默认在底部中间
- (void)setPageControlPosition:(CGPoint)position;
//设置分页控件的图片,两个图片都不能为空，否则设置无效，不设置则为系统默认
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage;
@end
