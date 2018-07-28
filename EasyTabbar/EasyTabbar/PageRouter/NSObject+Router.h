//
//  NSObject+Router.h
//
//  Created by qiliu on 2017/8/1.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RouterBlock) (int code, id d);

@interface NSObject (Router)

- (void)invoke:(NSString *)urlString;

- (void)invoke:(NSString *)urlString withCallback:(RouterBlock)callback;


@end
