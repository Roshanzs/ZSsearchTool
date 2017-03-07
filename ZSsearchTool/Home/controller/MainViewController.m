//
//  MainViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "MainViewController.h"
#import "MainHeadView.h"
#import "LocationViewController.h"
#import "MainInfoViewController.h"
#import "KuaidiViewController.h"


#define homecellid @"homecellid"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,MainHeadViewDeleagte>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)MainHeadView *mainheadView;

//tableviewcell的数据
@property(nonatomic,strong)NSArray *tableViewCellDataArr;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    
    UIBarButtonItem *loca = [[UIBarButtonItem alloc]initWithTitle:@"武汉" style:UIBarButtonItemStylePlain target:self action:@selector(createLocation:)];
    self.navigationItem.leftBarButtonItem = loca;
}

//点击定位
-(void)createLocation:(UIBarButtonItem *)item{
    LocationViewController *locationVC = [[LocationViewController alloc]init];
    locationVC.locationSuccess = ^(NSString *city){
        item.title = city;
    };
    [self.navigationController pushViewController:locationVC animated:YES];
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
        _mainheadView.delegate = self;
    }
    return _mainheadView;
}


-(NSArray *)tableViewCellDataArr{
    if (_tableViewCellDataArr == nil) {
        _tableViewCellDataArr = [NSArray array];
    }
    return _tableViewCellDataArr;
}

//mainview的代理方法
-(void)didSelectBtnWith:(NSInteger)intger{
    switch (intger) {
        case 0:
            [self sendRequest:[MOBACookRequest categoryRequest]];
            break;
        case 1:
        {
            KuaidiViewController *kuaiVC = [[KuaidiViewController alloc]init];
            [self.navigationController pushViewController:kuaiVC animated:YES];
        }
            break;
   
        default:
            break;
    }
}


#pragma mark mob方法
- (void)sendRequest:(MOBARequest *)request
{
    [MobAPI sendRequest:request onResult:^(MOBAResponse *response)
     {
         NSDictionary *dict = response.responder;
         if ([[dict objectForKey:@"retCode"] isEqualToString: @"200"]) {
             NSDictionary *dic = [dict objectForKey:@"result"];
             MainInfoViewController *maininfoV = [[MainInfoViewController alloc]initWithDic:dic];
             [self.navigationController pushViewController:maininfoV animated:YES];
         }
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
