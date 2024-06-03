//
//  UIColor+Extension.h
//  LiMo
//
//  Created by ve2 on 2020/3/3.
//  Copyright © 2020 mac. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
