//
//  NSString+Extension.m
//  ShiMiDa
//
//  Created by guotaihan on 2023/2/2.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#pragma mark 字符串字符个数
- (NSInteger)getStringCharacterLengthCount {
    NSRange range;
    NSInteger count = 0;
    for(int i=0; i<self.length; i+=range.length){
        range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *rangeString = [self substringWithRange:range];
        
        if (rangeString.length > 0) {
            count ++;
//            NSLog(@"rangeString:%@---range:%@",rangeString,NSStringFromRange(range));
        }
    }
    
    return count;
}

#pragma mark 截取字符
- (NSString*)substringCharacterSequenceToIndex:(NSUInteger)index {
    NSRange range;
    NSInteger count = 0;
    NSString *value = nil;
    for(int i=0; i<self.length; i+=range.length){
        range = [self rangeOfComposedCharacterSequenceAtIndex:i];
        NSString *rangeString = [self substringWithRange:range];
        
        if (index == count) {
            value = [self substringWithRange:NSMakeRange(0, range.length + range.location)];
            break;
        }
        
        if (rangeString.length > 0) {
            count ++;
        }
    }
    
    return value;
}

#pragma mark 通过时间戳获取对应年月字符串
+ (NSString*)getYearAndMonthWithTimestamp:(uint64_t)timestamp
{
    NSTimeInterval time = timestamp/1000;//毫秒级别精确到秒
    NSDate *detailDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月"];

    
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];

    
    return currentDateStr;
}


#pragma mark 获取文本行数
+ (int)getNumberOfLinesWithText:(NSMutableAttributedString *)text andLabelWidth:(CGFloat)width {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)text);
    CGMutablePathRef Path = CGPathCreateMutable();
    CGPathAddRect(Path, NULL ,CGRectMake(0 , 0 , width, INT_MAX));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    // 得到字串在frame中被自动分成了多少个行。
    CFArrayRef rows = CTFrameGetLines(frame);
    // 实际行数
    int numberOfLines = CFArrayGetCount(rows);
    CFRelease(frame);
    CGPathRelease(Path);
    CFRelease(framesetter);
    return numberOfLines;
}

//根据文字内容、字体大小和宽度限制计算文本控件的行数
+ (NSInteger)getNumberOfLinesWithText:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width {
    if (!text || text.length == 0) {
        return 0;
    }
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,width,MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    CFRelease(frameSetter);
    CFRelease(frame);
    return lines.count;
}


#pragma mark 按宽度截取字符串
+ (NSString*)getSubstringWithWidth:(CGFloat)width font:(UIFont*)font str:(NSString*)str {
    NSMutableParagraphStyle *p = [[NSMutableParagraphStyle alloc] init];
    p.lineBreakMode = NSLineBreakByCharWrapping;


    NSAttributedString *namesAtt = [[NSAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:p}];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)namesAtt);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, 25.)];
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, str.length), path.CGPath, NULL);
    CFRange range = CTFrameGetVisibleStringRange(frame);
    CFRelease(framesetter);
    CFRelease(frame);


    return [str substringWithRange:NSMakeRange(range.location, range.length)];
}

#pragma mark 忽略空白和换行字符
- (NSString*)ignoreCpaceCharacters {
    NSString *str = @"";
    //1. 去除掉首尾的空白字符和换行字符
    str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去除掉其它位置的空白字符和换行字符
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return str;
}

#pragma mark 自定义字符串高亮范围
+ (NSMutableAttributedString*)getAttributedKeyStringWithString:(NSString*)string heightStateRanges:(NSArray*)heightStateRanges heightColor:(UIColor*)heightColor
{
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.alignment = NSTextAlignmentLeft;
    if (!string) {
        return nil;
    }
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    for (int i=0; i < heightStateRanges.count; i++) {
        NSRange range = ((NSValue*)[heightStateRanges objectAtIndex:i]).rangeValue ;
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:heightColor
                           range:range];
    }
    return attrString;
}

#pragma mark 获取子字符串的范围
- (NSArray*)getRangeOfSubstring:(NSString*)subString
{
    NSMutableArray *rangeArray = [NSMutableArray array];
//    NSString *handelString = [self stringByAppendingString:subString];
    NSString *handelString = self;
    NSString *temp;
    for (int i=0; i < self.length; i++) {
        if (i+subString.length > self.length) break;
        temp = [handelString substringWithRange:NSMakeRange(i, subString.length)];
        if (temp.length>0) {
            BOOL result = [temp caseInsensitiveCompare:subString];
            if (result==NSOrderedSame) {
                NSRange range = {i,subString.length};
                [rangeArray addObject:[NSValue valueWithRange:range]];
            }
        }
        
        
    }
    return rangeArray;
}

#pragma mark 禁言时间
+ (NSString*)getGroupBannedTimeWithTimestamp:(uint64_t)timestamp
{
    NSTimeInterval time = timestamp;//毫秒级别精确到秒
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];

    
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];

    return currentDateStr;
}

+ (NSInteger)charStrlength:(NSString *)str
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [str dataUsingEncoding:enc];
    return [data length];
}
@end
