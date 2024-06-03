//
//

#import "UIButton+SHExtension.h"
#import <objc/runtime.h>
#import "RSSwizzle.h"
#import "YXBaseButton.h"

static char key_ext_imageStyle;
static char key_ext_imageSize[2];
static char key_ext_titleLabelSize[2];
static char key_ext_spacing;
static char key_ext_imageEdgeInsets[4];
static char key_ext_titleLabelEdgeInsets[4];

static char key_layoutSubviews;

static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@interface UIButton (SHExtension)

@end

@implementation UIButton (SHExtension)


+ (void)load {
    RSSwizzleInstanceMethod(self,
                            @selector(layoutSubviews),
                            RSSWReturnType(void),
                            RSSWArguments(),
                            RSSWReplacement(
                                            {
                                                RSSWCallOriginal();
                                                [self sh_ext_layoutSubviews];
                                            }), RSSwizzleModeOncePerClassAndSuperclasses, &key_layoutSubviews);
}

- (void)setExt_imageStyle:(UIButtonExtensionImageStyle)ext_imageStyle
{
    objc_setAssociatedObject(self, &key_ext_imageStyle, @(ext_imageStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_imageSize:(CGSize)ext_imageSize
{
    objc_setAssociatedObject(self, &key_ext_imageSize[0], @(ext_imageSize.width), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageSize[1], @(ext_imageSize.height), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_titleLabelSize:(CGSize)ext_titleLabelSize
{
    objc_setAssociatedObject(self, &key_ext_titleLabelSize[0], @(ext_titleLabelSize.width), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelSize[1], @(ext_titleLabelSize.height), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_spacing:(CGFloat)ext_spacing
{
    objc_setAssociatedObject(self, &key_ext_spacing, @(ext_spacing), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_imageEdgeInsets:(UIEdgeInsets)ext_imageEdgeInsets
{
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[0], @(ext_imageEdgeInsets.top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[1], @(ext_imageEdgeInsets.left), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[2], @(ext_imageEdgeInsets.bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_imageEdgeInsets[3], @(ext_imageEdgeInsets.right), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}

- (void)setExt_titleLabelEdgeInsets:(UIEdgeInsets)ext_titleLabelEdgeInsets
{
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[0], @(ext_titleLabelEdgeInsets.top), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[1], @(ext_titleLabelEdgeInsets.left), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[2], @(ext_titleLabelEdgeInsets.bottom), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &key_ext_titleLabelEdgeInsets[3], @(ext_titleLabelEdgeInsets.right), OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self layoutSubviews];
}


- (UIButtonExtensionImageStyle)ext_imageStyle {
    return [objc_getAssociatedObject(self, &key_ext_imageStyle) integerValue];
}

- (CGSize)ext_imageSize {
    CGSize size;
    size.width = [objc_getAssociatedObject(self, &key_ext_imageSize[0]) floatValue];
    size.height = [objc_getAssociatedObject(self, &key_ext_imageSize[1]) floatValue];
    return size;
    
}

- (CGSize)ext_titleLabelSize {
    CGSize size;
    size.width = [objc_getAssociatedObject(self, &key_ext_titleLabelSize[0]) floatValue];
    size.height = [objc_getAssociatedObject(self, &key_ext_titleLabelSize[1]) floatValue];
    return size;
}

- (CGFloat)ext_spacing {
    NSNumber *spacing = objc_getAssociatedObject(self, &key_ext_spacing);
    if (spacing) {
        return [spacing floatValue];
    }
    return 8.0;
}

- (UIEdgeInsets)ext_imageEdgeInsets {
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[0]) floatValue];
    edgeInsets.left = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[1]) floatValue];
    edgeInsets.bottom = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[2]) floatValue];
    edgeInsets.right = [objc_getAssociatedObject(self, &key_ext_imageEdgeInsets[3]) floatValue];
    return edgeInsets;
}

- (UIEdgeInsets)ext_titleLabelEdgeInsets {
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    edgeInsets.top = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[0]) floatValue];
    edgeInsets.left = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[1]) floatValue];
    edgeInsets.bottom = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[2]) floatValue];
    edgeInsets.right = [objc_getAssociatedObject(self, &key_ext_titleLabelEdgeInsets[3]) floatValue];
    return edgeInsets;
}


#define isZeroWithCGFloat(f)     (f < 0.1 && f > -0.1)
#define isZeroWithCGSize(size)   (isZeroWithCGFloat(size.width) && isZeroWithCGFloat(size.height))
#define isZeroWithUIEdgeInsets(insets)   (isZeroWithCGFloat(insets.top) && isZeroWithCGFloat(insets.left) && isZeroWithCGFloat(insets.bottom) && isZeroWithCGFloat(insets.right))

#ifndef kStringDisplayHeightByWidth
#define kStringDisplayHeightByWidth(text,width,font)        text == nil ? 0:[text boundingRectWithSize:CGSizeMake((width), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :(font)} context:nil].size.height
#endif

#ifndef kStringDisplayWidthByHeight
#define kStringDisplayWidthByHeight(text,height,font)       text == nil ? 0:[text boundingRectWithSize:CGSizeMake(MAXFLOAT, (height)) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :(font)} context:nil].size.width
#endif

- (void)sh_ext_layoutSubviews
{
    if (!self.imageView) return;
    CGFloat totalHeight = self.frame.size.height;
    CGFloat totalWidth = self.frame.size.width;
    CGSize imageSize = isZeroWithCGSize (self.ext_imageSize) ? self.imageView.frame.size : self.ext_imageSize;
    CGSize defualt_titleSize;
    defualt_titleSize.height = self.titleLabel.frame.size.height;
    defualt_titleSize.width = kStringDisplayWidthByHeight(self.currentTitle,defualt_titleSize.height, self.titleLabel.font);
    CGSize titleSize = isZeroWithCGSize (self.ext_titleLabelSize) ? defualt_titleSize: self.ext_titleLabelSize;
    CGFloat spacing = self.ext_spacing;
    UIEdgeInsets imageEdgeInsets = self.ext_imageEdgeInsets;
    UIEdgeInsets titleEdgeInsets = self.ext_titleLabelEdgeInsets;
    
    switch (self.ext_imageStyle) {
        case UIButtonExtensionImageStyleCustomLeft:
        {
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - titleSize.width - spacing - imageSize.width) / 2 ;
            imageFrame.origin.y = (totalHeight - imageSize.height) / 2 ;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
            CGRect titleFrame;
            titleFrame.origin.x = CGRectGetMaxX(imageFrame) + spacing;
            titleFrame.origin.y = (totalHeight - titleSize.height) /2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            
        }break;
        case UIButtonExtensionImageStyleCustomRight:
        {
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width - spacing - imageSize.width) / 2 ;
            titleFrame.origin.y = (totalHeight - titleSize.height) /2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            
            CGRect imageFrame;
            imageFrame.origin.x = CGRectGetMaxX(titleFrame) + spacing;
            imageFrame.origin.y = (totalHeight - imageSize.height) / 2 ;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
        }break;
        case UIButtonExtensionImageStyleCustomTop:
        {
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - imageSize.width) / 2 ;
            imageFrame.origin.y = (totalHeight - imageSize.height - titleSize.height - self.ext_spacing) / 2;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width) / 2 ;
            titleFrame.origin.y = CGRectGetMaxY(imageFrame) + spacing;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }break;
        case UIButtonExtensionImageStyleCustomBottom:
        {
            CGRect titleFrame;
            titleFrame.origin.x = (totalWidth - titleSize.width) / 2 ;
            titleFrame.origin.y = (totalHeight - imageSize.height - titleSize.height - self.ext_spacing) / 2;
            titleFrame.size = titleSize;
            titleFrame.origin.x += titleEdgeInsets.left;
            titleFrame.origin.y += titleEdgeInsets.top;
            self.titleLabel.frame = titleFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGRect imageFrame;
            imageFrame.origin.x = (totalWidth - imageSize.width) / 2 ;
            imageFrame.origin.y = CGRectGetMaxY(titleFrame) + spacing;
            imageFrame.size = imageSize;
            imageFrame.origin.x += imageEdgeInsets.left;
            imageFrame.origin.y += imageEdgeInsets.top;
            self.imageView.frame = imageFrame;
            
        }break;
        default:
            break;
    }
}

- (void)setBackgroundWithImage:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInset forState:(UIControlState)state
{
    UIImage * image_n = [image resizableImageWithCapInsets:edgeInset resizingMode:UIImageResizingModeStretch];
    [self setBackgroundImage:image_n forState:state];
}

#pragma mark ------------ 自定义快捷初始化方法 --------------
+ (UIButton *)initButton{
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    button.tag = 0;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return button;
}


#pragma mark 只有title
/**
 * title + titleColor + titleFont
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont {
    
    UIButton *button = [self initButton];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleFont;
    return button;
}

/**
 * title + titleColor + titleFont + selectedTitleColor
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor{
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    return button;
}

/**
 * title + titleColor + titleFont + selectedTitleColor + selectedTitle
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle {
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont selectedTitleColor:selectedTitleColor];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    return button;
}

#pragma mark 只有image
/**
 * image
*/
+(id)initButtonWithImage:(UIImage *)image{
    UIButton *button = [self initButton];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

/**
 * image + selctedImage
*/
+(id)initButtonWithImage:(UIImage *)image
           selectedImage:(UIImage *)selectedImage{
    
    UIButton *button = [self initButtonWithImage:image];
    [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}

#pragma mark 只有backgroundImage
/**
 * backgroundImage
*/
+(id)initButtonWithBackgroundImage:(UIImage *)backgroundImage{
    
    UIButton *button = [self initButton];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    return button;
}

/**
 * backgroundImage + selctedBackgroundImage
*/
+(id)initButtonWithBackgroundImage:(UIImage *)backgroundImage
           selectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    
    UIButton *button = [self initButtonWithBackgroundImage:backgroundImage];
    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    return button;
}


#pragma mark title + image
//(title + titleColor + titleFont) + image
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
                   image:(UIImage *)image {
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}


/**
 * (title + titleColor + titleFont + selectedTitleColor + selectedTitle) + (image + selectedImage)
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle
                   image:(UIImage *)image
           selectedImage:(UIImage *)selectedImage{
    
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont selectedTitleColor:selectedTitleColor selectedTitle:selectedTitle];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    return button;
}


#pragma mark title + backgroundImage
//(title + titleColor + titleFont) + backgroundImage
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
         backgroundImage:(UIImage *)backgroundImage{
    
      UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont];
      [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
      return button;
}

/**
 * (title + titleColor + titleFont + selectedTitleColor + selectedTitle) + (backgroundImage + selectedBackgroundImage)
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
      selectedTitleColor:(UIColor *)selectedTitleColor
           selectedTitle:(NSString *)selectedTitle
                   backgroundImage:(UIImage *)backgroundImage
 selectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont selectedTitleColor:selectedTitleColor selectedTitle:selectedTitle];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    return button;
}


#pragma mark title + image + backgroundImage

/**
 * (title + titleColor + titleFont) +  image + backgroundImage
*/
+(id)initButtonWithTitle:(NSString *)title
              titleColor:(UIColor *)titleColor
               titleFont:(UIFont *)titleFont
                   image:(UIImage *)image
         backgroundImage:(UIImage *)backgroundImage{
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont image:image];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    return button;
}


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
 selectedBackgroundImage:(UIImage *)selectedBackgroundImage{
    
    UIButton *button = [self initButtonWithTitle:title titleColor:titleColor titleFont:titleFont selectedTitleColor:selectedTitleColor selectedTitle:selectedTitle image:image selectedImage:selectedImage];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
    return button;
}

- (void)setHighlighted:(BOOL)highlighted{
    
    
}

#pragma mark- 利用 **runtime** 具体的设置内边距
// 设置可点击范围到按钮上、右、下、左的距离
- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);

}

- (CGRect)enlargedRect {
    NSNumber *topEdge=objc_getAssociatedObject(self, &topNameKey);
    NSNumber *rightEdge=objc_getAssociatedObject(self, &rightNameKey);
    NSNumber *bottomEdge=objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber *leftEdge=objc_getAssociatedObject(self, &leftNameKey);
    if (topEdge && rightEdge && bottomEdge && leftEdge) {
        return CGRectMake(self.bounds.origin.x-leftEdge.floatValue,
                          self.bounds.origin.y-topEdge.floatValue,
                          self.bounds.size.width+leftEdge.floatValue+rightEdge.floatValue,
                          self.bounds.size.height+topEdge.floatValue+bottomEdge.floatValue);
    } else {
        return self.bounds;
    }
}

// 设置可点击范围到按钮上、右、下、左的距离
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect rect=[self enlargedRect];
    if(CGRectEqualToRect(rect, self.bounds)) {
        return [super pointInside:point withEvent:event];
    }
    return CGRectContainsPoint(rect, point)?YES:NO;
}

/// 创建一个半圆角按钮
+ (instancetype)makeRadiusButtonWithTitle:(NSString *)title
                               titleColor:(UIColor *)titleColor
                                     font:(UIFont *)font
                          backgroundColor:(UIColor *)backgroundColor {
    UIButton *btn = [self initButtonWithTitle:title titleColor:titleColor titleFont:font];
    if ([btn isKindOfClass:QMUIButton.class]) {
        QMUIButton *qmBtn = (QMUIButton *)btn;
        qmBtn.cornerRadius = QMUIButtonCornerRadiusAdjustsBounds;
        qmBtn.backgroundColor = backgroundColor;
    } else if ([btn isKindOfClass:YXBaseButton.class]) {
        YXBaseButton *baseBtn = (YXBaseButton *)btn;
        baseBtn.buttonCornerRadius = -1;
        [baseBtn setBackgroundColor:backgroundColor forState:UIControlStateNormal];
    }
    return btn;
}

/// 创建一个QMUIButton 类型的无高亮效果按钮
+ (instancetype)makeNonHightButtonWithTitle:(NSString *)title
                                 titleColor:(UIColor *)titleColor
                                       font:(UIFont *)font {
    UIButton *btn = [self initButtonWithTitle:title titleColor:titleColor titleFont:font];
    if ([btn isKindOfClass:QMUIButton.class]) {
        QMUIButton *qbtn = (QMUIButton *)btn;
        qbtn.adjustsButtonWhenHighlighted = NO;
    }
    return btn;
}

#pragma mark - 新增方法 - jmd - 相应的 state 字符串化

/// 相应的 state 字符串化
+ (NSString *)getDictionaryKeyWithState:(UIControlState)state {
    switch (state) {
        case UIControlStateNormal: // 0
            return @"UIControlStateNormal";
        case UIControlStateHighlighted: // 1
            return @"UIControlStateHighlighted";
        case UIControlStateDisabled: // 2
            return @"UIControlStateDisabled";
        case UIControlStateSelected: // 4
            return @"UIControlStateSelected";
        case UIControlStateFocused: // 8
            return @"UIControlStateFocused";
        case UIControlStateApplication: // 0x00FF0000, // additional flags available for application use
            return @"UIControlStateApplication";
        case UIControlStateReserved: // 0xFF000000
            return @"UIControlStateReserved";
        default:
            return @"default";
    }
}

@end
