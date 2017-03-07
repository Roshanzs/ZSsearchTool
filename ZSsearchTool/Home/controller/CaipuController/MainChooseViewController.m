//
//  MainChooseViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "MainChooseViewController.h"
#import "MainChooesModel.h"
#import "MainDeteilViewController.h"
@interface MainChooseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)MainInfoModel *model;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataarr;
@end

#define chooescellid @"chooescellid"
@implementation MainChooseViewController

-(instancetype)initWithInfoModel:(MainInfoModel *)model{
    self.model = model;
    return [super init];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self getDataWithNet];
}

//加载数据
-(void)getDataWithNet{
    MOBARequest *request = [MOBACookRequest searchMenuRequestByCid:self.model.ctgId name:nil page:0 size:0];
    WeakSelf(self);
    NSMutableArray *Marr = [NSMutableArray array];
    [MobAPI sendRequest:request onResult:^(MOBAResponse *response)
     {
         NSDictionary *dict = response.responder;
         MainChooesModel *model = [MainChooesModel modelWithDict:dict];
         weakself.navigationItem.title = model.name;
         for (NSDictionary *dic in model.list) {
             MainChooesModel *listmodel = [MainChooesModel modelWithDict:dic];
             [Marr addObject:listmodel];
         }
         self.dataarr = Marr.copy;
         [self.tableview reloadData];
         ZLog(@"%@",dict);
     }];
    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:chooescellid forIndexPath:indexPath];
    MainChooesModel *model = self.dataarr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MainChooesModel *model = self.dataarr[indexPath.row];
    MainDeteilViewController *deteilVC = [[MainDeteilViewController alloc]initWithChooesModel:model];
    [self.navigationController pushViewController:deteilVC animated:YES];
}

#pragma mark 懒加载
-(UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:chooescellid];
    }
    return _tableview;
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
