//
//  AppDelegate+BALaunch.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/11.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate+BALaunch.h"
#import "CoreLaunchLite.h"
#import "CoreLaunchCool.h"
#import "CoreLaunchPro.h"
#import "CoreLaunchPlus.h"


@implementation AppDelegate (BALaunch)




- (UIView *)ba_getLaunchView
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    
    launchView.frame = self.window.bounds;
    [self.window addSubview:launchView];
    
    return launchView;
}

- (void)ba_setupLaunch
{
//    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
//    UIView *launchView = viewController.view;
//    
//    launchView.frame = self.window.bounds;
//    [self.window addSubview:launchView];
    
#pragma mark - 第一种动画
//    UIImageView *backgroundImageView = launchView.subviews[0];
//    backgroundImageView.translatesAutoresizingMaskIntoConstraints = YES;
//    backgroundImageView.frame = launchView.bounds;
//    backgroundImageView.clipsToBounds = YES;
    
//    UIImageView *logoImageView = launchView.subviews[1];
//    NSLog(@"0000 : %@", launchView.subviews);
//    UILabel *copyrightLabel = launchView.subviews[2];
//    
//    UIView *maskView = [[UIView alloc] initWithFrame:launchView.bounds];
//    maskView.backgroundColor = UIColorWhite;
//    [launchView insertSubview:maskView belowSubview:backgroundImageView];
//
//    [UIView animateWithDuration:.15 delay:0.9 options:QMUIViewAnimationOptionsCurveOut animations:^{
//        backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundImageView.bounds), 64);
//        logoImageView.alpha = 0.0;
//        copyrightLabel.alpha = 0;
//    } completion:nil];
//    [UIView animateWithDuration:1.2 delay:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        maskView.alpha = 0;
//        backgroundImageView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [launchView removeFromSuperview];
//    }];

#pragma mark - 第二种动画
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIView *launchView = viewController.view;
    
    launchView.frame = self.window.bounds;
    [self.window addSubview:launchView];
    
    [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
//        backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(backgroundImageView.bounds), 64);
//        logoImageView.alpha = 0.0;
//        copyrightLabel.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            launchView.alpha = 0.0f;
            launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
         } completion:^(BOOL finished) {
                [launchView removeFromSuperview];
         }];
    }];
    
}

- (void)ba_launchAnimationWithType:(BALaunchAnimationType)type
{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    switch (type) {
        case BALaunchAnimationTypeLite:
            [CoreLaunchLite animWithWindow:self.window image:nil];
            break;
        case BALaunchAnimationTypePlus:
            [CoreLaunchPlus animWithWindow:self.window image:nil];
            break;
        case BALaunchAnimationTypeCool:
            [CoreLaunchCool animWithWindow:self.window image:nil];
            break;
        case BALaunchAnimationTypePro:
            [CoreLaunchPro animWithWindow:self.window image:nil];
            break;

            
        default:
            break;
    }
}


@end
