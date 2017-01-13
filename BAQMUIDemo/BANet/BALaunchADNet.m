//
//  BALaunchADNet.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BALaunchADNet.h"

@implementation BALaunchADNet
BAKit_SingletonM(BALaunchADNetShare)


- (void)ba_launchADNet_getImageDataCompletionHandle:(void (^)(id data, NSError *))completionHandle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *jsonData = ba_getDataWithContentsOfFile(@"LaunchImageAd", @"json");
        NSDictionary *dict = ba_getDictionaryWithData(jsonData);
        if (completionHandle)
        {
            completionHandle(dict, nil);
        }
    });
}


@end
