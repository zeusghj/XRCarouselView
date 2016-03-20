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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XRCarouselView *carouselView = [[XRCarouselView alloc] initWithFrame:CGRectMake(0, 100, 375, 180)];
    [self.view addSubview:carouselView];
    //传递图片地址
//    carouselView.imageArray = @[@"http://www.5068.com/u/faceimg/20140725173411.jpg", @"http://file27.mafengwo.net/M00/52/F2/wKgB6lO_PTyAKKPBACID2dURuk410.jpeg", @"http://file27.mafengwo.net/M00/B2/12/wKgB6lO0ahWAMhL8AAV1yBFJDJw20.jpeg"];
    //传递图片
//    carouselView.imageArray = @[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"]];
    //既有本地图片也有网络图片
    carouselView.imageArray = @[[UIImage imageNamed:@"1"]];
    //设置每张图片的停留时间
    carouselView.time = 1.5;
    //设置分页控件的图片
    [carouselView setPageImage:[UIImage imageNamed:@"other"] andCurrentImage:[UIImage imageNamed:@"current"]];
    //设置分页控件的位置，第二个参数表示是设置中点还是原点
    [carouselView setPageControlPosition:CGPointMake(300, 160) anchorPoint:AnchorPointCenter];
    //隐藏分页控件
//    carouselView.pageControlHidden = YES;
    //监听图片的点击
    [carouselView setImageClickBlock:^(NSInteger index) {
        NSLog(@"第%ld张图片被点击", index);
    }];
//    [carouselView clearDiskCache];
    
}


@end
