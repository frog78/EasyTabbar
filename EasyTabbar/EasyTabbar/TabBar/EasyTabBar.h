//
//  iFlyTabBar.h
//  iFlyTabbarDemo
//
//  Created by qiliu on 2017/5/25.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EasyTabBar : UIViewController

/**
 从配置文件中读取的控制器
 */
@property (nonatomic, strong)NSArray *viewControllers;

/**
 *  设置当前选中的标签index
 */
- (void)setTabbarSelectIndex:(int)index;


/**
 *  根据选中的btn tag，设置所有标签按钮的状态
 */
- (void)setTabBarButtonStateAtIndex:(int)index;

@end
