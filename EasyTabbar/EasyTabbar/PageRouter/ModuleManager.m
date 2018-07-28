//
//  ModuleManager.m
//
//  Created by qiliu on 2017/6/30.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "ModuleManager.h"
#import <objc/runtime.h>

static ModuleManager *_manager = nil;
static NSDictionary *moduleDic;


@implementation ModuleManager

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[ModuleManager alloc] init];
        moduleDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Module" ofType:@"plist"]];
    });
    return _manager;
}

- (id)getModuleByURL:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSString *moduleNo = [url host];
    NSString *classNo = [[url path] substringFromIndex:1];
    
    NSString *className = moduleDic[moduleNo][classNo];
    
    id vc = [[NSClassFromString(className) alloc] init];
    
    NSString *params = url.query;
    
    NSArray *t1 = [params componentsSeparatedByString:@"&"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSString *str in t1) {
        NSArray *t2 = [str componentsSeparatedByString:@"="];
        [dic setObject:t2[1] forKey:t2[0]];
    }
    objc_setAssociatedObject(vc, "common_key", dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    return vc;
}



@end
