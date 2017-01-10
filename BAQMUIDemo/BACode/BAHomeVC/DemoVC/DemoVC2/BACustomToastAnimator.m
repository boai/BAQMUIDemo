//
//  BACustomToastAnimator.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/10.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "BACustomToastAnimator.h"

@implementation BACustomToastAnimator
{
    BOOL _isShowing;
    BOOL _isAnimating;
}

- (void)showWithCompletion:(void (^)(BOOL finished))completion
{
    _isShowing = YES;
    _isAnimating = YES;
    
    self.toastView.backgroundView.layer.transform = CATransform3DMakeTranslation(0, -30, 0);
    self.toastView.contentView.layer.transform = CATransform3DMakeTranslation(0, -30, 0);
    
    BAWeak
    [UIView animateKeyframesWithDuration:0.25f delay:0.f options:QMUIViewAnimationOptionsCurveOut animations:^{
        weakSelf.toastView.backgroundView.alpha = 1.0;
        weakSelf.toastView.contentView.alpha = 1.0;
        weakSelf.toastView.backgroundView.layer.transform = CATransform3DIdentity;
        weakSelf.toastView.contentView.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        if (completion)
        {
            completion(finished);
        }
    }];
    
}

- (void)hideWithCompletion:(void (^)(BOOL finished))completion
{
    _isShowing = NO;
    _isAnimating = YES;
    BAWeak
    [UIView animateWithDuration:0.25 delay:0.0 options:QMUIViewAnimationOptionsCurveOut animations:^{
        weakSelf.toastView.backgroundView.alpha = 0.0;
        weakSelf.toastView.contentView.alpha = 0.0;
        weakSelf.toastView.backgroundView.layer.transform = CATransform3DMakeTranslation(0, -30, 0);
        weakSelf.toastView.contentView.layer.transform = CATransform3DMakeTranslation(0, -30, 0);
    } completion:^(BOOL finished) {
        _isAnimating = NO;
        weakSelf.toastView.backgroundView.layer.transform = CATransform3DIdentity;
        weakSelf.toastView.contentView.layer.transform = CATransform3DIdentity;
        if (completion)
        {
            completion(finished);
        }
    }];

}

- (BOOL)isShowing
{
    return _isShowing;
}

- (BOOL)isAnimating
{
    return _isAnimating;
}


@end
