
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

/**
 *  Direction of flip animation
 */
typedef NS_ENUM(NSInteger, UIViewAnimationFlipDirection)
{
    /**
     *  Flip animation from top
     */
    UIViewAnimationFlipDirectionFromTop = 0,
    /**
     *  Flip animation from left
     */
    UIViewAnimationFlipDirectionFromLeft,
    /**
     *  Flip animation from right
     */
    UIViewAnimationFlipDirectionFromRight,
    /**
     *  Flip animation from bottom
     */
    UIViewAnimationFlipDirectionFromBottom
};

/**
 *  Direction of the translation
 */
typedef NS_ENUM(NSInteger, UIViewAnimationTranslationDirection)
{
    /**
     *  Translation from left to right
     */
    UIViewAnimationTranslationDirectionFromLeftToRight = 0,
    /**
     *  Translation from right to left
     */
    UIViewAnimationTranslationDirectionFromRightToLeft
};

/**
 *  Direction of the linear gradient
 */
typedef NS_ENUM(NSInteger, UIViewLinearGradientDirection)
{
    /**
     *  Linear gradient vertical
     */
    UIViewLinearGradientDirectionVertical = 0,
    /**
     *  Linear gradient horizontal
     */
    UIViewLinearGradientDirectionHorizontal,
    /**
     *  Linear gradient from left to right and top to down
     */
    UIViewLinearGradientDirectionDiagonalFromLeftToRightAndTopToDown,
    /**
     *  Linear gradient from left to right and down to top
     */
    UIViewLinearGradientDirectionDiagonalFromLeftToRightAndDownToTop,
    /**
     *  Linear gradient from right to left and top to down
     */
    UIViewLinearGradientDirectionDiagonalFromRightToLeftAndTopToDown,
    /**
     *  Linear gradient from right to left and down to top
     */
    UIViewLinearGradientDirectionDiagonalFromRightToLeftAndDownToTop
};


IB_DESIGNABLE

@interface UIView (BAKit)

@property (nonatomic          ) CGPoint        viewOrigin;
@property (nonatomic          ) CGSize         viewSize;

@property (nonatomic          ) CGFloat        x;
@property (nonatomic          ) CGFloat        y;
@property (nonatomic          ) CGFloat        width;
@property (nonatomic          ) CGFloat        height;

@property (nonatomic          ) CGFloat        top;
@property (nonatomic          ) CGFloat        bottom;
@property (nonatomic          ) CGFloat        left;
@property (nonatomic          ) CGFloat        right;

@property (nonatomic          ) CGFloat        centerX;
@property (nonatomic          ) CGFloat        centerY;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat        middleX;
@property (nonatomic, readonly) CGFloat        middleY;
@property (nonatomic, readonly) CGPoint        middlePoint;

@property (nonatomic, assign) IBInspectable BOOL     masksToBounds;
@property (nonatomic, assign) IBInspectable CGFloat  cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat  borderWidth;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat  defineValue;

/**
 *  1.设置颜色
 */
- (UIView *(^)(UIColor *color)) setColor;

/**
 *  2.设置框架
 */
- (UIView *(^)(CGRect frame)) setFrame;

/**
 *  3.设置尺寸
 */
- (UIView *(^)(CGSize size)) setSize;

/**
 *  4.设置中心点
 */
- (UIView *(^)(CGPoint point)) setCenter;

/**
 *  5.设置标签值
 */
- (UIView *(^)(NSInteger tag)) setTag;

/**
 *  1.给UIView添加点击事件
 */
- (void)addTarget:(id)target
           action:(SEL)action;

/**
 *  2.UIView的类初始化
 */
+ (UIView *)viewWithFrame:(CGRect)frame
          backgroundColor:(UIColor *)backgroundColor;

/**
 *  3.创建边框
 */
- (void)ba_setBordersWithColor:(UIColor *)color
            andCornerRadius:(CGFloat)radius
                   andWidth:(CGFloat)width;

/**
 *  4.删除边框
 */
- (void)ba_removeBorders;

/**
 *  5.创建阴影
 */
- (void)ba_setRectShadowWithOffset:(CGSize)offset
                        opacity:(CGFloat)opacity
                         radius:(CGFloat)radius;

/**
 *  6.删除阴影
 */
- (void)ba_removeShadow;

/**
 *  7.创建圆角半径阴影
 */
- (void)ba_setCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                       offset:(CGSize)offset
                                      opacity:(CGFloat)opacity
                                       radius:(CGFloat)radius;


/**
 *  9.摇摆动画
 */
- (void)ba_shakeView;

/**
 *  10.脉冲动画
 */
- (void)ba_pulseViewWithTime:(CGFloat)seconds;

/*!
 *  渐变色
 *
 *  @param colors    颜色
 *  @param direction 方向，横向还是纵向
 */
- (void)ba_createGradientWithColors:(NSArray *)colors direction:(UIViewLinearGradientDirection)direction;

/**
 *  添加子View
 *
 *  @param array 添加子的ViewArray
 */
- (void)ba_AddSubViewsWithArray:(NSArray *)array;

/**
 *  获取当前View的VC
 *
 *  @return 获取当前View的VC
 */
- (UIViewController *)getCurrentViewController;

/*!
 *  显示警告框
 *
 *  @param title   title description
 *  @param message message description
 */
- (void)ba_showAlertView:(NSString *)title message:(NSString *)message;

/*!
 *  自适应label的高度
 *
 *  @param text  内容
 *  @param font  字体大小
 *  @param width 宽度
 *
 *  @return label的高度
 */
+ (CGFloat)ba_AutoSizeOfHeghtWithText:(NSString *)text font:(UIFont *)font width:(CGFloat)width;

/*!
 *  自适应label的宽度
 *
 *  @param text  内容
 *  @param font  字体大小
 *  @param height 高度
 *
 *  @return label的宽度
 */
+ (CGFloat)ba_AutoSizeOfWidthWithText:(NSString *)text font:(UIFont *)font height:(CGFloat)height;


//- (void)ba_showHudWitTitle:(NSString *)title atView:(UIView *)view;

@end
