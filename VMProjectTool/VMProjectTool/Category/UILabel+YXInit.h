//
//  UILabel+YXInit.h
//  LiMo
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YXInit)


/**
 * 根据文本、文本颜色、字体大小初始化
 * @param text label文本
 * @param textColor label文本颜色
 * @param fontSize label文本大小
 *
*/
+(id)initLabelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                     fontSize:(float)fontSize;

+(id)initLabelWithText:(nullable NSString *)text
             textColor:(UIColor *)textColor
                  font:(UIFont*)font;
/**
 * 根据文本、文本颜色、字体大小初始化
 * @param text label文本
 * @param textColor label文本颜色
 * @param fontSize label文本大小
 * @param fontName label文本字体名称
 *
*/
+(id)initLabelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                     fontSize:(float)fontSize
              fontName:(NSString *)fontName;



/**
 * 根据文本、文本颜色、字体大小初始化，文字居中
 * @param text label文本
 * @param textColor label文本颜色
 * @param fontSize label文本大小
*/
+(id)initAlignmentCenterLabelWithText:(nullable NSString *)text
             textColor:(UIColor *)textColor
              fontSize:(float)fontSize;



/**
 * 根据文本、文本颜色、字体大小初始化，文字居中
 * @param text label文本
 * @param textColor label文本颜色
 * @param font label文本大小
 * @param lineSpace 行距
 * @param alignment 对齐方式
*/
+(id)initAttLabelWithText:(nullable NSString *)text
                textColor:(UIColor *)textColor
                     font:(UIFont*)font
                lineSpace:(float)lineSpace
                alignment:(NSTextAlignment)alignment;


@end

NS_ASSUME_NONNULL_END
