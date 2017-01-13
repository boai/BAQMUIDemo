//
//  UIImage+Render.m
//  BAQMUIDemo
//
//  Created by 博爱 on 15/10/16.
//  Copyright © 2016年 博爱之家. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)

+ (UIImage *)ba_imageNamedWithOriginal:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName] ;
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    return image ;
}

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

@end
