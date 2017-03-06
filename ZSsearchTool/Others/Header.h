//
//  Header.h
//  funWithIncome
//
//  Created by 紫贝壳 on 2017/1/13.
//  Copyright © 2017年 zbk. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import "Masonry.h"
#import "ToolKit.h"
#import "NSString+Tools.h"
#import "ZSShowViewTools.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h" // 更新sdweb后需要设置cookie可用   request.HTTPShouldHandleCookies=YES;
//#import "AFNetworking.h"

//全局颜色
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1.0f)
#define ColorWithHex(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

//随机颜色
#define ZSRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//屏幕宽高
#define WSCREEN [UIScreen mainScreen].bounds.size.width
#define HSCREEN [UIScreen mainScreen].bounds.size.height
#define BSCREEN [UIScreen mainScreen].bounds

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type;

//获取temp
#define ZSPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define ZSPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define ZSPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//网址

//服务器
#define hosturl @"http:jfq.23zs.com/"

//我的任务
#define taskUrl @"renwu/index/index.html"
//首页任务
#define maintaskurl @"renwu/index/remen.html"
//任务详情
#define taskinfourl @"renwu/index/detail.html"
//任务开始
#define taskstarturl @"renwu/index/startJob.html"
//任务完成
#define taskendurl @"renwu/index/finshJob.html"
//注册界面获取图片验证码
#define checkimgurl @"Renwu/Member/tuxingma.html"
//注册界面获取短信验证码
#define checksmsurl @"Renwu/Member/sendSms.html"
//注册按钮
#define registerbtnurl @"Renwu/Member/login.html"
//用户信息
#define userinfourl @"Renwu/Member/userInfo.html"
//收支详情
#define tasktakeinfourl @""
//支付宝提现
#define alipayOutUrl @""
//头像上传
#define userIconUrl @""
//用户反馈
#define userBackurl @""


#ifdef DEBUG
#define ZLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define ZSLog(...)
#endif

#endif /* Header_h */
