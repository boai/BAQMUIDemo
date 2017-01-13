//
//  BALaunchADNet.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BABaseNet.h"
#import "BAVideoModel.h"

@interface BALaunchADNet : BABaseNet
BAKit_SingletonH(BALaunchADNet)

- (void)ba_launchADNet_getImageDataCompletionHandle:(void (^)(id data, NSError *))completionHandle;

- (void)ba_launchADNet_getVideoDataCompletionHandle:(void (^)(id data, NSError *))completionHandle;

- (id)ba_getVideosWithStartIndex:(NSInteger)startIndex completionHandle:(void (^)(BAVideoModel *data, NSError *))completionHandle;

@end
