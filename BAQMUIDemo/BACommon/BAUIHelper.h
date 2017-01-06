//
//  BAUIHelper.h
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUIHelper : NSObject

@end

@interface BAUIHelper (QMUIModalPresentationViewController)

+ (void)ba_uiHelper_customAlertControllerAppearance;

@end

@interface BAUIHelper (UITabBarItem)

+ (UITabBarItem *)ba_uiHelper_tabbarItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                    selectedImage:(UIImage *)selectedImage
                                       titleColor:(UIColor *)titleColor
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

