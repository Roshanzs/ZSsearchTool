//
//  LocationViewController.m
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/6.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "ZSShowViewTools.h"
@interface LocationViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManger;
@property(nonatomic,strong)UILabel *curCity;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.locationManger = [[CLLocationManager alloc]init];
    self.locationManger.delegate = self;
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    [self setupUI];
    [self startLocation];
}

//界面消失的时候显示tabbar
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
//界面显示的时候隐藏tabbar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}


-(void)setupUI{
    UILabel *currentCity = [[UILabel alloc]init];
    self.curCity = currentCity;
    currentCity.textColor = [UIColor redColor];
    [self.view addSubview:currentCity];
    [currentCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
}


//开启定位
-(void)startLocation{
    if (! [CLLocationManager locationServicesEnabled]) {
        [ZSShowViewTools showMessage:@"未开启定位服务"];
        return;
    }
    if ([self.locationManger respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManger requestAlwaysAuthorization];
    }
    [self.locationManger startUpdatingLocation];
}


//代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = [locations lastObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    DLog(@"维度 %f   经度 %f",coordinate.latitude,coordinate.longitude);
    //反地理编码
    WeakSelf(self);
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSString *city = placemark.subLocality;
                if (!city) {
                    city = placemark.administrativeArea;
                }
                self.curCity.text = [NSString stringWithFormat:@"当前定位: %@",city];
                weakself.locationSuccess(city);
            }else if ([placemarks count] == 0){
                [ZSShowViewTools showMessage:@"定位城市失败,请重试!" WithAfterDelay:2.0];
            }
        }else{
            [ZSShowViewTools showMessage:@"网络出错,请检查下网络!" WithAfterDelay:2.0];
            ZLog(@"网络出错");
        }
    }];
    [self.locationManger stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    ZLog(@"error = %ld",(long)error.code);
    [ZSShowViewTools showMessage:[NSString stringWithFormat:@"定位出错 error = %ld",(long)error.code] WithAfterDelay:2.0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
