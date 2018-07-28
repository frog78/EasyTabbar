//
//  MainViewController.m
//
//  Created by qiliu on 2017/5/26.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    
    UIWebView *webView;
    
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 45)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:webView];
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
