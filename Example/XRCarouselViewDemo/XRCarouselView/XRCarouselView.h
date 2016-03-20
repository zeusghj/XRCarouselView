//
//  XRCarouselView.h
//  test
//
//  Created by ibos on 16/3/17.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    AnchorPointOrigin,
    AnchorPointCenter
} AnchorPoint;

@interface XRCarouselView : UIView
//轮播的图片数组，可以是图片，也可以是网络路径
@property (nonatomic, strong) NSArray *imageArray;
//每一页停留时间，默认为1s
@property (nonatomic, assign) NSTimeInterval time;
//隐藏分页控件
@property (nonatomic, assign) BOOL pageControlHidden;
//点击图片后要执行的操作，会返回图片在数组中的索引
@property (nonatomic, copy) void(^imageClickBlock)(NSInteger);
//设置分页控件的位置，第二个参数表示是设置中点还是原点（默认在底部中间）
- (void)setPageControlPosition:(CGPoint)position anchorPoint:(AnchorPoint)anchorPoint;
//清除沙盒中的图片缓存
- (void)clearDiskCache;
//设置分页控件的图片,两个图片都不能为空，否则设置无效，不设置则为系统默认
- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage;
@end
