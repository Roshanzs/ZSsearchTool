//
//  BaseTabBarController.m
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/4.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "MainViewController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载子控制器
    [self createChildControllers];
}

-(void)createChildControllers{
    MainViewController *mainVc = [[MainViewController alloc]init];
    BaseNavigationController *mainNv = [[BaseNavigationController alloc]initWithRootViewController:mainVc];
//    mainVc.navigationItem.title = @"首页";
    mainNv.tabBarItem.title = @"首页";
    mainNv.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    mainNv.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainViewController *bookingVc = [[MainViewController alloc]init];
    BaseNavigationController *bookingNv = [[BaseNavigationController alloc]initWithRootViewController:bookingVc];
    bookingVc.navigationItem.title = @"预约";
    bookingNv.tabBarItem.title = @"预约";
    bookingNv.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    bookingNv.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    MainViewController *userVc = [[MainViewController alloc]init];
    BaseNavigationController *userNv = [[BaseNavigationController alloc]initWithRootViewController:userVc];
    userVc.navigationItem.title = @"我";
    userNv.tabBarItem.title = @"我";
    userNv.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    userNv.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_profile_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    [self setViewControllers:@[mainNv,bookingNv,userNv] animated:YES];
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
