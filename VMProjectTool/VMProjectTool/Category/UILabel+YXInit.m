//
//  UILabel+YXInit.m
//  LiMo
//
//  Created by apple on 2019/10/31.
//  Copyright © 2019 mac. All rights reserved.
//

#import "UILabel+YXInit.h"

@implementation UILabel (YXInit)


//根据文本、文本颜色、字体大小初始化
+(id)initLabelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                     fontSize:(float)fontSize{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    return label;
}

// 根据文本、文本颜色、字体大小、字体名称初始化
+(id)initLabelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                     fontSize:(float)fontSize
              fontName:(NSString *)fontName{
    
    UILabel *label = [self initLabelWithText:text textColor:textColor fontSize:fontSize];
    label.font = [UIFont fontWithName:fontName size:fontSize];
    return label;
}

//根据文本、文本颜色、字体大小初始化，文字居中
+(id)initAlignmentCenterLabelWithText:(nullable NSString *)text
                            textColor:(UIColor *)textColor
                             fontSize:(float)fontSize{
    
    UILabel *label = [self initLabelWithText:text textColor:textColor fontSize:fontSize];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


//根据文本、文本颜色、字体大小初始化
+(id)initLabelWithText:(nullable NSString *)text
                    textColor:(UIColor *)textColor
                     font:(UIFont*)font{
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    return label;
}

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
                alignment:(NSTextAlignment)alignment
{
    
    UILabel *label = [[self alloc] init];
    NSMutableParagraphStyle *muParagraph = [[NSMutableParagraphStyle alloc]init];
    muParagraph.lineSpacing = lineSpace;
    muParagraph.alignment = alignment;
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:text attributes:@{
        NSParagraphStyleAttributeName: muParagraph,
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: textColor
    }];
    label.attributedText = attStr;
    return label;
}

@end
