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
    //本地图片
    NSArray *arr1 = @[[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"], [UIImage imageNamed:@"3.jpg"]];
    //网络图片
    NSArray *arr2 = @[@"http://hiphotos.baidu.com/praisejesus/pic/item/e8df7df89fac869eb68f316d.jpg", @"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
    
    //既有本地图片也有网络图片
    NSArray *arr3 = @[@"http://pic39.nipic.com/20140226/18071023_162553457000_2.jpg", [UIImage imageNamed:@"2.jpg"], @"http://hiphotos.baidu.com/praisejesus/pic/item/e8df7df89fac869eb68f316d.jpg", [UIImage imageNamed:@"1.jpg"]];
    
    NSArray *describeArray = @[@"这是第一张图片的描述", @"这是第二张图片的描述", @"这是第三张图片的描述", @"这是第四张图片的描述"];
    
    /**
     *  通过代码创建
     */
    self.carouselView = [XRCarouselView carouselViewWithImageArray:arr3 describeArray:describeArray];
    
    
    //设置frame
    self.carouselView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 180);
    
    //用block处理图片点击
    //    self.carouselView.imageClickBlock = ^(NSInteger index) {
    //        NSLog(@"第%ld张图片被点击", index);
    //    };
    
    //用代理处理图片点击，如果两个都实现，block优先级高于代理
    self.carouselView.delegate = self;
    
    
    //设置每张图片的停留时间
    _carouselView.time = 2;
    
    //设置分页控件的图片,不设置则为系统默认
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    
    //设置分页控件的位置，默认为PositionBottomCenter
    _carouselView.pagePosition = PositionBottomRight;
    
    /**
     *  设置图片描述控件
     */
    //设置背景颜色，默认为黑色半透明
    _carouselView.desLabelBgColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //设置字体，默认为13号字体
    _carouselView.desLabelFont = [UIFont systemFontOfSize:15];
    //设置文字颜色，默认为白色
    _carouselView.desLabelColor = [UIColor greenColor];
    
    [self.view addSubview:_carouselView];
    
    
    /**
     *  通过storyboard创建的轮播控件
     */
    _carouselView1.imageArray = arr2;
    //设置分页控件指示器的颜色
    [_carouselView1 setPageColor:[UIColor blueColor] andCurrentPageColor:[UIColor redColor]];
    //设置图片切换的方式
    _carouselView1.changeMode = ChangeModeFade;
    _carouselView1.time = 2;
}


#pragma mark XRCarouselViewDelegate
- (void)carouselView:(XRCarouselView *)carouselView didClickImage:(NSInteger)index {
    NSLog(@"点击了第%ld张图片", index);
}


- (IBAction)start:(id)sender {
    [_carouselView startTimer];
}

- (IBAction)stop:(id)sender {
    [_carouselView stopTimer];
}


@end
