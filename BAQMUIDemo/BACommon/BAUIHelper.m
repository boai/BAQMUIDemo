//
//  BAUIHelper.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/6.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BAUIHelper.h"

@implementation BAUIHelper

@end

@implementation BAUIHelper (QMUIModalPresentationViewController)

+ (void)ba_uiHelper_customAlertControllerAppearance
{
    /*! 如果需要统一修改全局的 QMUIMoreOperationController 样式，在这里修改 appearance 的值即可 */
}

@end

@implementation BAUIHelper (UITabBarItem)

+ (UITabBarItem *)ba_uiHelper_tabbarItemWithTitle:(NSString *)title
                                            image:(UIImage *)image
                                    selectedImage:(UIImage *)selectedImage
                                       titleColor:(UIColor *)titleColor
                               selectedTitleColor:(UIColor *)selectedTitleColor
                                              tag:(NSInteger)tag
{
    UITabBarItem *tabbarItem = [[UITabBarItem alloc] initWithTitle:title image:image selectedImage:selectedImage];
    tabbarItem.selectedImage = selectedImage;
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName : titleColor} forState:UIControlStateNormal];
    [tabbarItem setTitleTextAttributes:@{NSFontAttributeName : selectedTitleColor} forState:UIControlStateSelected];

    return tabbarItem;
}

@end

@implementation BAUIHelper (Button)

+ (QMUIButton *)ba_uiHelper_generateDarkFilledButton
{
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.adjustsImageWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorWhite forState:UIControlStateNormal];
    button.backgroundColor = UIColorGreen;
    button.highlightedBackgroundColor = UIColorMake(0, 168, 255);
    button.layer.cornerRadius = 5.0f;
    
    return button;
}

+ (QMUIButton *)ba_uiHelper_generateLightBorderedButton
{
    QMUIButton *button = [[QMUIButton alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(200, 40))];
    button.adjustsImageWhenHighlighted = YES;
    button.titleLabel.font = UIFontBoldMake(14);
    [button setTitleColor:UIColorGreen forState:UIControlStateNormal];
    button.backgroundColor = UIColorMake(235, 249, 255);
    button.highlightedBackgroundColor = UIColorMake(211, 239, 252);
    button.layer.cornerRadius = 5.0f;
    button.layer.borderColor = UIColorMake(142, 219, 249).CGColor;
    button.layer.borderWidth = 1.0f;
    button.highlightedBorderColor = UIColorMake(0, 168, 225);
    
    return button;
}

@end

@implementation NSString (Code)

- (void)ba_uiHelper_enumerateCodeStringBlock:(void (^)(NSString *codeString, NSRange codeRange))block
{
    NSString *pattern = @"\\[?[A-Za-z0-9_.]+\\s?[A-Za-z0-9_:.]+\\]?";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    [regex enumerateMatchesInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        if (block)
        {
            block([self substringWithRange:result.range], result.range);
        }
    }];
}

@end

@implementation BAUIHelper (SavePhoto)

+ (void)ba_uiHelper_showAlertWhenSavedPhotoFailuredByPermissionDenied
{
    QMUIAlertController *alertController = [QMUIAlertController alertControllerWithTitle:@"无法保存" message:@"你未开启“允许 QMUI 访问照片”选项" preferredStyle:QMUIAlertControllerStyleAlert];
    
    QMUIAlertAction *settingAction = [QMUIAlertAction actionWithTitle:@"去设置" style:QMUIAlertActionStyleDefault handler:^(QMUIAlertAction *action) {
        NSURL *url = [[NSURL alloc] initWithString:@"prefs:root=Privacy&path=PHOTOS"];
        [[UIApplication sharedApplication] openURL:url];
    }];
    [alertController addAction:settingAction];
    
    QMUIAlertAction *okAction = [QMUIAlertAction actionWithTitle:@"我知道了" style:QMUIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];

    [alertController showWithAnimated:YES];
}

@end

@implementation BAUIHelper (Calculate)

+ (NSString *)ba_uiHelper_humanReadableFileSize:(long long)size
{
    NSString * strSize = nil;
    if (size >= 1048576.0) {
        strSize = [NSString stringWithFormat:@"%.2fM", size / 1048576.0f];
    } else if (size >= 1024.0) {
        strSize = [NSString stringWithFormat:@"%.2fK", size / 1024.0f];
    } else {
        strSize = [NSString stringWithFormat:@"%.2fB", size / 1.0f];
    }
    return strSize;
}

@end
