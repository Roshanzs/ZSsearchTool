//
//  MainHeadCollectionViewCell.m
//  Enjoy-Booking
//
//  Created by Tony on 2017/1/7.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "MainHeadCollectionViewCell.h"

@interface MainHeadCollectionViewCell()
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *label;

@end
@implementation MainHeadCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    UIImageView *img = [[UIImageView alloc]init];
    self.imageView = img;
    [self.contentView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(15.0/375.0*WSCREEN);
        make.right.mas_equalTo(self.contentView).offset(-15.0/375.0*WSCREEN);
        make.bottom.mas_equalTo(self.contentView).offset(-15.0/667.0*HSCREEN);
    }];
    
    UILabel *lab = [[UILabel alloc]init];
    self.label = lab;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(img.mas_bottom);
    }];
}

-(void)setImg:(NSString *)imgstr Withlab:(NSString *)lab{
    self.imageView.image = [UIImage imageNamed:imgstr];
    self.label.text = lab;
}

//set赋值
-(void)setIndexpath:(NSIndexPath *)indexpath{
    _indexpath = indexpath;
    switch (indexpath.item) {
        case 0:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 1:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 2:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 3:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 4:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 5:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 6:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
        case 7:
            [self setImg:@"headtest" Withlab:@"美食"];
            break;
   
        default:
            break;
    }
}












@end
