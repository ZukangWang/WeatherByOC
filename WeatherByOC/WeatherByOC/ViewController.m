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
    
    [self.indicatorLoading startAnimating];
    
    //初始化locationManager
    locationManager=[[CLLocationManager alloc]init];
    
    //设置代理
    locationManager.delegate=self;
    
    //设置位置精确度
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    
    [locationManager requestAlwaysAuthorization];
    
    //开始定位服务
    [locationManager startUpdatingLocation];
}

//协议中的方法，作用是每当位置发生更新时会调用的委托方法
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
{
    //取出最后一个位置信息
    CLLocation *location=locations[locations.count-1];
    
    
    if(location.horizontalAccuracy>0){
        
        NSLog(@"%f",location.coordinate.latitude);
        NSLog(@"%f",location.coordinate.longitude);
        
        [self updaterWeatherInfo:location.coordinate.latitude Withlongitude:location.coordinate.longitude];
        
        [locationManager stopUpdatingLocation];
    }
}

//更新天气信息
-(void)updaterWeatherInfo:(CLLocationDegrees)latitude
            Withlongitude:(CLLocationDegrees)longitude
{
    //初始化AFHTTPRequestOperationManager
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc] init];
    
    //设置请求Url地址
    NSString *url=@"http://api.openweathermap.org/data/2.5/weather";
    
    //设置请求Url参数
    NSDictionary *params=@{@"lat":[NSNumber numberWithDouble:latitude],@"lon":[NSNumber numberWithDouble:longitude],@"cnt":[NSNumber numberWithDouble:0]};
    
    //发生Get请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation,id responseObject){
        
        //响应结果responseObject为JSON格式
        NSLog(@"JOSN: %@",responseObject);
        
        [self updateUI:(NSDictionary *)responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"%@",error);
    }];
}

//更新UI
-(void)updateUI:(NSDictionary *)jsonResult
{
    [self.indicatorLoading stopAnimating];
    self.indicatorLoading.hidesWhenStopped=true;
    self.LableLoading.text=nil;
    
    NSNumber *tempResult=jsonResult[@"main"][@"temp"];
    
    //转换成摄氏度
    double temperature=round([tempResult doubleValue]-273.15);
    
    self.labelTemperature.text=[NSString stringWithFormat:@"%.f°",temperature];
    
    NSString *name=jsonResult[@"name"];
    self.labelCity.text=name;
    
    //show image
    NSNumber *weatherId=((NSArray *)jsonResult[@"weather"])[0][@"id"];
    int condition=[weatherId intValue];
    
    NSNumber *sunRise=jsonResult[@"sys"][@"sunrise"];
    double sunRiseValue=[sunRise doubleValue];
    
    NSNumber *sunSet=jsonResult[@"sys"][@"sunset"];
    double sunSetValue=[sunSet doubleValue];
    
    BOOL nightTime=false;
    double now = NSTimeIntervalSince1970;
    
    if (now<sunRiseValue||now>sunSetValue) {
        nightTime=true;
    }
    
    [self updateWeatherIcon:condition withNightTime:nightTime];
}

//更新天气图标
-(void)updateWeatherIcon:(int)condition withNightTime: (BOOL)nightTime
{
    if(condition<300){
        if (nightTime) {
            self.imageWeather.image=[UIImage imageNamed:@"tstorm1_night"];
        }
        else{
            self.imageWeather.image=[UIImage imageNamed:@"tstorm1"];
        }
    }
    else if (condition<500){
        self.imageWeather.image=[UIImage imageNamed:@"light_rain"];
    }
    else if (condition<600){
        self.imageWeather.image=[UIImage imageNamed:@"shower3"];
    }
    else if (condition<700){
        self.imageWeather.image=[UIImage imageNamed:@"snow4"];
    }
    else if (condition<771){
        if (nightTime) {
            self.imageWeather.image=[UIImage imageNamed:@"fog_night"];
        }else{
            self.imageWeather.image=[UIImage imageNamed:@"fog"];
        }
    }
    else if (condition < 800) {
        self.imageWeather.image=[UIImage imageNamed:@"tstorm3"];
    }
    else if (condition == 800) {
        if (nightTime){
            self.imageWeather.image=[UIImage imageNamed:@"sunny_night"];
        }
        else {
            self.imageWeather.image=[UIImage imageNamed:@"sunny"];
        }
    }
    else if (condition < 804) {
        if (nightTime){
            self.imageWeather.image=[UIImage imageNamed:@"cloudy2_night"];
        }
        else{
            self.imageWeather.image=[UIImage imageNamed:@"cloudy2"];
        }
    }
    else if (condition == 804) {
        self.imageWeather.image=[UIImage imageNamed:@"overcast"];
    }
    else if ((condition >= 900 && condition < 903) || (condition > 904 && condition < 1000)) {
        self.imageWeather.image=[UIImage imageNamed:@"tstorm3"];
    }
    else if (condition == 903) {
        self.imageWeather.image=[UIImage imageNamed:@"snow5"];
    }
    else if (condition == 904) {
        self.imageWeather.image=[UIImage imageNamed:@"sunny"];
    }
    else {
        self.imageWeather.image=[UIImage imageNamed:@"dunno"];
    }

}

//协议中的方法，当位置获取或更新失败会调用的方法
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

@end
