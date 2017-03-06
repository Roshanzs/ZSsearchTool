//
//  HomeTableViewCell.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/3.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    UILabel *lab = [[UILabel alloc]init];
    self.lab = lab;
    [self.contentView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self.contentView);
    }];
}

@end
