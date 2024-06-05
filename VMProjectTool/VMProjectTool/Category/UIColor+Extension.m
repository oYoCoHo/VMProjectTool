//
//  UIColor+Extension.m
//  LiMo
//
//  Created by ve2 on 2020/3/3.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIColor+Extension.h"



@implementation UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];

    if (match == 0) {return [UIColor clearColor];}

    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
    }
}

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:alpha];
}



#pragma mark - 渐变色相关接口
/// 获取渐变色涂层，可以指定方向，圆角默认0
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors type:(UIColorDirGradientType)type frame:(CGRect)frame {
    return [self getGradientLayer:colors type:type frame:frame cornerRadius:0];
}

/// 获取渐变色涂层，可以指定方向和设置圆角
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors type:(UIColorDirGradientType)type frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    if (type == UIColorDirGradientTypeHorizontal) {
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(1, 0);
    } else if(type == UIColorDirGradientTypeVertical) {
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(0, 1);
    }else if (type == UIColorDirGradientTypeTopLeftToBottomRight){
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(1, 1);
    }else if (type == UIColorDirGradientTypeTopRightToBottomLeft){
        startPoint = CGPointMake(1, 0);
        endPoint = CGPointMake(0, 1);
    }
    
    return [self getGradientLayer:colors startPoint:startPoint endPoint:endPoint frame:frame cornerRadius:cornerRadius];
}


/// 获取渐变色涂层，通过坐标指定方向
+ (CAGradientLayer *)getGradientLayer:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint frame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colors;
    gradientLayer.startPoint = startPoint;// 渐变色起始点
    gradientLayer.endPoint = endPoint;// 渐变色结束点
    gradientLayer.cornerRadius = cornerRadius; // 设置圆角
    gradientLayer.frame = frame;
    
    
    return gradientLayer;
}

@end
