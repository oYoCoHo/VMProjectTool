//
//  UIColor+Extension.h
//  LiMo
//
//  Created by ve2 on 2020/3/3.
//  Copyright © 2020 mac. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  渐变色方向
 */
typedef NS_ENUM(NSInteger, UIColorDirGradientType) {
    UIColorDirGradientTypeHorizontal,   //水平
    UIColorDirGradientTypeVertical,     //垂直
    UIColorDirGradientTypeTopLeftToBottomRight, // 从左上角到右下角
    UIColorDirGradientTypeTopRightToBottomLeft, // 从右上角到左下角
};

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue alpha:(CGFloat)alpha;

#pragma mark - 渐变色相关接口
/**
 获取渐变色涂层，通过坐标指定方向
 
 @param colors      渐变色数组
 @param startPoint      起始点
 @param endPoint        结束点
 @param frame       位置尺寸
 @param cornerRadius    圆角
 */
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

/**
 获取渐变色涂层，可以指定方向和设置圆角
 
 @param colors      渐变色数组
 @param type      渐变方向
 @param frame       位置尺寸
 @param cornerRadius    圆角
 */
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors type:(UIColorDirGradientType)type frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;

/**
 获取渐变色涂层，可以指定方向，圆角默认0
 
 @param colors      渐变色数组
 @param type      渐变方向
 @param frame       位置尺寸
 */
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors type:(UIColorDirGradientType)type frame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
