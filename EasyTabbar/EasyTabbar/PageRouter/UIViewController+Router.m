//
//  UIViewController+Router.m
//
//  Created by qiliu on 2017/6/30.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "UIViewController+Router.h"
#import "ModuleManager.h"
#import <objc/runtime.h>

@implementation UIViewController (Router)

- (void)openURL:(NSString *)urlString {
    
    [self openURL:urlString completion:nil];
}

- (void)openURL:(NSString *)urlString completion:(void(^)(void))completion {
    UIViewController *desVC = [[ModuleManager shareInstance] getModuleByURL:urlString];
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *)self;
        
        [nav pushViewController:desVC animated:YES];
        if (completion) {
            completion();
        }
    } else {
        
        [self presentViewController:desVC animated:YES completion:completion];
        
    }
}

- (void)openURL:(NSString *)urlString objParameter:(NSArray<NSDictionary<NSString *,id>*> *)para completion:(void(^)(void))completion {
    
}

- (id)getValueByKey:(NSString *)key {
    
    NSDictionary *dic = objc_getAssociatedObject(self, "common_key");
    return dic[key];
}



@end
