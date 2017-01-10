//
//  DemoVC1.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseViewController.h"

@interface DemoVC1 : BABaseViewController

@end

@interface DemoVC1 (UISubclassingHooks)

// 子类继承，可以不调super
- (void)initDataSource;
- (void)didSelectCellWithTitle:(NSString *)title;

@end
