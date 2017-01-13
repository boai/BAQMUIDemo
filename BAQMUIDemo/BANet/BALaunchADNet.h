//
//  BALaunchADNet.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseNet.h"

@interface BALaunchADNet : BABaseNet
BAKit_SingletonH(BALaunchADNetShare)

- (void)ba_launchADNet_getImageDataCompletionHandle:(void (^)(id data, NSError *))completionHandle;

@end
