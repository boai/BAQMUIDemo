//
//  AppDelegate.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+BAQMUI.h"

#import "BAHomeVC.h"
#import "BAMeVC.h"

#import "BANavigationController.h"
#import "BATabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self ba_setupAppDelegate];
    
    return YES;
}

#pragma mark - 系统配置
- (void)ba_setupAppDelegate
{
    /*! QMUI 的配置 */
    [self ba_setupQMUI];
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
    homeNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"首页" image:[UIImageMake(@"icon_tabbar_uikit") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_uikit_selected")  selectedTitleColor:UIColorGreen tag:0];
    homeVC.title = homeNavi.tabBarItem.title;
    
    /*! meVC */
    BAMeVC *meVC = [[BAMeVC alloc] init];
    meVC.hidesBottomBarWhenPushed = NO;
    BANavigationController *meNavi = [[BANavigationController alloc] initWithRootViewController:meVC];
    meNavi.tabBarItem = [BAUIHelper ba_uiHelper_tabbarItemWithTitle:@"我" image:[UIImageMake(@"icon_tabbar_lab") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:UIImageMake(@"icon_tabbar_lab_selected")  selectedTitleColor:UIColorRed tag:1];
    meVC.title = meNavi.tabBarItem.title;

    tabbarController.viewControllers = @[homeNavi, meNavi];
    self.window.rootViewController = tabbarController;
    [self.window makeKeyAndVisible];
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
