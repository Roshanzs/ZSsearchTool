//
//  HomeViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "HomeViewController.h"
#import "MainHeadView.h"

#define homecellid @"homecellid"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIView *mainheadView;

//tableviewcell的数据
@property(nonatomic,strong)NSArray *tableViewCellDataArr;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

#pragma mark tableview懒加载
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homecellid forIndexPath:indexPath];
    return cell;
}

#pragma mark 懒加载
-(UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = self.mainheadView;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:homecellid];
    }
    return _tableview;
}

-(UIView *)mainheadView{
    if (_mainheadView == nil) {
        _mainheadView = [[MainHeadView alloc]initWithFrame:CGRectMake(0, 0, WSCREEN, 300.0/667.0*HSCREEN)];
    }
    return _mainheadView;
}


-(NSArray *)tableViewCellDataArr{
    if (_tableViewCellDataArr == nil) {
        _tableViewCellDataArr = [NSArray array];
    }
    return _tableViewCellDataArr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
