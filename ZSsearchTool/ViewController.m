//
//  ViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/3.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "ViewController.h"
#import <MobAPI/MobAPI.h>
#import <MOBFoundation/MOBFoundation.h>
#import "HomeTableViewCell.h"
#define viewcellid @"viewcellid"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *cellTitlesArray;
@property(nonatomic,strong)NSArray *sectionTitlesArray;
@property(nonatomic,strong)NSMutableDictionary *dataDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [MobAPI apiQueryWithResult:^(MOBAResponse *response) {
//        ZLog(@"%@",response.responder);
    }];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"MobApiCategory" ofType:@"plist"];
    NSDictionary *plistDict = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    self.sectionTitlesArray = [[plistDict objectForKey:@"ApiCategory"] objectForKey:@"SectionTitlesArray"];
    self.cellTitlesArray = [[plistDict objectForKey:@"ApiCategory"] objectForKey:@"CellTitlesArray"];

}

#pragma mark collection代理方法
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:viewcellid forIndexPath:indexPath];
    cell.lab.text = self.cellTitlesArray[indexPath.section][indexPath.row];
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
        [_tableview registerClass:[HomeTableViewCell class] forCellReuseIdentifier:viewcellid];
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
