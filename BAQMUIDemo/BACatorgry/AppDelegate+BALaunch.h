//
//  AppDelegate+BALaunch.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/11.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "AppDelegate.h"

typedef NS_ENUM(NSUInteger, BALaunchAnimationType) {
    BALaunchAnimationTypeLite = 0,
    BALaunchAnimationTypePlus,
    BALaunchAnimationTypeCool,
    BALaunchAnimationTypePro
};

@interface AppDelegate (BALaunch)

- (void)ba_setupLaunch;
- (void)ba_launchAnimationWithType:(BALaunchAnimationType)type;

@end
