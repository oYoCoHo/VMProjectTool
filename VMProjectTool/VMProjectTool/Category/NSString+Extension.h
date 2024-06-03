//
//  NSString+Extension.h
//  ShiMiDa
//
//  Created by guotaihan on 2023/2/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extension)

///字符串字符个数
- (NSInteger)getStringCharacterLengthCount;
///截取字符
- (NSString*)substringCharacterSequenceToIndex:(NSUInteger)index;

///通过时间戳获取对应年月字符串
+ (NSString*)getYearAndMonthWithTimestamp:(uint64_t)timestamp;

/// 获取文本行数
+ (int)getNumberOfLinesWithText:(NSMutableAttributedString *)text andLabelWidth:(CGFloat)width;
+ (NSInteger)getNumberOfLinesWithText:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width;

/// 按宽度截取字符串
+ (NSString*)getSubstringWithWidth:(CGFloat)width font:(UIFont*)font str:(NSString*)str;

/// 忽略空白和换行字符
- (NSString*)ignoreCpaceCharacters;

/// 自定义字符串高亮范围
+ (NSMutableAttributedString*)getAttributedKeyStringWithString:(NSString*)string heightStateRanges:(NSArray*)heightStateRanges heightColor:(UIColor*)heightColor;

/// 获取子字符串的范围
- (NSArray*)getRangeOfSubstring:(NSString*)subString;

/// 禁言时间
+ (NSString*)getGroupBannedTimeWithTimestamp:(uint64_t)timestamp;

+ (NSInteger)charStrlength:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
