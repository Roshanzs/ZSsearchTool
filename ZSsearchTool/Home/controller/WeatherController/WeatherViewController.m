//
//  WeatherViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/8.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "WeatherViewController.h"
#import <WebKit/WebKit.h>

@interface WeatherViewController ()
@property(nonatomic,strong)WKWebView *webview;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview  = [[WKWebView alloc]init];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(110);
        make.top.mas_equalTo(self.view).offset(-24);
    }];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tianqi.moji.com/weather/china/hubei/hongshan-district"]]];
    
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    ZLog(@"datastr = %@",datastr);
//    [self.webview loadData:data MIMEType:@"text/html" characterEncodingName:@"UTF-8" baseURL:nil];

    //截取主要信息
   NSString *reultmain = [self startRangeStr:@"description\" content" endRangeStr:@"keywords" withStr:datastr];
    NSString *result = [self startRangeStr:@"=\"" endRangeStr:@"\">" withStr:reultmain];
    if ([result rangeOfString:@"墨迹天气"].location != NSNotFound) {
        result = [result stringByReplacingOccurrencesOfString:@"墨迹天气" withString:@"哈哈"];
    }
//    ZLog(@"result = %@",reult);
    //截取污染指数
    NSString *reult1 = [self startRangeStr:@"span class" endRangeStr:@"<div class=\"wea_info_avator\">" withStr:datastr];
    NSString *reult2 = [self startRangeStr:@"</span>" endRangeStr:@"</a>" withStr:reult1];
    NSString *wuranreult = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reult2];
//    ZLog(@"result = %@",wuranreult);


    //更新时间和温度
    NSString *reulttime = [self startRangeStr:@"wea_weather clearfix\">" endRangeStr:@"新<" withStr:datastr];
    //当前温度
    NSString *reultcurr = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reulttime];
    //当前天气
    NSString *reultcurrweather = [self startRangeStr:@"<b>" endRangeStr:@"</b>" withStr:reulttime];
    //图片
    NSString *reultcurrimg = [self startRangeStr:@"src=\"" endRangeStr:@"\" alt" withStr:reulttime];
    //更新时间
    NSString *reultupdate = [self startRangeStr:@"uptime\">" endRangeStr:@"更" withStr:reulttime];
//    ZLog(@"result = %@ %@  %@ %@",reultcurr,reultcurrweather,reultcurrimg,reultupdate);

    //湿度和风向
    NSString *reultshiduwind = [self startRangeStr:@"wea_about clearfix\">" endRangeStr:@"wea_info_avator\">" withStr:datastr];
    //湿度
    NSString *reultshidu = [self startRangeStr:@"<span>" endRangeStr:@"</span>" withStr:reultshiduwind];
    //风向
    NSString *reultwind = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reultshiduwind];
    //提示
    NSString *reultnotice = [self startRangeStr:@"clearfix\">" endRangeStr:@"right\">" withStr:reultshiduwind];
    NSString *reultnotice1 = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reultnotice];

    ZLog(@"wind = %@ 污染指数%@ 当前温度%@ 天气%@ 图片%@ %@ 湿度%@ 风向%@ 提示%@",result,wuranreult,reultcurr,reultcurrweather,reultcurrimg,reultupdate,reultshidu,reultwind,reultnotice1);
}



//字符截取
-(NSString *)startRangeStr:(NSString *)startStr endRangeStr:(NSString *)endStr withStr:(NSString *)str{
    NSRange startrange = [str rangeOfString:startStr];
    NSRange endrange = [str rangeOfString:endStr];
    NSRange range = NSMakeRange(startrange.location + startrange.length, endrange.location - startrange.location - startrange.length);
    NSString *resultstr = [str substringWithRange:range];
    return resultstr;
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
