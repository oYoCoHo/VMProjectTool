//
//  NSAttributedString+Extension.h
//  ShiMiDa
//
//  Created by yy on 2023/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (Extension)

- (NSAttributedString *)appendAtString:(NSString *)atStr withIndex:(NSInteger)index uid:(nonnull NSString *)uid;

#pragma mark 创建带图片的富文本
+ (NSAttributedString *)creatImageAttributedString:(NSString*)string imageName:(NSString*)imageName font:(UIFont*)font color:(UIColor*)color alignment:(NSTextAlignment)alignment;

+ (NSAttributedString *)yy_creatImageAttributedString:(NSString*)string imageName:(NSString*)imageName font:(UIFont*)font color:(UIColor*)color alignment:(NSTextAlignment)alignment;

/// 获得带高亮文字的富文本
+ (NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string font:(UIFont*)font color:(UIColor*)color highlight_string:(NSString*)highlight_string highlight_color:(UIColor*)highlight_color highlight_font:(UIFont*)highlight_font;
@end

NS_ASSUME_NONNULL_END
