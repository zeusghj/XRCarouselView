//
//  ViewController.m
//  XRCarouselViewDemo
//
//  Created by 肖睿 on 16/3/17.
//  Copyright © 2016年 肖睿. All rights reserved.
//

#import "ViewController.h"
#import "XRCarouselView.h"

@interface ViewController ()<XRCarouselViewDelegate>
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (weak, nonatomic) IBOutlet XRCarouselView *carouselView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"轮播Demo";
    
    NSArray *arr = @[
                     @"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg",//网络图片
                     [UIImage imageNamed:@"1.jpg"],//本地图片，传image，不能传名称
                     @"http://photo.l99.com/source/11/1330351552722_cxn26e.gif",//网络gif图片
                     gifImageNamed(@"2.gif")//本地gif使用gifImageNamed(name)函数创建
                     ];
    
    NSArray *describeArray = @[@"网络图片", @"本地图片", @"网络动态图", @"本地动态图"];
    
    /**
     *  通过代码创建
     */
    _carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 180)];
    _carouselView.delegate = self;
    
    //设置占位图片,须在设置图片数组之前设置,不设置则为默认占位图
    _carouselView.placeholderImage = [UIImage imageNamed:@"placeholderImage.jpg"];
    
    //设置图片数组及图片描述文字
    _carouselView.imageArray = arr;
    _carouselView.describeArray = describeArray;
    
    //设置每张图片的停留时间，默认值为5s，最少为1s
    _carouselView.time = 3;
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentPageImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomRight;

    [self.view addSubview:_carouselView];
    
    
    
    /**
     *  通过storyboard创建的轮播控件
     */
    _carouselView1.imageArray = arr;
    //设置图片切换的方式
    _carouselView1.changeMode = ChangeModeFade;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //清除缓存
    [XRCarouselView clearDiskCache];
   
}


#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
}



@end
