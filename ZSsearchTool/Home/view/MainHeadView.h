//
//  MainHeadView.h
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/6.
//  Copyright © 2017年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainHeadViewDeleagte <NSObject>

//点击的哪个
-(void)didSelectBtnWith:(NSInteger)intger;

@end

@interface MainHeadView : UIView

@property(nonatomic,weak)id<MainHeadViewDeleagte> delegate;

@end
