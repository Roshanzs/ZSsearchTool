//
//  MainInfoViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "MainInfoViewController.h"
#import "MainInfoModel.h"
@interface MainInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *sectionTitlesArray;
@property(nonatomic,strong)NSArray *cellTitlesArray;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSString *selectedTitle;
@property(nonatomic,strong)UITableView *tableview;

@end
#define viewcellid @"viewcellid"

@implementation MainInfoViewController

-(instancetype)initWithDic:(NSDictionary *)dic{
//    ZLog(@"respone = %@",dic);
    MainInfoModel *model = [MainInfoModel modelWithDict:dic];
    MainInfoModel *infomodel = [MainInfoModel modelWithDict:model.categoryInfo];
    self.navigationItem.title = infomodel.name;
    NSMutableArray *sarr = [NSMutableArray array];
    NSMutableArray *carr = [NSMutableArray array];
    for (NSDictionary *dict in model.childs) {
        MainInfoModel *childmodel = [MainInfoModel modelWithDict:dict];
        MainInfoModel *namemodel = [MainInfoModel modelWithDict:childmodel.categoryInfo];
        [sarr addObject:namemodel.name];
        NSMutableArray *cellArr = [NSMutableArray array];
        for (NSDictionary *dic in childmodel.childs) {
            MainInfoModel *childinfomodel = [MainInfoModel modelWithDict:dic];
            MainInfoModel *childmodels = [MainInfoModel modelWithDict:childinfomodel.categoryInfo];
            [cellArr addObject:childmodels];
        }
        [carr addObject:cellArr];
    }
    self.sectionTitlesArray = sarr.copy;
    self.cellTitlesArray = carr.copy;
  return  [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

#pragma mark tableview代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sectionTitlesArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *bnt = [[UIButton alloc]init];
    [bnt setTitle:self.sectionTitlesArray[section] forState:UIControlStateNormal];
    [bnt addTarget:self action:@selector(showOrHiddeRowWithBtn:) forControlEvents:UIControlEventTouchUpInside];
    bnt.tag = section + 1000;
    return bnt;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 取出字典中的 section 如果是第 0 个分区 那么就返回该分区的数据
    if ([[self.dataDic valueForKey:[NSString stringWithFormat:@"%ld",section]] isEqualToString:@"0"])
    {
        return [self.cellTitlesArray[section] count];
    }else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:viewcellid forIndexPath:indexPath];
    MainInfoModel *model = self.cellTitlesArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}

//点击head隐藏显示row
-(void)showOrHiddeRowWithBtn:(UIButton *)btn{
    NSInteger temp = btn.tag - 1000;
    // 修改 每个区的收缩状态  因为每次点击后对应的状态改变 temp代表是哪个section
    if ([[self.dataDic valueForKey:[NSString stringWithFormat:@"%ld",temp]]isEqualToString:@"0"] )
    {
        [self.dataDic setObject:@"1" forKey:[NSString stringWithFormat:@"%ld",temp]];
    }else
    {
        [self.dataDic setObject:@"0" forKey:[NSString stringWithFormat:@"%ld",temp]];
    }
    // 更新 section
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:temp] withRowAnimation:(UITableViewRowAnimationFade)];
}


#pragma mark 懒加载

-(UITableView *)tableview{
    if (_tableview == nil) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.sectionFooterHeight = 0;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:viewcellid];
    }
    return _tableview;
}

-(NSMutableDictionary *)dataDic{
    if (_dataDic == nil) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
