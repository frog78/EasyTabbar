//
//  iFlyTabBarController.m
//  iFlyTabbarDemo
//
//  Created by qiliu on 2017/5/25.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "EasyTabBarController.h"
#import "EasyTabBar.h"


@interface EasyTabBarController () {
    
    EasyTabBar *_tabBar;
}

@end

@implementation EasyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTabBar];
}

/**
 初始化CSTabBar
 */
- (void)initTabBar {
    
    _tabBar = [[EasyTabBar alloc] init];
    [_tabBar.view.layer setZPosition:100];
    [self.tabBar addSubview:_tabBar.view];
    self.viewControllers = _tabBar.viewControllers;
    [_tabBar setTabbarSelectIndex:0];
}

#pragma mark - tabBar Delegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSUInteger index = [tabBar.items indexOfObject:item];
    
    NSLog(@"CurrentIndex:%lu", (unsigned long)index);
    [_tabBar setTabbarSelectIndex:(int)index];
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
