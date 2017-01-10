//
//  DemoVC2.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC2.h"

@interface DemoVC2 ()

@end

@implementation DemoVC2

- (void)initDataSource
{
    self.dataSourceArray = @[@"Loading",
                             @"Loading With Text",
                             @"Tips For Succeed",
                             @"Tips For Error",
                             @"Tips For Info",
                             @"Custom TintColor",
                             @"Custom BackgroundView Style",
                             @"Custom Animator",
                             @"Custom Content View"];
}

- (void)didSelectCellWithTitle:(NSString *)title
{
    UIView *contentView = self.navigationController.view;

    if ([title isEqualToString:@"Loading"])
    {
        QMUITips *tips = [QMUITips createTipsToView:contentView];
        QMUIToastContentView *tostContentView = (QMUIToastContentView *)tips.contentView;
        tostContentView.backgroundColor = UIColorRed;
        tostContentView.minimumSize = CGSizeMake(90, 90);
        tostContentView.layer.masksToBounds = YES;
        tostContentView.layer.cornerRadius = 5.0f;
        
        [tips showLoadingHideAfterDelay:2.0f];
    }
    else if ([title isEqualToString:@"Loading With Text"])
    {
    
    }
    else if ([title isEqualToString:@"Tips For Succeed"])
    {
        
    }
    else if ([title isEqualToString:@"Tips For Error"])
    {
        
    }
    else if ([title isEqualToString:@"Tips For Info"])
    {
        
    }
    else if ([title isEqualToString:@"Custom TintColor"])
    {
        
    }
    else if ([title isEqualToString:@"Custom BackgroundView Style"])
    {
        
    }
    else if ([title isEqualToString:@"Custom Animator"])
    {
        
    }
    else if ([title isEqualToString:@"Custom Content View"])
    {
        
    }
}


@end
