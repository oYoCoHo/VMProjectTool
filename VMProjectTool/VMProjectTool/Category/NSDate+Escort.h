// 时间处理工具

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Escort)

#pragma mark - 打印专用
/// 输出当前时间，格式为：年月日时分秒毫秒
+ (const char *)getPrintCurrentFormatterTime;

#pragma mark - Setting default calendar

/**
 Returns the calendarIdentifier of calendars that is used by this library for date calculation.
 @see AZ_setDefaultCalendarIdentifier: for more details.
 */
+ (NSString * _Nullable)AZ_defaultCalendarIdentifier;
/**
 Sets the calendarIdentifier of calendars that is used by this library for date calculation.
 You can specify any calendarIdentifiers predefined by NSLocale. If you provide nil, the library uses
 [NSCalendar currentCalendar]. Default value is nil.
 
 You can't provide individual calendars for individual date objects. If you need to perform such
 complicated date calculations, you should rather create calendars on your own.
 */
+ (void)AZ_setDefaultCalendarIdentifier:(NSString * _Nullable)calendarIdentifier;

#pragma mark - Relative dates from the current date

+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second;

+ (NSDate *)dateTomorrow;

+ (NSDate *)dateYesterday;

+ (NSDate *)dateWithDaysFromNow:(NSInteger) dDays;

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger) dDays;

+ (NSDate *)dateWithHoursFromNow:(NSInteger) dHours;

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger) dHours;

+ (NSDate *)dateWithMinutesFromNow:(NSInteger) dMinutes;

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger) dMinutes;

#pragma mark - Comparing dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *) otherDate;

- (BOOL)isToday;

- (BOOL)isTomorrow;

- (BOOL)isYesterday;

- (BOOL)isSameWeekAsDate:(NSDate *) aDate;

- (BOOL)isThisWeekFromMonday;//当周的第一天从周一开始算

- (BOOL)isThisWeek;

- (BOOL)isNextWeek;

- (BOOL)isLastWeek;

- (BOOL)isSameMonthAsDate:(NSDate *) aDate;

- (BOOL)isThisMonth;

- (BOOL)isSameYearAsDate:(NSDate *) aDate;

- (BOOL)isThisYear;

- (BOOL)isNextYear;

- (BOOL)isLastYear;

- (BOOL)isEarlierThanDate:(NSDate *) aDate;

- (BOOL)isLaterThanDate:(NSDate *) aDate;

- (BOOL)isEarlierThanOrEqualDate:(NSDate *) aDate;

- (BOOL)isLaterThanOrEqualDate:(NSDate *) aDate;

- (BOOL)isInFuture;

- (BOOL)isInPast;

#pragma mark - Date roles

- (BOOL)isTypicallyWorkday;

- (BOOL)isTypicallyWeekend;

#pragma mark - Adjusting dates

- (nullable NSDate *)dateByAddingYears:(NSInteger) dYears;

- (nullable NSDate *)dateBySubtractingYears:(NSInteger) dYears;

- (nullable NSDate *)dateByAddingMonths:(NSInteger) dMonths;

- (nullable NSDate *)dateBySubtractingMonths:(NSInteger) dMonths;

- (nullable NSDate *)dateByAddingDays:(NSInteger) dDays;

- (nullable NSDate *)dateBySubtractingDays:(NSInteger) dDays;

- (nullable NSDate *)dateByAddingHours:(NSInteger) dHours;

- (nullable NSDate *)dateBySubtractingHours:(NSInteger) dHours;

- (nullable NSDate *)dateByAddingMinutes:(NSInteger) dMinutes;

- (nullable NSDate *)dateBySubtractingMinutes:(NSInteger) dMinutes;

- (nullable NSDate *)dateByAddingSeconds:(NSInteger) dSeconds;

- (nullable NSDate *)dateBySubtractingSeconds:(NSInteger) dSeconds;

- (nullable NSDate *)dateAtStartOfDay;

- (nullable NSDate *)dateAtStartOfNextDay;

- (nullable NSDate *)dateAtStartOfWeek;

- (nullable NSDate *)dateAtStartOfNextWeek;

- (nullable NSDate *)dateAtStartOfMonth;

- (nullable NSDate *)dateAtStartOfNextMonth;

- (nullable NSDate *)dateAtStartOfYear;

- (nullable NSDate *)dateAtStartOfNextYear;

#pragma mark - Retrieving intervals
- (NSInteger)secondsAfterDate:(NSDate *) aDate;

- (NSInteger)secondsBeforeDate:(NSDate *) aDate;

- (NSInteger)minutesAfterDate:(NSDate *) aDate;

- (NSInteger)minutesBeforeDate:(NSDate *) aDate;

- (NSInteger)hoursAfterDate:(NSDate *) aDate;

- (NSInteger)hoursBeforeDate:(NSDate *) aDate;

- (NSInteger)daysAfterDate:(NSDate *) aDate;

- (NSInteger)daysBeforeDate:(NSDate *) aDate;

- (NSInteger)monthsAfterDate:(NSDate *) aDate;

- (NSInteger)monthsBeforeDate:(NSDate *) aDate;

/**
 * return distance days
 */
- (NSInteger)distanceInDaysToDate:(NSDate *) aDate;

#pragma mark amount

- (NSInteger)hoursOfDay;

- (NSInteger)daysOfMonth;

- (NSInteger)daysOfYear;

- (NSInteger)monthsOfYear;

#pragma mark other
- (NSString *)timestampString;



#pragma mark - Decomposing dates
/**
 * return nearest hour
 */
@property(readonly) NSInteger nearestHour;
@property(readonly) NSInteger hour;
@property(readonly) NSInteger minute;
@property(readonly) NSInteger seconds;
@property(readonly) NSInteger day;
@property(readonly) NSInteger month;
@property(readonly) NSInteger week;
//  in the Gregorian calendar, n is 7 and Sunday is represented by 1.
@property(readonly) NSInteger weekday;
@property(readonly) NSInteger firstDayOfWeekday;
@property(readonly) NSInteger lastDayOfWeekday;
// e.g. 2nd Tuesday of the month == 2
@property(readonly) NSInteger nthWeekday;
@property(readonly) NSInteger year;
@property(readonly) NSInteger gregorianYear;






+ (NSString *)getTimeFromTimestampWithTime:(NSTimeInterval)time;

#pragma mark 比较两个时间是否同一个月
+ (BOOL)isSameMonth:(long)iTime1 Time2:(long)iTime2;

+ (BOOL)isSameDay:(long)iTime1 Time2:(long)iTime2;

#pragma mark 比较两个时间，1 - 过期, 0 - 相等, -1 - 没过期
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

#pragma mark  时间戳转换 timestamp:毫秒级别
+ (NSString*)getTimeStringWithTimestamp:(uint64_t)timestamp dateFormat:(NSString*)dateFormat;

#pragma mark 两个时间间隔比较 DateFormat:yyyy-MM-dd  HH:mm:ss unit:比较的单位
+ (NSInteger)compareBeginTime:(NSString*)beginTime endTime:(NSString*)endTime unit:(NSCalendarUnit)unit;

#pragma mark 日期格式转字符串
+ (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format;

#pragma mark 字符串转日期格式
+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format;

#pragma mark 时间戳转Date
+ (NSDate*)dateWithSecondTimestamp:(u_int64_t)timestamp;

#pragma mark 会话列表和聊天详情时间
+ (NSString*)getTimeWithTimestamp:(uint64_t)timestamp isList:(BOOL)isList;

#pragma mark 发送消息的时间
+ (NSString*)getSendTimeWithTimestamp:(uint64_t)timestamp;

#pragma mark 获取当前 年、月、日、时、分、秒 的字符串数组
+ (NSArray<NSString *> *)getCurrentDateStringArray;

#pragma mark 好友在线状态时间显示
+ (NSString*)getOnlineTimeWithTimestamp:(u_int64_t)timestamp;

#pragma mark - 指定日期转换为时间戳
/// 指定日期转换为时间戳
+ (NSString *)timestampWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;
/// 具体时间转换为时间戳，以及是否13位长度
+ (NSString *)timestampWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second is13Bit:(BOOL)is13Bit;

/// 时间戳转日期
+ (NSString *)stringWithTimestamp:(NSUInteger)timestamp formatter:(NSString *)formatter;

#pragma mark 时间戳转日期格式
+ (NSString*)dateStringWithSecondTimestamp:(u_int64_t)timestamp WithFormat:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
