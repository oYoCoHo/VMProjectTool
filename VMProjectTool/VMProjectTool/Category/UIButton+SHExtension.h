//
// 按钮图片位置处理工具
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonExtensionImageStyle) {
    UIButtonExtensionImageStyleDefault                  = 0,
    UIButtonExtensionImageStyleCustomLeft               = 1,
    UIButtonExtensionImageStyleCustomRight              = 2,
    UIButtonExtensionImageStyleCustomBottom             = 3,
    UIButtonExtensionImageStyleCustomTop                = 4,
};


@interface UIButton (SHExtension)

//image的位置
@property (nonatomic,assign) UIButtonExtensionImageStyle ext_imageStyle;

//image的大小
@property (nonatomic,assign) CGSize ext_imageSize;

//title label大小
@property (nonatomic,assign) CGSize ext_titleLabelSize;

//image与title之间的距离
@property (nonatomic,assign) CGFloat ext_spacing;

//对image的top，与left进行调整，bottom，right暂时无效
@property (nonatomic,assign) UIEdgeInsets ext_imageEdgeInsets;
//对title的top，与left进行调整，bottom，right暂时无效
@property (nonatomic,assign) UIEdgeInsets ext_titleLabelEdgeInsets;

//设置背景
- (void)setBackgroundWithImage:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInset forState:(UIControlState)state;

#pragma mark ------------ 自定义快捷初始化方法 --------------
#pragma mark 只有title
/**
 * title + titleColor + titleFont
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont;

/**
 * title + titleColor + titleFont + selectedTitleColor
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor;

/**
 * title + titleColor + titleFont + selectedTitleColor + selectedTitle
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle;

#pragma mark 只有image
/**
 * image
*/
+(id)initButtonWithImage:(UIImage *)image;

/**
 * image + selctedImage
*/
+(id)initButtonWithImage:(UIImage *)image
           selectedImage:(UIImage *)selectedImage;

#pragma mark 只有backgroundImage
/**
 * backgroundImage
*/
+(id)initButtonWithBackgroundImage:(UIImage *)backgroundImage;

/**
 * backgroundImage + selctedBackgroundImage
*/
+(id)initButtonWithBackgroundImage:(UIImage *)backgroundImage
           selectedBackgroundImage:(UIImage *)selectedBackgroundImage;


#pragma mark title + image
/**
 * (title + titleColor + titleFont) + image
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
                   image:(UIImage *)image;


/**
 * (title + titleColor + titleFont + selectedTitleColor + selectedTitle) + (image + selectedImage)
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle
                   image:(UIImage *)image
           selectedImage:(UIImage *)selectedImage;


#pragma mark title + backgroundImage
/**
 * (title + titleColor + titleFont) + backgroundImage
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
         backgroundImage:(UIImage *)backgroundImage;


/**
 * (title + titleColor + titleFont + selectedTitleColor + selectedTitle) + (backgroundImage + selectedBackgroundImage)
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle
                   backgroundImage:(UIImage *)backgroundImage
           selectedBackgroundImage:(UIImage *)selectedBackgroundImage;


#pragma mark title + image + backgroundImage

/**
 * (title + titleColor + titleFont) +  image + backgroundImage
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
                   image:(UIImage *)image
         backgroundImage:(UIImage *)backgroundImage;


/**
 * (title + titleColor + titleFont + selectTitle + selectedTitleColor) +  (image + selectedImage) + (backgroundImage + selectedBackgroundImage)
*/

+(id)initButtonWithTitle:(NSString *)title
        titleColor:(UIColor *)titleColor
         titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle
                   image:(UIImage *)image
           selectedImage:(UIImage *)selectedImage
         backgroundImage:(UIImage *)backgroundImage
 selectedBackgroundImage:(UIImage *)selectedBackgroundImage;

// 设置可点击范围到按钮上、右、下、左的距离
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

/// 创建一个半圆角按钮
+ (instancetype)makeRadiusButtonWithTitle:(NSString *)title
                               titleColor:(UIColor *)titleColor
                                     font:(UIFont *)font
                          backgroundColor:(UIColor *)backgroundColor;

/// 创建一个QMUIButton 类型的无高亮效果按钮
+ (instancetype)makeNonHightButtonWithTitle:(NSString *)title
                                 titleColor:(UIColor *)titleColor
                                       font:(UIFont *)font;

#pragma mark - 新增方法 - jmd

/// 相应的 state 字符串化
+ (NSString *)getDictionaryKeyWithState:(UIControlState)state;

@end
