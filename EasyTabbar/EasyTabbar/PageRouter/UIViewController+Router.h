//
//  UIViewController+Router.h
//
//  Created by qiliu on 2017/6/30.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (Router)

/**
 打开跳转链接

 @param urlString 链接url
 */
- (void)openURL:(NSString *)urlString;

/**
 打开跳转链接，带完成回调

 @param urlString 链接url
 @param completion 完成回调
 */
- (void)openURL:(NSString *)urlString completion:(void(^)(void))completion;

/**
 打开跳转链接，传入对象类型参数

 @param urlString 链接url
 @param para 对象类型参数
 @param completion 完成回调
 */
- (void)openURL:(NSString *)urlString objParameter:(NSArray<NSDictionary<NSString *,id>*> *)para completion:(void(^)(void))completion;

/**
 根据key获取所传参数

 @param key open的时候所传参数key
 @return 返回的参数value值
 */
- (id)getValueByKey:(NSString *)key;

@end
