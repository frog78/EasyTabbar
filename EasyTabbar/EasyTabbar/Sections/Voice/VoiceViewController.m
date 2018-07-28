//
//  VoiceViewController.m
//
//  Created by qiliu on 2017/5/26.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "VoiceViewController.h"

@interface VoiceViewController ()

@end

@implementation VoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.parentViewController.navigationItem.title = @"语音";
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
