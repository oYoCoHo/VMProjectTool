//
//  NSAttributedString+Extension.m
//  ShiMiDa
//
//  Created by yy on 2023/4/6.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)

- (NSAttributedString *)appendAtString:(NSString *)atStr withIndex:(NSInteger)index uid:(nonnull NSString *)uid
{
    atStr = [atStr substringToIndex:atStr.length - 1];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:atStr attributes:@{NSForegroundColorAttributeName : UIColor.color_01071A}];
    [attrStr yy_setAttribute:@"isAt" value:@(YES)];
    [attrStr yy_setAttribute:@"uid" value:uid];
    
    NSMutableAttributedString *emptyStr = [[NSMutableAttributedString alloc] initWithString:@" "];
    [attrStr appendAttributedString:emptyStr];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:self];
    [str insertAttributedString:attrStr atIndex:index];
    str.yy_font = YX_FontPingFangSCRegular(16);
    
    return str;
}


#pragma mark 创建带图片的富文本
+ (NSAttributedString *)creatImageAttributedString:(NSString*)string imageName:(NSString*)imageName font:(UIFont*)font color:(UIColor*)color alignment:(NSTextAlignment)alignment {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",string]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];//字体颜色
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];//字体大小
    
    
    //设置图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = image;
    textAttachment.bounds = CGRectMake(0, roundf(font.capHeight - image.size.height) * 0.5, image.size.width, image.size.height);
//    textAttachment.bounds = CGRectMake(0, roundf(font.capHeight - image.size.height) * 0.5, font.lineHeight, font.lineHeight);
    
    NSAttributedString *attachText = [NSAttributedString attributedStringWithAttachment:textAttachment];
    [attributedString insertAttributedString:attachText atIndex:0];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = alignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}

+ (NSAttributedString *)yy_creatImageAttributedString:(NSString*)string imageName:(NSString*)imageName font:(UIFont*)font color:(UIColor*)color alignment:(NSTextAlignment)alignment {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",string]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];//字体颜色
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];//字体大小
    
    
    //设置图片
    UIImage *image = [UIImage imageNamed:imageName];
    //size 和字体大小一致时，计算的高度才准确，image.size不准确
    CGSize size = CGSizeMake(font.lineHeight, font.lineHeight);
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [attributedString insertAttributedString:attachText atIndex:0];
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = alignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    return attributedString;
}


#pragma mark 获得带高亮文字的富文本
///获得带高亮文字的富文本
+ (NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color highlight_string:(NSString*)highlight_string highlight_color:(UIColor*)highlight_color highlight_font:(UIFont*)highlight_font {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
//    NSMutableDictionary *all_attributes = [NSMutableDictionary dictionary];
//    [all_attributes setValue:color forKey:NSForegroundColorAttributeName];
//    [all_attributes setValue:font forKey:NSFontAttributeName];
//    [attributedString setAttributes:all_attributes range:string.rangeOfAll];
    
    NSRange range_range = [string rangeOfString:highlight_string];
//    NSRange firstRange = NSMakeRange(0, range_range.location);
//    NSInteger second_loc = range_range.location+range_range.length;
//    NSRange secondRange = NSMakeRange(second_loc, string.length - second_loc);
//
//    NSMutableDictionary *all_attributes = [NSMutableDictionary dictionary];
//    [all_attributes setValue:color forKey:NSForegroundColorAttributeName];
//    [all_attributes setValue:font forKey:NSFontAttributeName];
//    [attributedString setAttributes:all_attributes range:firstRange];
//    [attributedString setAttributes:all_attributes range:secondRange];
    
    NSMutableDictionary *range_attributes = [NSMutableDictionary dictionary];
    [range_attributes setValue:highlight_color forKey:NSForegroundColorAttributeName];
    [range_attributes setValue:highlight_font forKey:NSFontAttributeName];
    [attributedString setAttributes:range_attributes range:range_range];
    
    
    return attributedString;
}

@end
