
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 * 简书    : http://www.jianshu.com/users/95c9800fdf47/latest_articles
 * 简书专题 : http://www.jianshu.com/collection/072d578bf782
 
 *********************************************************************************
 
 */

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************

 最新更新时间：2016-11-24 【倒叙】
 最新Version：【Version：2.1】
 更新内容：
 2.1.1、优化方法名命名规范
 2.1.2、新增网络状态实时监测 block 回调，新增单独网络监测 bool 返回，详见 demo
 2.1.3、新增旧方法更新提示
 2.1.4、优化各种注释
 
 最新更新时间：2016-11-17
 最新Version：【Version：2.0】
 更新内容：
    2.0.1、优化方法名命名规范
    2.0.2、新增部分注释
    2.0.3、视频上传方法对接，目前有很多项目对接成功
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define BANetManagerShare [BANetManager sharedBANetManager]

#define BAWeak  __weak __typeof(self) weakSelf = self

/*! 过期属性或方法名提醒 */
#define BANetManagerDeprecated(instead) __deprecated_msg(instead)

/*! 判断是否有网 */
#ifndef kIsHaveNetwork
#define kIsHaveNetwork   [BANetManager ba_isHaveNetwork]
#endif

/*! 判断是否为手机网络 */
#ifndef kIs3GOr4GNetwork
#define kIs3GOr4GNetwork [BANetManager ba_is3GOr4GNetwork]
#endif

/*! 判断是否为WiFi网络 */
#ifndef kIsWiFiNetwork
#define kIsWiFiNetwork   [BANetManager ba_isWiFiNetwork]
#endif


/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, BANetworkStatus)
{
    /*! 未知网络 */
    BANetworkStatusUnknown           = 0,
    /*! 没有网络 */
    BANetworkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    BANetworkStatusReachableViaWWAN,
    /*! wifi 网络 */
    BANetworkStatusReachableViaWiFi
};

/*！定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger, BAHttpRequestType)
{
    /*! get请求 */
    BAHttpRequestTypeGet = 0,
    /*! post请求 */
    BAHttpRequestTypePost,
    /*! put请求 */
    BAHttpRequestTypePut,
    /*! delete请求 */
    BAHttpRequestTypeDelete
};

/*! 实时监测网络状态的 block */
typedef void(^BANetworkStatusBlock)(BANetworkStatus status);

/*! 定义请求成功的 block */
typedef void( ^ BAResponseSuccess)(id response);
/*! 定义请求失败的 block */
typedef void( ^ BAResponseFail)(NSError *error);

/*! 定义上传进度 block */
typedef void( ^ BAUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ BADownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

/*!
 *  方便管理请求任务。执行取消，暂停，继续等任务.
 *  - (void)cancel，取消任务
 *  - (void)suspend，暂停任务
 *  - (void)resume，继续任务
 */
typedef NSURLSessionTask BAURLSessionTask;



@interface BANetManager : NSObject

/*! 获取当前网络状态 */
@property (nonatomic, assign) BANetworkStatus netWorkStatu;

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类BANetManager单例
 */
+ (BANetManager *)sharedBANetManager;

#pragma mark - 网络请求的类方法 --- get / post / put / delete
/*!
 *  网络请求方法,block回调
 *
 *  @param type         get / post
 *  @param urlString    请求的地址
 *  @param parameters    请求的参数
 *  @param successBlock 请求成功的回调
 *  @param failureBlock 请求失败的回调
 *  @param progress 进度
 */
+ (BAURLSessionTask *)ba_requestWithType:(BAHttpRequestType)type
                               urlString:(NSString *)urlString
                              parameters:(NSDictionary *)parameters
                            successBlock:(BAResponseSuccess)successBlock
                            failureBlock:(BAResponseFail)failureBlock
                                progress:(BADownloadProgress)progress;

/*!
 *  上传图片(多图)
 *
 *  @param parameters   上传图片预留参数---视具体情况而定 可移除
 *  @param imageArray   上传的图片数组
 *  @param fileName     上传的图片数组fileName
 *  @param urlString    上传的url
 *  @param successBlock 上传成功的回调
 *  @param failureBlock 上传失败的回调
 *  @param progress     上传进度
 */
+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                         fileName:(NSString *)fileName
                                     successBlock:(BAResponseSuccess)successBlock
                                      failurBlock:(BAResponseFail)failureBlock
                                   upLoadProgress:(BAUploadProgress)progress;

/*!
 *  视频上传
 *
 *  @param parameters   上传视频预留参数---视具体情况而定 可移除
 *  @param videoPath    上传视频的本地沙河路径
 *  @param urlString     上传的url
 *  @param successBlock 成功的回调
 *  @param failureBlock 失败的回调
 *  @param progress     上传的进度
 */
+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(BAResponseSuccess)successBlock
                       failureBlock:(BAResponseFail)failureBlock
                     uploadProgress:(BAUploadProgress)progress;

/*!
 *  文件下载
 *
 *  @param operations   文件下载预留参数---视具体情况而定 可移除
 *  @param savePath     下载文件保存路径
 *  @param urlString        请求的url
 *  @param successBlock 下载文件成功的回调
 *  @param failureBlock 下载文件失败的回调
 *  @param progress     下载文件的进度显示
 */
+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          savaPath:(NSString *)savePath
                                      successBlock:(BAResponseSuccess)successBlock
                                      failureBlock:(BAResponseFail)failureBlock
                                  downLoadProgress:(BADownloadProgress)progress;

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)ba_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus;

/*!
 *  是否有网
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)ba_isHaveNetwork;

/*!
 *  是否是手机网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)ba_is3GOr4GNetwork;

/*!
 *  是否是 WiFi 网络
 *
 *  @return YES, 反之:NO
 */
+ (BOOL)ba_isWiFiNetwork;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)ba_cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)ba_cancelRequestWithURL:(NSString *)URL;


#pragma mark - 各版本过期方法名
#pragma mark version 2.0 过期方法名
+ (BAURLSessionTask *)ba_requestWithType:(BAHttpRequestType)type
                               UrlString:(NSString *)urlString
                              Parameters:(NSDictionary *)parameters
                            SuccessBlock:(BAResponseSuccess)successBlock
                            FailureBlock:(BAResponseFail)failureBlock
                                progress:(BADownloadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_requestWithType:(BAHttpRequestType)type urlString:(NSString *)urlString parameters:(NSDictionary *)parameters successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock progress:(BADownloadProgress)progress");

+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       ImageArray:(NSArray *)imageArray
                                         FileName:(NSString *)fileName
                                     SuccessBlock:(BAResponseSuccess)successBlock
                                      FailurBlock:(BAResponseFail)failureBlock
                                   UpLoadProgress:(BAUploadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_uploadImageWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters imageArray:(NSArray *)imageArray fileName:(NSString *)fileName successBlock:(BAResponseSuccess)successBlock failurBlock:(BAResponseFail)failureBlock upLoadProgress:(BAUploadProgress)progress");

+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          VideoPath:(NSString *)videoPath
                       SuccessBlock:(BAResponseSuccess)successBlock
                       FailureBlock:(BAResponseFail)failureBlock
                     UploadProgress:(BAUploadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (void)ba_uploadVideoWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters videoPath:(NSString *)videoPath successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock uploadProgress:(BAUploadProgress)progress");

+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          SavaPath:(NSString *)savePath
                                      SuccessBlock:(BAResponseSuccess)successBlock
                                      FailureBlock:(BAResponseFail)failureBlock
                                  DownLoadProgress:(BADownloadProgress)progress BANetManagerDeprecated("该方法已过期,请使用最新方法：+ (BAURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters savaPath:(NSString *)savePath successBlock:(BAResponseSuccess)successBlock failureBlock:(BAResponseFail)failureBlock downLoadProgress:(BADownloadProgress)progress");

@end
