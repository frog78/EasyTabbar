//
//  ModuleManager.h
//
//  Created by qiliu on 2017/6/30.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModuleManager : NSObject

+ (instancetype)shareInstance;

- (id)getModuleByURL:(NSString *)urlStr;



@end
