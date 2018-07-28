//
//  MainViewController.m
//
//  Created by qiliu on 2017/5/26.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+Frame.h"
#import "UIViewController+Router.h"

@interface MainViewController () 

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [btn setTitle:@"PageRouter" forState:0];
    btn.backgroundColor = [UIColor grayColor];
    btn.centerX = self.view.centerX;
    btn.centerY = self.view.centerY;
    [btn addTarget:self action:@selector(routerClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)routerClick {
    [self.parentViewController.navigationController openURL:@"EasyTabbar://Main/Router"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.parentViewController.navigationItem.title = @"首页";
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
