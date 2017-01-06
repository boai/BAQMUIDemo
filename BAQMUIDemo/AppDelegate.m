//
//  AppDelegate.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate.h"

#import <QMUITabBarViewController.h>
#import <QMUINavigationController.h>
#import <QMUIConfigurationTemplate.h>

#import "BAHomeVC.h"
#import "BAMeVC.h"

#import "BANavigationController.h"
#import "BATabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*! QMUI的配置 */
    [self ba_setupQMUI];
    
    return YES;
}

#pragma mark - QMUI的配置
- (void)ba_setupQMUI
{
    /*! 启动QMUI的配置模板 */
    [QMUIConfigurationTemplate setupConfigurationTemplate];
    
    /*! 将全局的控件样式渲染出来 */
    [QMUIConfigurationManager renderGlobalAppearances];
    
    /*! 将状态栏设置为希望的样式 */
    [QMUIHelper renderStatusBarStyleLight];
    
    /*! 预加载 QQ 表情，避免第一次使用时卡顿 */
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [QMUIQQEmotionManager emotionsForQQ];
    });
    
    /*! 界面 */
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self ba_creatTabbarController];
    
}

- (void)ba_creatTabbarController
{
    BATabBarViewController *tabbarController = [[BATabBarViewController alloc] init];
    
    /*! homeVC */
    BAHomeVC *homeVC = [[BAHomeVC alloc] init];
    homeVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *homeNavi = [[BANavigationController alloc] initWithRootViewController:homeVC];
    homeVC.tabBarItem = [];
    
    
    /*! meVC */
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
