//
//  ViewController.m
//  WeatherByOC
//
//  Created by 王祖康 on 15/7/25.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置页面背景图片
    UIImage *background=[UIImage imageNamed:@"background.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage:background];
    
    //初始化locationManager
    locationManager=[[CLLocationManager alloc]init];
    
    //设置代理
    locationManager.delegate=self;
    
    //设置位置精确度
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    [locationManager requestWhenInUseAuthorization];
    
    //开始定位服务
    [locationManager startUpdatingLocation];
}


@end
