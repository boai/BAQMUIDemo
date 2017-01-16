//
//  UIImage+Render.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

/*!
 让图片不被渲染
 
 @param imageName 图片名称
 @return 不被渲染的图片
 */
+ (UIImage *)ba_imageNamedWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName] ;
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    return image ;
}

/*!
 获得新的圆形图片
 
 @param image 传入需要裁剪成圆形的图片
 @return 返回裁剪好的圆形图片
 */
+ (UIImage *)ba_imageToRoundImageWithImage:(UIImage *)image
{
    if (!image)return nil;
    
    /*! 1、开启位图上下文 */
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0) ;
    
    /*! 2、描述圆形裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)] ;
    
    /*! 3、设置裁剪区域 */
    [clipPath addClip] ;
    
    /*! 4、绘图 */
    [image drawAtPoint:CGPointZero] ;
    
    /*! 5、取出图片 */
    image = UIGraphicsGetImageFromCurrentImageContext() ;
    
    /*! 6、关闭图片上下文 */
    UIGraphicsEndImageContext() ;
    
    return image ;
}

/*!
 传入图片，获得有边框、边框颜色的圆形图片
 
 @param borderW 边框宽度
 @param color   变宽颜色
 @param image   传入图片
 
 @return 获得有边框、边框颜色的圆形新图片
 */
+ (UIImage *)ba_imageWithBorderW:(CGFloat)borderW
                     borderColor:(UIColor *)color
                           image:(UIImage *)image
{
    if (!image) return nil;
    
    /*! 1.生成一张图片,开启一个位图上下文(大小,图片的宽高 + 2 * 边框宽度) */
    CGSize size = CGSizeMake(image.size.width + 2 *borderW, image.size.height + 2 *borderW);
    UIGraphicsBeginImageContext(size);
    
    /*! 2.绘制一个大圆 */
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [color set];
    [path fill];
    
    /*! 3.设置裁剪区域 */
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderW, borderW, image.size.width, image.size.height)];
    
    /*! 3.1 把路径设置为裁剪区域 */
    [clipPath addClip];
    
    /*! 4 把图片绘制到上下文 */
    [image drawAtPoint:CGPointMake(borderW, borderW)];
    
    /*! 5.从上下文当中获取图片 */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /*! 6.关闭上下文 */
    UIGraphicsEndImageContext();
    
    return newImage;
}

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
                                                   imageSize:(CGSize)imageSize
{
    CGSize itemSize = imageSize;
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0);
    CGRect imageRect = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [image drawInRect:imageRect];
    cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cell.imageView.image;
}

@end
