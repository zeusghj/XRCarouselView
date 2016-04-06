//
//  ViewController.m
//  XRCarouselViewDemo
//
//  Created by 肖睿 on 16/3/17.
//  Copyright © 2016年 肖睿. All rights reserved.
//

#import "ViewController.h"
#import "XRCarouselView.h"
@interface ViewController ()
@property (nonatomic, strong) XRCarouselView *carouselView;
@property (weak, nonatomic) IBOutlet XRCarouselView *carouselView1;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //本地图片
    NSArray *arr1 = @[[UIImage imageNamed:@"1.jpg"], [UIImage imageNamed:@"2.jpg"], [UIImage imageNamed:@"3.jpg"]];
    //网络图片
    NSArray *arr2 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
    //既有本地图片也有网络图片
//    NSArray *arr3 = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", [UIImage imageNamed:@"2.jpg"], @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", [UIImage imageNamed:@"1.jpg"]];
//    
//    NSArray *describeArray = @[@"这是第一张图片的描述", @"这是第二张图片的描述", @"这是第三张图片的描述", @"这是第四张图片的描述"];
    //创建方式1
//    self.carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 100, 375, 180)];
//    self.carouselView.imageArray = arr3;
    
    //创建方式2
//    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr1];
//    self.carouselView.frame = CGRectMake(0, 100, 375, 180);
    
    //创建方式3
    self.carouselView = [[XRCarouselView alloc] initWithImageArray:arr2 imageClickBlock:^(NSInteger index) {
        NSLog(@"第%ld张图片被点击", index);
    }];
    //设置每张图片的停留时间
    self.carouselView.frame = CGRectMake(0, 100, 375, 180);
//
    //创建方式4
//    self.carouselView = [XRCarouselView carouselViewWithImageArray:arr3];
//    self.carouselView.frame = CGRectMake(0, 100, 375, 180);
    
    
    //创建方式5
//    self.carouselView = [XRCarouselView carouselViewWithImageArray:arr3 describeArray:describeArray];
//    self.carouselView.imageClickBlock = ^(NSInteger index) {
//        NSLog(@"第%ld张图片被点击", index);
//    };
//    self.carouselView.frame = CGRectMake(0, 100, 375, 180);
    
    //设置每张图片的停留时间
    _carouselView.time = 1;
    //设置分页控件的图片
    [_carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    //设置分页控件的frame
    CGFloat width = arr2.count * 30;
    CGFloat height = 20;
    CGFloat x = _carouselView.frame.size.width - width - 10;
    CGFloat y = _carouselView.frame.size.height - height - 20;
    _carouselView.pageControl.frame = CGRectMake(x, y, width, height);
    //隐藏分页控件
//    _carouselView.pageControl.hidden = YES;
    [self.view addSubview:_carouselView];
    
    
    
//    _carouselView1.imageArray = arr3;
//    _carouselView1.describeLabel.center = CGPointMake(375 / 2, 10);
//    _carouselView1.time = 2;
    
}



- (IBAction)start:(id)sender {
    [_carouselView startTimer];
}

- (IBAction)stop:(id)sender {
    [_carouselView stopTimer];
}


@end
