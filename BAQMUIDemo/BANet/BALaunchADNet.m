//
//  BALaunchADNet.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/13.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BALaunchADNet.h"
#import "YYModel.h"

@implementation BALaunchADNet
BAKit_SingletonM(BALaunchADNet)

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
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

#pragma mark - 此处模拟广告数据请求,实际项目中请做真实请求
- (void)ba_launchADNet_getVideoDataCompletionHandle:(void (^)(id data, NSError *))completionHandle
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *jsonData = ba_getDataWithContentsOfFile(@"LaunchVideoAd", @"json");
        NSDictionary *dict = ba_getDictionaryWithData(jsonData);
        if (completionHandle)
        {
            completionHandle(dict, nil);
        }
    });
    
}

/*!
 *  示例1：DemoVC1中的网络获取示例
 *
 *  @param startIndex index
 *
 *  @return DemoVC1中的网络获取示例
 */
- (id)ba_getVideosWithStartIndex:(NSInteger)startIndex completionHandle:(void (^)(BAVideoModel *data, NSError *))completionHandle
{
    NSString *path = [NSString stringWithFormat:KVideoPath, startIndex];
    
    return [BANetManager ba_requestWithType:BAHttpRequestTypeGet urlString:path parameters:nil successBlock:^(id response) {
        
        completionHandle([BAVideoModel yy_modelWithJSON:response], nil);
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"error：%@", error);
        completionHandle(nil, error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

@end
