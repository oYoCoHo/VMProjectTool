//
//  UIImage+Extension.h
//  JYJ微博
//
//  Created by JYJ on 15/3/11.
//  Copyright (c) 2015年 JYJ. All rights reserved.
//

#import <UIKit/UIKit.h>

/// vip 等级图标类型
typedef NS_ENUM(NSUInteger, VipLevelType) {
    /// 无
    VipLevelTypeNothing,
    /// VIP - 灰
    VipLevelTypeVipUnavailable,
    /// VIP
    VipLevelTypeVip,
    /// SVIP - 灰
    VipLevelTypeSvipUnavailable,
    /// SVIP
    VipLevelTypeSvip,
    /// SVIP1 - 灰
    VipLevelTypeSvip1Unavailable,
    /// SVIP1
    VipLevelTypeSvip1,
    /// SVIP2
    VipLevelTypeSvip2,
    /// SVIP3
    VipLevelTypeSvip3,
    /// SVIP4
    VipLevelTypeSvip4,
    /// SVIP5
    VipLevelTypeSvip5,
    /// SVIP6
    VipLevelTypeSvip6,
    /// SVIP7
    VipLevelTypeSvip7,
    /// SVIP8
    VipLevelTypeSvip8,
    /// SVIP9
    VipLevelTypeSvip9,
    /// 黄金会员 - 灰
    VipLevelTypeGoldUnavailable,
    /// 黄金会员
    VipLevelTypeGold,
    /// 铂金会员 - 灰
    VipLevelTypePlatinumUnavailable,
    /// 铂金会员
    VipLevelTypePlatinum,
    /// 钻石会员 - 灰
    VipLevelTypeDiamondUnavailable,
    /// 钻石会员
    VipLevelTypeDiamond,
    /// 金钻会员 - 灰
    VipLevelTypeGoldDiamondUnavailable,
    /// 金钻会员
    VipLevelTypeGoldDiamond,
    
    /// 靓号 - 灰
    VipLevelTypeBeautifyUnavailable,
    /// 个人靓号
    VipLevelTypeUserBeautify,
    /// 群靓号
    VipLevelTypeGroupBeautify,
    /// 实名认证
    VipLevelTypeReal,
};

@interface UIImage (Extension)
/**
 *  带边框的图片(方形)
 *
 *  @param insets 边框与原图的间距
 *  @param color  边框颜色
 *
 *  @return UIImage
 */
- (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color;

/**
 *  指定颜色、尺寸、圆角生成图片
 *  @param color 图片颜色
 *  @param size 图片尺寸大小
 *  @param radius 图片圆角大小
 */
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius;

/**
 *  返回拉伸图片
 */
+ (UIImage *)resizedImage:(NSString *)name;
/**
 *  用颜色返回一张图片
 */
+ (UIImage *)createImageWithColor:(UIColor*) color;
/**
 *  带边框的图片(圆形或半圆)
 *
 *  @param name        图片名字
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  带边框的图片(圆形或半圆)
 *
 *  @param image        图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//图片矫正方向
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//压缩图片
- (NSData *)resetSizeOfImageDataWithmaxSize:(NSInteger)maxSize;

//压缩图片
+(NSData *)resetSizeOfImageDataWithmaxSize:(NSInteger)maxSize data:(NSData *)data;

// 压缩GIF图片
+ (NSData*)cropGifExpressionWithImageData:(NSData*)imageData;
#pragma mark  裁剪表情
+ (UIImage*)cropExpressionWithImage:(UIImage*)image;

//获取图片缩略图
+ (NSData *)getThumbnailImageWithImage:(UIImage *)image;

// 通过图片Data数据第一个字节 来获取图片扩展名
+ (NSString *)contentTypeForImageData:(NSData *)data;

// 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage;

//图片处理成圆形
- (UIImage *)yx_circularImage;

//获取二维码的内容，系统方法
+ (NSString *)getQrcoudeContentWithCodeImage:(UIImage *)codeImage;


/// 项目 vip 图标
+ (instancetype)makeVipIcon:(VipLevelType)type;
///  根据类型获取对应图片名
+ (NSString *)getVipIconNameWithType:(VipLevelType)type;

/// 返回一个经高斯模糊处理的新图
- (UIImage *)imageWithGaussianBlurFilterHandlePixel:(NSInteger)pixel;

/// 复制一个 view 中指定位置的 image
+ (UIImage *)screenWithView:(UIView *)view rect:(CGRect)rect;
/// 复制一个 view 中指定位置的 image，可指定圆角
+ (UIImage *)screenWithView:(UIView *)view rect:(CGRect)rect radius:(CGFloat)radius;
    
/// 根据一个 image 创建一个指定位置的 image
+ (UIImage *)copyImage:(UIImage *)image withRect:(CGRect)rect;

@end
