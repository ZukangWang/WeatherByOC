//
//  ViewController.h
//  WeatherByOC
//
//  Created by 王祖康 on 15/7/25.
//  Copyright (c) 2015年 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AFNetworking/AFNetworking.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UILabel *labelCity;

@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;

@property (weak, nonatomic) IBOutlet UIImageView *imageWeather;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorLoading;

@property (weak, nonatomic) IBOutlet UILabel *LableLoading;
@end

