//
//  XRCarouselView.m
//  test
//
//  Created by ibos on 16/3/17.
//  Copyright © 2016年 ibos. All rights reserved.
//

#import "XRCarouselView.h"
typedef enum{
    DirecNone,
    DirecLeft,
    DirecRight
} Direction;

@interface XRCarouselView()<UIScrollViewDelegate>
//轮播的图片数组
@property (nonatomic, strong) NSMutableArray *images;
//下载的图片字典
@property (nonatomic, strong) NSMutableDictionary *imageDic;
//下载图片的操作
@property (nonatomic, strong) NSMutableDictionary *operations;
//滚动方向
@property (nonatomic, assign) Direction direction;
//显示的imageView
@property (nonatomic, strong) UIImageView *currImageView;
//辅助滚动的imageView
@property (nonatomic, strong) UIImageView *otherImageView;
//当前显示图片的索引
@property (nonatomic, assign) NSInteger currIndex;
//将要显示图片的索引
@property (nonatomic, assign) NSInteger nextIndex;
//滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;
//分页控件
@property (nonatomic, strong) UIPageControl *pageControl;
//定时器
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@end

@implementation XRCarouselView

#pragma mark- scrollView尺寸
- (CGFloat)height {
    return self.scrollView.frame.size.height;
}

- (CGFloat)width {
    return self.scrollView.frame.size.width;
}

#pragma mark- 懒加载
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _currImageView = [[UIImageView alloc] init];
        _currImageView.userInteractionEnabled = YES;
        [_currImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)]];
        [_scrollView addSubview:_currImageView];
        _otherImageView = [[UIImageView alloc] init];
        [_scrollView addSubview:_otherImageView];
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

#pragma mark- 创建
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.scrollView.frame = self.bounds;
    self.pageControl.center = CGPointMake(self.width * 0.5, self.height - 10);
    _scrollView.contentOffset = CGPointMake(self.width, 0);
    _currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.currIndex = 0;
        self.time = 1;
        [self addObserver:self forKeyPath:@"direction" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

#pragma mark- 设置相关方法
- (void)setImageArray:(NSArray *)imageArray{
    _imageArray = imageArray;
    if ([imageArray.firstObject isKindOfClass:[UIImage class]]) {
        _images = [imageArray mutableCopy];
    } else if ([imageArray.firstObject isKindOfClass:[NSString class]]){
        _images = [NSMutableArray array];
        for (int i = 0; i < imageArray.count; i++) {
            [_images addObject:[UIImage imageNamed:@"placeholder"]];
            [self downloadImages:i];
        }
    } else {
        return;
    }
    self.currImageView.image = _images.firstObject;
    self.pageControl.numberOfPages = _images.count;
    if (_images.count > 1) {
        _scrollView.contentSize = CGSizeMake(self.width * 3, 0);
    } else {
        _scrollView.contentSize = CGSizeZero;
        _scrollView.scrollEnabled = NO;
    }
}

- (void)downloadImages:(int)index {
    NSString *key = _imageArray[index];
    //从内存缓存中取图片
    UIImage *image = [self.imageDic objectForKey:key];
    if (image) {
        _images[index] = image;
    }else{
        //从沙盒缓存中取图片
        NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [cache stringByAppendingPathComponent:[key lastPathComponent]];
        NSData *data = [NSData dataWithContentsOfFile:path];
        if (data) {
            image = [UIImage imageWithData:data];
            _images[index] = image;
            [self.imageDic setObject:image forKey:key];
        }else{
            //下载图片
            NSBlockOperation *download = [self.operations objectForKey:key];
            if (!download) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSURL *url = [NSURL URLWithString:key];
                    NSData *data = [NSData dataWithContentsOfURL:url];
                    if (data) {
                        UIImage *image = [UIImage imageWithData:data];
                        [self.imageDic setObject:image forKey:key];
                        self.images[index] = image;
                        [data writeToFile:path atomically:YES];
                        [self.operations removeObjectForKey:key];
                    }
                });
                [self.operations setObject:download forKey:key];
            }
        }
    }
}

- (void)setPageControlPosition:(CGPoint)position {
    CGRect frame = self.pageControl.frame;
    frame.origin = position;
    self.pageControl.frame = frame;
}

- (void)setPageImage:(UIImage *)pageImage andCurrentImage:(UIImage *)currentImage {
    if (!pageImage || !currentImage) {
        return;
    }
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:pageImage forKey:@"_pageImage"];
}

- (void)setTime:(NSTimeInterval)time {
    _time = time;
    [self.timer invalidate];
    [self startTimer];
}

- (void)setPageControlHidden:(BOOL)pageControlHidden {
    self.pageControl.hidden = pageControlHidden;
}

#pragma mark- 定时器相关方法
- (void)startTimer {
    self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage {
    [self.scrollView setContentOffset:CGPointMake(self.width * 2, 0) animated:YES];
}

#pragma mark- 其它
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([change[NSKeyValueChangeNewKey] intValue] == DirecRight) {
        self.otherImageView.frame = CGRectMake(0, 0, self.width, self.height);
        self.nextIndex = self.currIndex - 1;
        if (self.nextIndex < 0) self.nextIndex = _images.count - 1;
    } else if ([change[NSKeyValueChangeNewKey] intValue] == DirecLeft){
        self.otherImageView.frame = CGRectMake(CGRectGetMaxX(_currImageView.frame), 0, self.width, self.height);
        self.nextIndex = self.currIndex + 1;
        if (self.nextIndex >= _images.count) self.nextIndex = 0;
    }
    self.otherImageView.image = self.images[self.nextIndex];
}

- (void)imageClick {
    !self.imageClickBlock?:self.imageClickBlock(self.currIndex);
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.direction = scrollView.contentOffset.x > self.width? DirecLeft : DirecRight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self pauseScroll];
}

- (void)pauseScroll {
    self.direction = DirecNone;
    int index = self.scrollView.contentOffset.x / self.width;
    if (index == 1) {
        return;
    }
    self.currIndex = self.nextIndex;
    self.pageControl.currentPage = self.currIndex;
    self.currImageView.frame = CGRectMake(self.width, 0, self.width, self.height);
    self.currImageView.image = self.otherImageView.image;
    self.scrollView.contentOffset = CGPointMake(self.width, 0);
}

@end
