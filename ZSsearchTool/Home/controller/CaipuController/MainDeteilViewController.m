//
//  MainDeteilViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/6.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "MainDeteilViewController.h"

@interface MainDeteilViewController ()
@property(nonatomic,strong)MainChooesModel *model;
@end

@implementation MainDeteilViewController

-(instancetype)initWithChooesModel:(MainChooesModel *)model{
    self.model = model;
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataWithNet];
}

//网络获取数据
-(void)getDataWithNet{
    MOBARequest *request = [MOBACookRequest infoDetailRequestById:self.model.menuId];
    [MobAPI sendRequest:request onResult:^(MOBAResponse *response)
     {
         ZLog(@"%@",response.responder);
     }];

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
