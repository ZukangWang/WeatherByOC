# 基于地理位置的天气预报iOS APP
![image](https://github.com/ZukangWang/WeatherByOC/raw/master/WeatherByOC/1.png)
##关键技术点
1. 通过CoreLocation获取当前设备的地理位置信息
2. 通过AFNetworking获取openweathermap接口的天气信息

##整体思路
1. 声明UI控件
2. 引用CoreLocation.h头文件
3. 声明CLLocationManager类型对象并实例化
4. 通过- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)方法实时获取当前地理位置信息
5. 利用CocoaPods，将AFNetworking类库导入到项目中
6. 引用AFNetworking.h头文件
7. 声明AFHTTPRequestOperationManager类型对象并实例化
8. 发起Get请求，请求地址为：http://api.openweathermap.org/data/2.5/weather ，另外还需要配置3个参数：lat、lon、cnt，发起的请求地址类似于：http://api.openweathermap.org/data/2.5/weather?lat=-37.8136&%20&lon=144.9631&cnt=1
9. 解析返回JSON格式的数据，先提取出name和temperature，并显示，另外还需要提取出weather的id值
10. 根据weather的id不同值，与项目中图片进行匹配，显示响应天气情况的图片，该id不同取值请参考：http://bugs.openweathermap.org/projects/api/wiki/Weather_Condition_Codes
11. 最后是细微优化一下，增加一个加载进度条和页面背景图片
