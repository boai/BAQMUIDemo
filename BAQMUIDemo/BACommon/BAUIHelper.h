//
//  BAUIHelper.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUIHelper : NSObject

/*! 启动自定义QMUI的配置模板 */
+ (void)ba_setupConfigurationTemplate;
/*! 博爱自定义的全局样式渲染 */
+ (void)ba_renderGlobalAppearances;

@end

@interface BAUIHelper (QMUIModalPresentationViewController)

+ (void)ba_uiHelper_customMoreOperationAppearance;

@end

@interface BAUIHelper (QMUIAlertControllerAppearance)

+ (void)ba_uiHelper_customAlertControllerAppearance;

@end

@interface BAUIHelper (UITabBarItem)

+ (UITabBarItem *)ba_uiHelper_tabbarItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                    selectedImage:(UIImage *)selectedImage
                               selectedTitleColor:(UIColor *)selectedTitleColor
                                              tag:(NSInteger)tag;

@end

@interface BAUIHelper (Button)

+ (QMUIButton *)ba_uiHelper_generateDarkFilledButton;
+ (QMUIButton *)ba_uiHelper_generateLightBorderedButton;

@end

@interface NSString (Code)

- (void)ba_uiHelper_enumerateCodeStringBlock:(void (^)(NSString *codeString, NSRange codeRange))block;

@end

@interface BAUIHelper (SavePhoto)

+ (void)ba_uiHelper_showAlertWhenSavedPhotoFailuredByPermissionDenied;

@end

@interface BAUIHelper (Calculate)

+ (NSString *)ba_uiHelper_humanReadableFileSize:(long long)size;

@end

