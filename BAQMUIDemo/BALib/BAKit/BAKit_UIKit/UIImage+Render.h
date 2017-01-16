
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
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */

#import <UIKit/UIKit.h>

@interface UIImage (Render)

/*!
 让图片不被渲染

 @param imageName 图片名称
 @return 不被渲染的图片
 */
+ (UIImage *)ba_imageNamedWithOriginal:(NSString *)imageName;

/*!
 获得新的圆形图片

 @param image 传入需要裁剪成圆形的图片
 @return 返回裁剪好的圆形图片
 */
+ (UIImage *)ba_imageToRoundImageWithImage:(UIImage *)image;

/*!
 传入图片，获得有边框、边框颜色的圆形图片

 @param borderW 边框宽度
 @param color   变宽颜色
 @param image   传入图片

 @return 获得有边框、边框颜色的圆形新图片
 */
+ (UIImage *)ba_imageWithBorderW:(CGFloat)borderW
                     borderColor:(UIColor *)color
                           image:(UIImage *)image;

/*!
 *  传入图片，cell，imageSize，改变自定义大小的系统 cell image
 *
 *  @param cell      cell
 *  @param image     image 可以自己切圆角：[UIImage ba_imageToRoundImageWithImage:UIImageMake(@"icon1.jpg")]；
 *  @param imageSize 图像的 size 记得先切圆角再传 size
 *
 *  @return 返回自定义大小的系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellNormalImageViewSizeWithCell:(UITableViewCell *)cell
                                                       image:(UIImage *)image
                                                   imageSize:(CGSize)imageSize;

/*!
 *  传入图片，cell，imageSize，改变自定义大小的圆形系统 cell image
 *
 *  @param cell      cell
 *  @param image     image 可以自己切圆角：[UIImage ba_imageToRoundImageWithImage:UIImageMake(@"icon1.jpg")]；
 *  @param imageSize 图像的 size 记得先切圆角再传 size
 *
 *  @return 返回自定义大小的圆形系统 cell image
 */
+ (UIImage *)ba_imageToChangeCellRoundImageViewSizeWithCell:(UITableViewCell *)cell
                                                      image:(UIImage *)image
                                                  imageSize:(CGSize)imageSize;

@end
