//
//  KuaidiViewController.m
//  ZSsearchTool
//
//  Created by 紫贝壳 on 2017/3/7.
//  Copyright © 2017年 stark. All rights reserved.
//

#import "KuaidiViewController.h"
#import <WebKit/WebKit.h>
@interface KuaidiViewController ()
@property(nonatomic,strong)WKWebView *webview;
@property(nonatomic,strong)UITextField *textfiled;
@end

@implementation KuaidiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

-(void)setupUI{
    
    self.webview  = [[WKWebView alloc]init];
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(110);
        make.top.mas_equalTo(self.view).offset(-24);
    }];
        
    UITextField *textfiled = [[UITextField alloc]init];
    textfiled.backgroundColor = [UIColor whiteColor];
    textfiled.placeholder = @"请输入快递单号";
    textfiled.text = @"429070770805";
    [ToolKit ZStextfiled:textfiled ReturnViewWithWidth:10];
    self.textfiled = textfiled;
    [self.view addSubview:textfiled];
    [textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-60);
        make.height.mas_equalTo(40);
    }];
    
        UIButton *loadBnt = [[UIButton alloc]init];
        [self.view addSubview:loadBnt];
        [loadBnt setTitle:@"查询" forState:UIControlStateNormal];
        [loadBnt setBackgroundColor:[UIColor blueColor]];
        [loadBnt addTarget:self action:@selector(loadKuaidiNet) forControlEvents:UIControlEventTouchUpInside];
        [loadBnt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(textfiled);
            make.right.mas_equalTo(self.view);
            make.left.mas_equalTo(textfiled.mas_right);
            make.height.mas_equalTo(textfiled.mas_height);
        }];
}

-(void)loadKuaidiNet{
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?type=&postid=%@",kuaidiUrl,self.textfiled.text]]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
