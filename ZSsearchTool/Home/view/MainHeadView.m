//
//  MainHeadView.m
//  Enjoy-Booking
//
//  Created by 紫贝壳 on 2017/1/6.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "MainHeadView.h"
#import "SDCycleScrollView.h"
#import "MainHeadCollectionViewCell.h"
//item的size
#define margin 10
#define Witem (WSCREEN - 5 * margin) / 4.0
#define Hitem  (150.0/667.0*HSCREEN - margin * 3) / 2.0
@interface MainHeadView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *detailLab;
@property(nonatomic,strong)UILabel *TLab;
@property(nonatomic,strong)UIImageView *Timg;
@property(nonatomic,strong)UILabel *dayTLab;
@property(nonatomic,strong)UILabel *nightTLab;
@property(nonatomic,strong)UILabel *shiduTLab;
@property(nonatomic,strong)UILabel *windTLab;
@property(nonatomic,strong)UILabel *updateLab;
@property(nonatomic,strong)UILabel *wuranTLab;
@end

static NSString *mainCollectioncellID = @"mainCollectioncellID";
@implementation MainHeadView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WSCREEN, 150.0/667.0*HSCREEN) delegate:self placeholderImage:[UIImage imageNamed:@"detail"]];
    cycleScrollView.localizationImageNamesGroup = @[@"timg"];
    [self addSubview:cycleScrollView];
    [self addSubview:self.collectionView];
    
    UILabel *detailLab = [[UILabel alloc]init];
    detailLab.numberOfLines = 0;
    detailLab.font = [UIFont systemFontOfSize:10];
    self.detailLab = detailLab;
    [cycleScrollView addSubview:detailLab];
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cycleScrollView).offset(20);
        make.bottom.right.mas_equalTo(cycleScrollView).offset(-8);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *TLab = [[UILabel alloc]init];
    TLab.numberOfLines = 0;
    TLab.font = [UIFont systemFontOfSize:50];
    self.TLab = TLab;
    [cycleScrollView addSubview:TLab];
    [TLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cycleScrollView).offset(20);
        make.top.mas_equalTo(cycleScrollView).offset(20);
        make.bottom.mas_equalTo(detailLab.mas_top).offset(-20);
    }];
    
    UIImageView *Timg = [[UIImageView alloc]init];
    self.Timg = Timg;
    [cycleScrollView addSubview:Timg];
    [Timg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cycleScrollView).offset(-8);
        make.topMargin.mas_equalTo(TLab);
        make.width.height.mas_equalTo(TLab.mas_height);
    }];
    
    UILabel *dayTLab = [[UILabel alloc]init];
    dayTLab.font = [UIFont systemFontOfSize:12];
    self.dayTLab = dayTLab;
    [cycleScrollView addSubview:dayTLab];
    [dayTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(TLab);
        make.bottom.mas_equalTo(detailLab.mas_top).offset(-3);
    }];
    
    UILabel *nightTLab = [[UILabel alloc]init];
    nightTLab.font = [UIFont systemFontOfSize:12];
    self.nightTLab = nightTLab;
    [cycleScrollView addSubview:nightTLab];
    [nightTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dayTLab.mas_right).offset(5);
        make.bottomMargin.mas_equalTo(dayTLab);
    }];

    UILabel *shiduTLab = [[UILabel alloc]init];
    shiduTLab.font = [UIFont systemFontOfSize:12];
    self.shiduTLab = shiduTLab;
    [cycleScrollView addSubview:shiduTLab];
    [shiduTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nightTLab.mas_right).offset(5);
        make.bottomMargin.mas_equalTo(dayTLab);
    }];

    UILabel *windTLab = [[UILabel alloc]init];
    windTLab.font = [UIFont systemFontOfSize:12];
    self.windTLab = windTLab;
    [cycleScrollView addSubview:windTLab];
    [windTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shiduTLab.mas_right).offset(5);
        make.bottomMargin.mas_equalTo(dayTLab);
    }];



    UILabel *updateLab = [[UILabel alloc]init];
    updateLab.font = [UIFont systemFontOfSize:12];
    self.updateLab = updateLab;
    [cycleScrollView addSubview:updateLab];
    [updateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TLab.mas_right).offset(5);
        make.bottomMargin.mas_equalTo(TLab);
    }];

    UILabel *wuranTLab = [[UILabel alloc]init];
    wuranTLab.font = [UIFont systemFontOfSize:12];
    self.wuranTLab = wuranTLab;
    [cycleScrollView addSubview:wuranTLab];
    [wuranTLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(TLab.mas_right).offset(5);
        make.topMargin.mas_equalTo(TLab);
    }];
    
    [self takeOthersInfoWith:cycleScrollView];

}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

//添加信息
-(void)takeOthersInfoWith:(SDCycleScrollView *)cyclescrollview{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tianqi.moji.com/weather/china/hubei/hongshan-district"]]];
    
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    ZLog(@"datastr = %@",datastr);
    
    //截取主要信息
    NSString *reultmain = [self startRangeStr:@"description\" content" endRangeStr:@"keywords" withStr:datastr];
    NSString *result = [self startRangeStr:@"=\"" endRangeStr:@"\">" withStr:reultmain];
    if ([result rangeOfString:@"墨迹天气"].location != NSNotFound) {
        result = [result stringByReplacingOccurrencesOfString:@"墨迹天气" withString:@"哈哈"];
    }
    
    //早晚温度
    NSString *DayT = [self startRangeStr:@"白天：" endRangeStr:@"夜间" withStr:result];
    NSRange nightStartR = [result rangeOfString:@"夜间"];
    NSRange nightrange = NSMakeRange(nightStartR.location + nightStartR.length, result.length - nightStartR.location - nightStartR.length);
    NSString *Night = [result substringWithRange:nightrange];
    NSString *NightT = [self startRangeStr:@"：" endRangeStr:@"度" withStr:Night];
//        ZLog(@"result = %@",NightT);
    //提示信息
    NSRange noticeStartR = [Night rangeOfString:@"度，"];
    NSRange noticerange = NSMakeRange(noticeStartR.location + noticeStartR.length, Night.length - noticeStartR.location - noticeStartR.length);
    NSString *noticestr = [Night substringWithRange:noticerange];
    
    //截取污染指数
    NSString *reult1 = [self startRangeStr:@"span class" endRangeStr:@"<div class=\"wea_info_avator\">" withStr:datastr];
    NSString *reult2 = [self startRangeStr:@"</span>" endRangeStr:@"</a>" withStr:reult1];
    NSString *wuranreult = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reult2];
    //    ZLog(@"result = %@",wuranreult);
    
    
    //更新时间和温度
    NSString *reulttime = [self startRangeStr:@"wea_weather clearfix\">" endRangeStr:@"新<" withStr:datastr];
    //当前温度
    NSString *reultcurr = [self startRangeStr:@"<em>" endRangeStr:@"</em>" withStr:reulttime];
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
    
//    ZLog(@"wind = %@ 污染指数%@ 当前温度%@ 天气%@ 图片%@ %@ 湿度%@ 风向%@ 提示%@ %@",result,wuranreult,reultcurr,reultcurrweather,reultcurrimg,reultupdate,reultshidu,reultwind,reultnotice1,DayT);

    self.detailLab.text = noticestr;
    self.TLab.text = [NSString stringWithFormat:@"%@°",reultcurr];
    [self.Timg sd_setImageWithURL:[NSURL URLWithString:reultcurrimg] placeholderImage:nil];
    self.dayTLab.text = [NSString stringWithFormat:@"白天:%@",DayT];
    self.nightTLab.text = [NSString stringWithFormat:@"夜晚:%@度",NightT];
    self.shiduTLab.text = reultshidu;
    self.windTLab.text = reultwind;
    self.updateLab.text = reultupdate;
    self.wuranTLab.text = wuranreult;
}


//字符截取
-(NSString *)startRangeStr:(NSString *)startStr endRangeStr:(NSString *)endStr withStr:(NSString *)str{
    NSRange startrange = [str rangeOfString:startStr];
    NSRange endrange = [str rangeOfString:endStr];
    NSRange range = NSMakeRange(startrange.location + startrange.length, endrange.location - startrange.location - startrange.length);
    NSString *resultstr = [str substringWithRange:range];
    return resultstr;
}

#pragma mark collection的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mainCollectioncellID forIndexPath:indexPath];
    cell.indexpath = indexPath;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
            if ([self.delegate respondsToSelector:@selector(didSelectBtnWith:)]) {
                [self.delegate didSelectBtnWith:indexPath.item];
            }
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}



#pragma mark 懒加载
-(UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowLaout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 150.0/667.0*HSCREEN, WSCREEN, 150.0/667.0*HSCREEN) collectionViewLayout:flowLaout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[MainHeadCollectionViewCell class] forCellWithReuseIdentifier:mainCollectioncellID];
        flowLaout.minimumLineSpacing = 10;
        flowLaout.minimumInteritemSpacing = 10;
        flowLaout.itemSize = CGSizeMake(Witem, Hitem);
    }
    return _collectionView;
}



@end
