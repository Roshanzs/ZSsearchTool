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
    cycleScrollView.localizationImageNamesGroup = @[@"timg",@"timg-3",@"timg-2"];
    [self addSubview:cycleScrollView];
    [self addSubview:self.collectionView];
    

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
