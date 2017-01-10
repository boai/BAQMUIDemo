//
//  UIColor+BAColorChange.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BAColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *)ba_colorWithHexString:(NSString *)color;

@end
