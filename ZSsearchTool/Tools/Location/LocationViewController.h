//
//  LocationViewController.h
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/6.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "BaseViewController.h"


@interface LocationViewController : BaseViewController
//定位成功后的回调
@property(nonatomic,copy)void(^locationSuccess)(NSString *city);

@end
