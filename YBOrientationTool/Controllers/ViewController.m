//
//  ViewController.m
//  YBOrientationTool
//
//  Created by 王迎博 on 2018/9/29.
//  Copyright © 2018年 王颖博. All rights reserved.
//

#import "ViewController.h"
#import "BaseWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    button.center = self.view.center;
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)testClick:(UIButton *)sender {
    BaseWebViewController *webVC = [[BaseWebViewController alloc] init];
    webVC.webUrlStr = @"https://www.baidu.com";
    [self.navigationController pushViewController:webVC animated:YES];
}




@end
