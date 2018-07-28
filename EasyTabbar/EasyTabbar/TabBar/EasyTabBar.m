//
//  iFlyTabBar.m
//  iFlyTabbarDemo
//
//  Created by qiliu on 2017/5/25.
//  Copyright © 2017年 frog78. All rights reserved.
//

#import "EasyTabBar.h"
#import "Macro.h"
#import "UIView+Frame.h"



@interface EasyTabBar () {
    
    /** 当前选中的标签页 */
    int _currentSelectIndex;
    //背景信息存储
    NSDictionary *background;
    //item信息存储
    NSArray *tabItems;
    
    float itemWidth;
    float tabbarHeight;
    NSString *title_color_sel;
    NSString *title_color_unsel;
    
}

@end

@implementation EasyTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self analyzeConfig];
    [self loadTabBarView];
}


/**
 读取、解析配置
 */
- (void)analyzeConfig {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"tabconfig" ofType:@"plist"];
    NSAssert(plistPath && ![plistPath isEqualToString:@""], @"必须要有配置文件tabconfig.plist");
    
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    background = dic[@"Background"];
    
    tabItems = dic[@"TabItems"];

    itemWidth = SCREEN_WIDTH / tabItems.count;
    
    _currentSelectIndex = -1;
}

/**
 加载tabbar
 */
- (void)loadTabBarView {
    
    [self loadTabBarBackground];
    [self loadTabBarItems];
    
}


/**
 TabBar 的背景
 */
- (void)loadTabBarBackground {
    
    NSNumber *bgHeight = background[@"height"];
    NSString *bgColor = background[@"color"];
    NSString *bgImage = background[@"image"];
    
    title_color_sel = background[@"title_color_sel"];
    title_color_unsel = background[@"title_color_unsel"];
    
    if (!title_color_sel || [title_color_sel isEqualToString:@""]) {
        title_color_sel = TITLE_COLOR_SEL_DEFAULT;
    }
    
    if (!title_color_sel || [title_color_sel isEqualToString:@""]) {
        title_color_sel = TITLE_COLOR_SEL_DEFAULT;
    }

    
    if (!bgHeight || bgHeight.integerValue <= 0) {
        tabbarHeight = TABBAR_DEFAULT_HEIGHT;
    } else {
        tabbarHeight = bgHeight.integerValue;
    }
    self.view.frame = CGRectMake(0, TABBAR_DEFAULT_HEIGHT - bgHeight.integerValue, SCREEN_WIDTH, tabbarHeight);
    
    if (bgImage && ![bgImage isEqualToString:@""]) {
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        bgImageView.image = [UIImage imageNamed:bgImage];
        bgImageView.tag = 1000;
        [self.view addSubview:bgImageView];
        
    } else {
        
        NSString *regex = @"^#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL isValid = [predicate evaluateWithObject:bgColor];
        
        if (isValid) {
            self.view.backgroundColor = [self colorWithHex:bgColor];
        } else {
            self.view.backgroundColor = [self colorWithHex:TABBAR_DEFAULT_BACKGROUND_COLOR];
        }
    }
}

/**
 TabBar 的按钮
 */
- (void)loadTabBarItems {
    
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < tabItems.count; i ++) {
        NSDictionary *itemDic = tabItems[i];
    
        NSString *ctlName = itemDic[@"controller"];
        if (ctlName && ![ctlName isEqualToString:@""]) {
            Class aClass = NSClassFromString(ctlName);
            UIViewController *aCtl = [[aClass alloc] init];
            [controllers addObject:aCtl];
        }
        
        NSDictionary *icon = itemDic[@"icon"];
        NSNumber *icon_y = icon[@"icon_y"];
        NSNumber *icon_width = icon[@"icon_width"];
        NSNumber *icon_height = icon[@"icon_height"];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, [icon_y floatValue], [icon_width floatValue], [icon_height floatValue])];
        iconView.centerX = (i + 1. / 2.) * itemWidth;
        iconView.image = [UIImage imageNamed:icon[@"icon_unsel"]];
        iconView.tag = i;
        [self.view addSubview:iconView];
        
        
        NSDictionary *title = itemDic[@"title"];
        NSNumber *title_y = title[@"title_y"];
        if (!title_y || [title_y floatValue] == 0.) {
            continue;
        }
        NSNumber *title_size = title[@"title_size"];
        NSString *title_str = title[@"title_str"];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, [title_y floatValue], itemWidth, tabbarHeight - [title_y floatValue])];
        titleLabel.centerX = (i + 1. / 2.) * itemWidth;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:[title_size floatValue]];
        titleLabel.text = title_str;
        titleLabel.textColor = [self colorWithHex:title_color_unsel];
        titleLabel.tag = i;
        [self.view addSubview:titleLabel];
    }
    _viewControllers = controllers;
}



/**
 设置item选中状态

 @param index 选中的index
 */
- (void)setTabbarSelectIndex:(int)index
{
    if (_currentSelectIndex != index)
    {
        [self setTabBarButtonStateAtIndex:index];
    }
}

/**
 *  根据选中的btn tag，设置所有标签按钮的状态
 */
- (void)setTabBarButtonStateAtIndex:(int)index
{
    _currentSelectIndex = index;
    NSArray *subviews = self.view.subviews;
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            UILabel *title = (UILabel *)view;
            if (title.tag == index) {
                [title setTextColor:[self colorWithHex:title_color_sel]];
            } else if (title.tag < tabItems.count) {
                [title setTextColor:[self colorWithHex:title_color_unsel]];
            }
        }
        if ([view isKindOfClass:[UIImageView class]]) {
            UIImageView *imgView = (UIImageView *)view;
            
            if (imgView.tag >= tabItems.count) {
                continue;
            }
            NSDictionary *item = tabItems[imgView.tag];
            NSDictionary *icon = item[@"icon"];
            if (imgView.tag == index)
            {
                imgView.image = [UIImage imageNamed:icon[@"icon_sel"]];
            } else {
                imgView.image = [UIImage imageNamed:icon[@"icon_unsel"]];
            }
        }
    }
}



/**
 16进制颜色值转换颜色对象

 @param hexColor 颜色16进制值
 @return 返回颜色对象
 */
- (UIColor *)colorWithHex:(NSString *)hexColor {
    
    NSString *string = [hexColor substringFromIndex:1];//去掉#号
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    /* 调用下面的方法处理字符串 */
    red = [self stringToInt:[string substringWithRange:range]];
    
    range.location = 2;
    green = [self stringToInt:[string substringWithRange:range]];
    range.location = 4;
    blue = [self stringToInt:[string substringWithRange:range]];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

- (int)stringToInt:(NSString *)string {
    
    unichar hex_char1 = [string characterAtIndex:0]; /* 两位16进制数中的第一位(高位*16) */
    int int_ch1;
    if (hex_char1 >= '0' && hex_char1 <= '9')
        int_ch1 = (hex_char1 - 48) * 16;   /* 0 的Ascll - 48 */
    else if (hex_char1 >= 'A' && hex_char1 <='F')
        int_ch1 = (hex_char1 - 55) * 16; /* A 的Ascll - 65 */
    else
        int_ch1 = (hex_char1 - 87) * 16; /* a 的Ascll - 97 */
    unichar hex_char2 = [string characterAtIndex:1]; /* 两位16进制数中的第二位(低位) */
    int int_ch2;
    if (hex_char2 >= '0' && hex_char2 <='9')
        int_ch2 = (hex_char2 - 48); /* 0 的Ascll - 48 */
    else if (hex_char1 >= 'A' && hex_char1 <= 'F')
        int_ch2 = hex_char2 - 55; /* A 的Ascll - 65 */
    else
        int_ch2 = hex_char2 - 87; /* a 的Ascll - 97 */
    return int_ch1+int_ch2;
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
