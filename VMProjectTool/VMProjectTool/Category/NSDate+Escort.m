#import "NSDate+Escort.h"

NS_ASSUME_NONNULL_BEGIN

@implementation NSDate (Escort)

#pragma mark - 打印专用
/// 输出当前时间，格式为：年月日时分秒毫秒
+ (const char *)getPrintCurrentFormatterTime {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss:";
    });
    double timer = CFAbsoluteTimeGetCurrent();
    unsigned long num = timer;
    num = (timer - num) * 1000000;
    NSString *time = [[NSString alloc] initWithFormat:@"%@%lu", [formatter stringFromDate:NSDate.date], num];
    return [time UTF8String];
}

static NSString * AZ_DefaultCalendarIdentifier = nil;
static NSLock * AZ_DefaultCalendarIdentifierLock = nil;
static dispatch_once_t AZ_DefaultCalendarIdentifierLock_onceToken;

#pragma mark - private
+ (NSCalendar *)AZ_currentCalendar {
    NSString *key = @"AZ_currentCalendar_";
    NSString *calendarIdentifier = [NSDate AZ_defaultCalendarIdentifier];
    if (calendarIdentifier) {
        key = [key stringByAppendingString:calendarIdentifier];
    }
    NSMutableDictionary *dictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *currentCalendar = [dictionary objectForKey:key];
    if (currentCalendar == nil) {
        if (calendarIdentifier == nil) {
            currentCalendar = [NSCalendar currentCalendar];
        } else {
            currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:calendarIdentifier];
            NSAssert(currentCalendar != nil, @"NSDate-Escort failed to create a calendar since the provided calendarIdentifier is invalid.");
        }
        [dictionary setValue:currentCalendar forKey:key];
    }
    currentCalendar.timeZone = [NSTimeZone localTimeZone];
    return currentCalendar;
}

- (NSInteger)numberOfDaysInWeek {
    return [[NSDate AZ_currentCalendar] maximumRangeOfUnit:NSCalendarUnitWeekday].length;
}
#pragma mark - Setting default calendar
+ (NSString * _Nullable)AZ_defaultCalendarIdentifier {
    dispatch_once(&AZ_DefaultCalendarIdentifierLock_onceToken, ^{
        AZ_DefaultCalendarIdentifierLock = [[NSLock alloc] init];
    });
    NSString *string;
    [AZ_DefaultCalendarIdentifierLock lock];
    string = AZ_DefaultCalendarIdentifier;
    [AZ_DefaultCalendarIdentifierLock unlock];
    return string;
}
+ (void)AZ_setDefaultCalendarIdentifier:(NSString * _Nullable)calendarIdentifier {
    dispatch_once(&AZ_DefaultCalendarIdentifierLock_onceToken, ^{
        AZ_DefaultCalendarIdentifierLock = [[NSLock alloc] init];
    });
    [AZ_DefaultCalendarIdentifierLock lock];
    AZ_DefaultCalendarIdentifier = calendarIdentifier;
    [AZ_DefaultCalendarIdentifierLock unlock];
}
#pragma mark - Relative dates from the current date
+ (NSDate *)dateWithYear:(NSInteger)year
                   month:(NSInteger)month
                     day:(NSInteger)day
                    hour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second{
    
    NSString*string = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%02ld:%02ld",year, month, day, hour, minute, second];
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init] ;
    [inputFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    return  inputDate;
}

+ (NSDate *)dateTomorrow {
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateDayBeforeYesterday {
    return [NSDate dateWithDaysBeforeNow:2];
}

+ (NSDate *)dateDaysBeforeNow3 {
    return [NSDate dateWithDaysBeforeNow:3];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger) dDays {
    return [[NSDate date] dateByAddingDays:dDays];
}

+ (NSDate *)dateWithDaysBeforeNow:(NSInteger) dDays {
    return [[NSDate date] dateBySubtractingDays:dDays];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger) dHours {
    return [[NSDate date] dateByAddingHours:dHours];
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger) dHours {
    return [[NSDate date] dateBySubtractingHours:dHours];
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger) dMinutes {
    return [[NSDate date] dateByAddingMinutes:dMinutes];
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger) dMinutes {
    return [[NSDate date] dateBySubtractingMinutes:dMinutes];
}

#pragma mark - Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *) otherDate {
    NSCalendar *currentCalendar = [NSDate AZ_currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *components1 = [currentCalendar components:unitFlags fromDate:self];
    NSDateComponents *components2 = [currentCalendar components:unitFlags fromDate:otherDate];
    return (components1.era == components2.era) &&
        (components1.year == components2.year) &&
        (components1.month == components2.month) &&
        (components1.day == components2.day);
}

- (BOOL)isToday {
    return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
    return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

- (BOOL)isDayBeforeYesterday {
    return [self isEqualToDateIgnoringTime:[NSDate dateDayBeforeYesterday]];
}

- (BOOL)isDaysBeforeNow3 {
    return [self isEqualToDateIgnoringTime:[NSDate dateDaysBeforeNow3]];
}

- (BOOL)isSameWeekAsDate:(NSDate *) aDate {
    NSDateComponents *leftComponents = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:self];
    NSDateComponents *rightComponents = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekOfYear | NSCalendarUnitYearForWeekOfYear fromDate:aDate];
    return leftComponents.weekOfYear == rightComponents.weekOfYear
    && leftComponents.yearForWeekOfYear == rightComponents.yearForWeekOfYear;
}

- (BOOL)isThisWeekFromMonday {//当周的第一天从周一开始算
    BOOL isSameWeek = NO;
    if ([self isSameWeekAsDate:[NSDate date]]) {
        isSameWeek = YES;
        if (self.weekday == 1 && ![self isToday]) {
            isSameWeek = NO;
        }
        
    }
    return isSameWeek;
}

- (BOOL)isThisWeek {
    return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
    NSDate *nextWeek = [NSDate dateWithDaysFromNow:[self numberOfDaysInWeek]];
    return [self isSameWeekAsDate:nextWeek];
}

- (BOOL)isLastWeek {
    NSDate *lastWeek = [NSDate dateWithDaysBeforeNow:[self numberOfDaysInWeek]];
    return [self isSameWeekAsDate:lastWeek];
}

- (BOOL)isSameMonthAsDate:(NSDate *) aDate {
    NSDate *dateAtStartSelf = [[self dateAtStartOfMonth] dateAtStartOfDay];
    NSDate *dateAtStartArgs = [[aDate dateAtStartOfMonth] dateAtStartOfDay];
    return [dateAtStartSelf isEqualToDate:dateAtStartArgs];
}

- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isSameYearAsDate:(NSDate *) aDate {
    NSDate *dateAtStartSelf = [[self dateAtStartOfYear] dateAtStartOfDay];
    NSDate *dateAtStartArgs = [[aDate dateAtStartOfYear] dateAtStartOfDay];
    return [dateAtStartSelf isEqualToDate:dateAtStartArgs];
}

- (BOOL)isThisYear {
    return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSDate *nextYear = [[NSDate date] dateByAddingYears:1];
    return [self isSameYearAsDate:nextYear];
}

- (BOOL)isLastYear {
    NSDate *lastYear = [[NSDate date] dateBySubtractingYears:1];
    return [self isSameYearAsDate:lastYear];
}

- (BOOL)isEarlierThanDate:(NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isEarlierThanOrEqualDate:(NSDate *) aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedAscending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isLaterThanOrEqualDate:(NSDate *) aDate {
    NSComparisonResult comparisonResult = [self compare:aDate];
    return (comparisonResult == NSOrderedDescending) || (comparisonResult == NSOrderedSame);
}

- (BOOL)isInPast {
    return [self isEarlierThanDate:[NSDate date]];
}

- (BOOL)isInFuture {
    return [self isLaterThanDate:[NSDate date]];
}


#pragma mark - Date roles
// https://github.com/erica/NSDate-Extensions/issues/12
- (BOOL)isTypicallyWorkday {
    return ([self isTypicallyWeekend] == NO);
}

- (BOOL)isTypicallyWeekend {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange weekdayRange = [calendar maximumRangeOfUnit:NSCalendarUnitWeekday];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:self];
    NSInteger weekdayOfDate = [components weekday];
    return (weekdayOfDate == weekdayRange.location || weekdayOfDate == weekdayRange.location + weekdayRange.length - 1);
}

#pragma mark - Adjusting dates
- (nullable NSDate *)dateByAddingYears:(NSInteger) dYears {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.year = dYears;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingYears:(NSInteger) dYears {
    return [self dateByAddingYears:-dYears];
}

- (nullable NSDate *)dateByAddingMonths:(NSInteger) dMonths {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.month = dMonths;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingMonths:(NSInteger) dMonths {
    return [self dateByAddingMonths:-dMonths];
}

- (nullable NSDate *)dateByAddingDays:(NSInteger) dDays {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = dDays;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingDays:(NSInteger) dDays {
    return [self dateByAddingDays:-dDays];
}

- (nullable NSDate *)dateByAddingHours:(NSInteger) dHours {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.hour = dHours;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingHours:(NSInteger) dHours {
    return [self dateByAddingHours:-dHours];
}

- (nullable NSDate *)dateByAddingMinutes:(NSInteger) dMinutes {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.minute = dMinutes;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingMinutes:(NSInteger) dMinutes {
    return [self dateByAddingMinutes:-dMinutes];
}

- (nullable NSDate *)dateByAddingSeconds:(NSInteger) dSeconds {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.second = dSeconds;
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (nullable NSDate *)dateBySubtractingSeconds:(NSInteger) dSeconds {
    return [self dateByAddingSeconds:-dSeconds];
}

- (nullable NSDate *)dateAtStartOfDay {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.timeZone = calendar.timeZone;
    return [calendar dateFromComponents:components];
}

- (nullable NSDate *)dateAtStartOfNextDay {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    components.day += 1;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.timeZone = calendar.timeZone;
    return [calendar dateFromComponents:components];
}

- (nullable NSDate *)dateAtStartOfWeek
{
    NSDate *startOfWeek = nil;
    [[NSDate AZ_currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startOfWeek interval:NULL forDate:self];
    return startOfWeek;
}

- (nullable NSDate *)dateAtStartOfNextWeek {
    NSDate *startOfWeek = nil;
    NSTimeInterval interval = 0;
    [[NSDate AZ_currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth startDate:&startOfWeek interval:&interval forDate:self];
    return [startOfWeek dateByAddingTimeInterval:interval];
}

- (nullable NSDate *)dateAtStartOfMonth {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = range.location;
    return [calendar dateFromComponents:components];
}

- (nullable NSDate *)dateAtStartOfNextMonth {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.month += 1;
    components.day = range.location;
    return [calendar dateFromComponents:components];
}

- (nullable NSDate *)dateAtStartOfYear {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.day = dayRange.location;
    components.month = monthRange.location;
    NSDate *startOfYear = [calendar dateFromComponents:components];
    return startOfYear;
}

- (nullable NSDate *)dateAtStartOfNextYear {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:self];
    NSRange monthRange = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    NSRange dayRange = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    components.year += 1;
    components.day = dayRange.location;
    components.month = monthRange.location;
    NSDate *startOfYear = [calendar dateFromComponents:components];
    return startOfYear;
}


#pragma mark - Retrieving intervals
- (NSInteger)secondsAfterDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitSecond fromDate:aDate toDate:self options:0];
    return [components second];
}

- (NSInteger)secondsBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitSecond fromDate:self toDate:aDate options:0];
    return [components second];
}

- (NSInteger)minutesAfterDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMinute fromDate:aDate toDate:self options:0];
    return [components minute];
}

- (NSInteger)minutesBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMinute fromDate:self toDate:aDate options:0];
    return [components minute];
}

- (NSInteger)hoursAfterDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitHour fromDate:aDate toDate:self options:0];
    return [components hour];
}

- (NSInteger)hoursBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitHour fromDate:self toDate:aDate options:0];
    return [components hour];
}

- (NSInteger)daysAfterDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitDay fromDate:aDate toDate:self options:0];
    return [components day];
}

- (NSInteger)daysBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [components day];
}

- (NSInteger)monthsAfterDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMonth fromDate:aDate toDate:self options:0];
    return [components month];
}

- (NSInteger)monthsBeforeDate:(NSDate *) aDate {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMonth fromDate:self toDate:aDate options:0];
    return [components month];
}

- (NSTimeInterval)timeIntervalIgnoringDay:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:aDate];
    NSDateComponents *components1 = [calendar components:unitFlags fromDate:self];
    return [[calendar dateFromComponents:components] timeIntervalSinceDate:[calendar dateFromComponents:components1]];
}

- (NSInteger)distanceInDaysToDate:(NSDate *) aDate {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDateComponents *dateComponents = [calendar
        components:NSCalendarUnitDay fromDate:self toDate:aDate options:0];
    return [dateComponents day];
}

#pragma amount

- (NSInteger)hoursOfDay {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitHour inUnit:NSCalendarUnitDay forDate:self];
    return range.length;
}

- (NSInteger)daysOfMonth {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)daysOfYear {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSDate *startOfYear;
    NSTimeInterval lengthOfYear;
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&startOfYear interval:&lengthOfYear forDate:self];
    
    NSDate *endOfYear = [startOfYear dateByAddingTimeInterval:lengthOfYear];
    return [startOfYear daysBeforeDate:endOfYear];
}

- (NSInteger)monthsOfYear {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitMonth inUnit:NSCalendarUnitYear forDate:self];
    return range.length;
}

- (NSString *)timestampString {
    NSTimeInterval nowtime = [self timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%.0f",nowtime];
    return timeStr;
}

#pragma mark - Decomposing dates
// NSDate-Utilities API is broken?
- (NSInteger)nearestHour {
    NSCalendar *calendar = [NSDate AZ_currentCalendar];
    NSRange minuteRange = [calendar rangeOfUnit:NSCalendarUnitMinute inUnit:NSCalendarUnitHour forDate:self];
    // always 30...
    NSInteger halfMinuteInHour = minuteRange.length / 2;
    NSInteger currentMinute = self.minute;
    if (currentMinute < halfMinuteInHour) {
        return self.hour;
    } else {
        NSDate *anHourLater = [self dateByAddingHours:1];
        return [anHourLater hour];
    }
}

- (NSInteger)hour {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSInteger)minute {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return [components minute];
}

- (NSInteger)seconds {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return [components second];
}

- (NSInteger)day {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSInteger)month {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSInteger)week {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self];
    return [components weekOfMonth];
}

- (NSInteger)weekday {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekday fromDate:self];
    return [components weekday];
}

// http://stackoverflow.com/questions/11681815/current-week-start-and-end-date
- (NSInteger)firstDayOfWeekday {
    NSDate *startOfTheWeek;
    NSTimeInterval interval;
    [[NSDate AZ_currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                 startDate:&startOfTheWeek
                                 interval:&interval
                                 forDate:self];
    return [startOfTheWeek day];
}

- (NSInteger)lastDayOfWeekday {
    return [self firstDayOfWeekday] + ([self numberOfDaysInWeek] - 1);
}

- (NSInteger)nthWeekday {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self];
    return [components weekdayOrdinal];
}

- (NSInteger)year {
    NSDateComponents *components = [[NSDate AZ_currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return [components year];
}
- (NSInteger)gregorianYear {
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [currentCalendar components:NSCalendarUnitEra | NSCalendarUnitYear fromDate:self];
    return [components year];
}




+ (NSString*)getTimeHourAndMinutesStringWithTimestamp:(uint64_t)timestamp
{
    NSString *currentDateStr = [self getTimeStringWithTimestamp:timestamp dateFormat:@"HH:mm"];
    
    return currentDateStr;
}

+ (NSString*)getTimeDayStringWithTimestamp:(uint64_t)timestamp
{
    NSString *currentDateStr = [self getTimeStringWithTimestamp:timestamp dateFormat:@"yyyy-MM-dd"];
    
    return currentDateStr;
}

+ (NSString*)getTimeMonthDayStringWithTimestamp:(uint64_t)timestamp
{
    NSString *currentDateStr = [self getTimeStringWithTimestamp:timestamp dateFormat:@"MM月dd日"];
    
    return currentDateStr;
}

+ (NSString*)getTimeDayChineseStringWithTimestamp:(uint64_t)timestamp
{
    NSString *currentDateStr = [self getTimeStringWithTimestamp:timestamp dateFormat:@"yyyy年MM月dd日"];
    
    return currentDateStr;
}

+ (NSString*)getTimeStringWithTimestamp:(uint64_t)timestamp dateFormat:(NSString*)dateFormat
{
    NSTimeInterval time = timestamp/1000;//毫秒级别精确到秒

    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象

    [dateFormatter setDateFormat:dateFormat];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    
    return currentDateStr;
}





#pragma mark 比较两个时间是否同一个月
+ (BOOL)isSameMonth:(long)iTime1 Time2:(long)iTime2
{
    //传入时间毫秒数
    NSDate *pDate1 = [NSDate dateWithTimeIntervalSince1970:iTime1/1000];
    NSDate *pDate2 = [NSDate dateWithTimeIntervalSince1970:iTime2/1000];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:pDate1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:pDate2];
    
    return [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (BOOL)isSameDay:(long)iTime1 Time2:(long)iTime2
{
    //传入时间毫秒数
    NSDate *pDate1 = [NSDate dateWithTimeIntervalSince1970:iTime1/1000];
    NSDate *pDate2 = [NSDate dateWithTimeIntervalSince1970:iTime2/1000];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:pDate1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:pDate2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


+ (NSString *)getTimeFromTimestampWithTime:(NSTimeInterval)time{

    //将对象类型的时间转换为NSDate类型

    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:time];

    //设置时间格式

    NSDateFormatter * formatter=[[NSDateFormatter alloc]init];

    [formatter setDateFormat:@"YYYY.MM.dd HH:mm:ss"];

    //将时间转换为字符串

    NSString *timeStr=[formatter stringFromDate:myDate];

    return timeStr;

}

#pragma mark 比较两个时间，1 - 过期, 0 - 相等, -1 - 没过期
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
//    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
//    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [oneDay compare:anotherDay];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
    
}


#pragma mark 两个时间间隔比较
+ (NSInteger)compareBeginTime:(NSString*)beginTime endTime:(NSString*)endTime unit:(NSCalendarUnit)unit {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss"];
    
    NSDate *startDate = [dateFormatter dateFromString:beginTime];
    NSDate *endDate = [dateFormatter dateFromString:endTime];
    
    //结果间隔
    NSInteger interval = 0;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    /**
     * 要比较的时间单位,常用如下,可以同时传：
     *
     *    NSCalendarUnitDay : 天
     *    NSCalendarUnitYear : 年
     *    NSCalendarUnitMonth : 月
     *    NSCalendarUnitHour : 时
     *    NSCalendarUnitMinute : 分
     *    NSCalendarUnitSecond : 秒
     *    NSCalendarUnitWeekdayOrdinal : 星期
     */
    NSDateComponents *delta = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    switch (unit) {
        case NSCalendarUnitDay:
            interval = delta.day;
            break;
        case NSCalendarUnitYear:
            interval = delta.year;
            break;
        case NSCalendarUnitMonth:
            interval = delta.month;
            break;
        case NSCalendarUnitWeekdayOrdinal:
            interval = delta.weekday;
            break;
        case NSCalendarUnitHour:
            interval = delta.hour;
            break;
        case NSCalendarUnitMinute:
            interval = delta.minute;
            break;
        case NSCalendarUnitSecond:
            interval = delta.second;
            break;
            
        default:
            break;
    }
    
    return interval;
}



#pragma mark 日期格式转字符串
+ (NSString *)dateToString:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

#pragma mark 字符串转日期格式
+ (NSDate *)stringToDate:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];

    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

//将世界时间转化为中国区时间
+ (NSDate *)worldTimeToChinaTime:(NSDate *)date
{
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval:interval];
    return localeDate;
}

#pragma mark 时间戳转Date
+ (NSDate*)dateWithSecondTimestamp:(u_int64_t)timestamp {
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:timestamp];
    
    return date;
}

#pragma mark 会话列表和聊天详情时间
+ (NSString*)getTimeWithTimestamp:(uint64_t)timestamp isList:(BOOL)isList
{

    NSTimeInterval time = timestamp/1000;
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    
    NSString *currentDateStr = @"";
    if (isList) {
        NSString *detailTime = [self getTimeHourAndMinutesStringWithTimestamp:timestamp];
        
        //上午/下午 加时间
        NSInteger hour = detailDate.hour;
        NSString *middleString = @"";
        if (hour > 11) {
            middleString = @"下午";
        } else {
            middleString = @"上午";
        }
        NSString *detailPart = detailTime;
        if (middleString.length > 0 && ![detailDate isYesterday]) {
            detailPart = [NSString stringWithFormat:@"%@ %@",middleString,detailTime];
        }
                
        if ([detailDate isToday]) {
            currentDateStr = detailPart;
        } else if ([detailDate isYesterday]) {
            currentDateStr = [NSString stringWithFormat:@"昨天 %@",detailPart];
        } else if ([detailDate isThisWeekFromMonday]) {
            NSString *weekday = @"";
            if (detailDate.weekday == 1) {
                weekday = @"周日";
            } else if (detailDate.weekday == 2) {
                weekday = @"周一";
            } else if (detailDate.weekday == 3) {
                weekday = @"周二";
            } else if (detailDate.weekday == 4) {
                weekday = @"周三";
            } else if (detailDate.weekday == 5) {
                weekday = @"周四";
            } else if (detailDate.weekday == 6) {
                weekday = @"周五";
            } else if (detailDate.weekday == 7) {
                weekday = @"周六";
            }
            
            currentDateStr = weekday;
        } else if ([detailDate isThisYear]) {
            currentDateStr = [self getTimeMonthDayStringWithTimestamp:timestamp];
        } else {
            currentDateStr = [self getTimeDayChineseStringWithTimestamp:timestamp];
        }
    } else {
        NSString *detailTime = [self getTimeHourAndMinutesStringWithTimestamp:timestamp];
        
        
        NSInteger hour = detailDate.hour;
        NSString *middleString = @"";
        if ([detailDate isToday]) {
            NSDate *dateNow = [NSDate date];
            NSInteger hourNow = dateNow.hour;
            if (hourNow > 11) {
                if (hour > 11) {
                    middleString = @"下午";
                } else {
                    middleString = @"上午";
                }
            }
        } else {
            if (hour > 11) {
                middleString = @"下午";
            } else {
                middleString = @"上午";
            }
        }
       
        NSString *detailPart = detailTime;
        if (middleString.length > 0) {
            detailPart = [NSString stringWithFormat:@"%@ %@",middleString,detailTime];
        }
        
        if ([detailDate isToday]) {
            currentDateStr = detailPart;
        } else if ([detailDate isYesterday]) {
            currentDateStr = [NSString stringWithFormat:@"%@ %@",@"昨天",detailPart];
        } else if ([detailDate isThisYear]) {
            currentDateStr = [NSString stringWithFormat:@"%@ %@",[self getTimeMonthDayStringWithTimestamp:timestamp],detailPart];
        } else {
            currentDateStr = [NSString stringWithFormat:@"%@ %@",[self getTimeDayChineseStringWithTimestamp:timestamp],detailPart];
        }
        
        
    }

    return currentDateStr;
}


#pragma mark 发送消息的时间
+ (NSString*)getSendTimeWithTimestamp:(uint64_t)timestamp {
    
    NSString *currentDateStr = [self getTimeStringWithTimestamp:timestamp dateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return currentDateStr;
}

#pragma mark 获取当前 年、月、日、时、分、秒 的字符串数组
+ (NSArray<NSString *> *)getCurrentDateStringArray {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    NSArray<NSString *> *currentDateStringArray = [currentDateString componentsSeparatedByString:@"-"];
    return currentDateStringArray;
}

#pragma mark 好友在线状态时间显示
+ (NSString*)getOnlineTimeWithTimestamp:(u_int64_t)timestamp {
    NSString *onlineTime = @"";
    NSDate *onlineDate = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSDate *curDate = [NSDate date];
    u_int64_t serverTime = [[YXIMSDKManager shareManager] getSDKServerTime];
    if (serverTime == 0) {
        curDate = [NSDate dateWithSecondTimestamp:(serverTime/1000)];
    }
    
    if ([onlineDate isToday]) {
        NSInteger minutes = [onlineDate minutesBeforeDate:curDate];
        if (minutes < 5) {
            onlineTime = @"在线";
        } else if (minutes < 60) {
            onlineTime = [NSString stringWithFormat:@"%ld分钟前在线",(long)minutes];
        } else {
            NSInteger hours = [onlineDate hoursBeforeDate:curDate];
            onlineTime = [NSString stringWithFormat:@"%ld小时前在线",(long)hours];
        }
    } else {
        NSInteger day = [onlineDate daysBeforeDate:curDate];
        if (day == 0) {
            day = 1;
        }
        if (day > 7) {
            day = 7;
        }
        
        onlineTime = [NSString stringWithFormat:@"%ld天前在线",(long)day];
//        NSInteger months = [onlineDate monthsBeforeDate:curDate];
//        if (day <= 30) {
//            onlineTime = [NSString stringWithFormat:@"%ld天前在线",(long)day];
//        } else if (day > 30 && months <= 12) {
//            onlineTime = [NSString stringWithFormat:@"%ld个月前在线",(long)months];
//        } else {
//            NSInteger years = [onlineDate yearsBeforeDate:curDate];
//            onlineTime = [NSString stringWithFormat:@"%ld年前在线",(long)years];
//        }
    }
    
    if (timestamp == 0) {
        onlineTime = @"7天前在线";
    }
    
    return onlineTime;
    
}

#pragma mark - 指定日期转换为时间戳
/// 指定日期转换为时间戳
+ (NSString *)timestampWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    return [self timestampWithYear:year month:month day:day hour:0 minute:0 second:0 is13Bit:NO];
}

/// 具体时间转换为时间戳
+ (NSString *)timestampWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day hour:(NSUInteger)hour minute:(NSUInteger)minute second:(NSUInteger)second is13Bit:(BOOL)is13Bit {
    NSString *dateString = [[NSString alloc] initWithFormat:@"%zd-%02zd-%02zd %02zd:%02zd:%02zd", year, month, day, hour, minute, second];
 
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    NSTimeInterval timestamp = [date timeIntervalSince1970];
    if (is13Bit) {
        timestamp *= 1000;
    }
    return [[NSString alloc] initWithFormat:@"%zd", (NSUInteger)timestamp];
}

/// 时间戳转日期
+ (NSString *)stringWithTimestamp:(NSUInteger)timestamp formatter:(NSString *)formatter {
    NSString *timestampString = [[NSString alloc] initWithFormat:@"%zd", timestamp];
    if (timestampString.length > 10) {
        timestampString = [timestampString substringToIndex:10];
    }
    NSTimeInterval interval = timestampString.doubleValue;

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];

    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = formatter;
    
    NSString *rstString = [dateFormatter stringFromDate:date];
    return rstString;
}

#pragma mark 时间戳转日期格式
+ (NSString*)dateStringWithSecondTimestamp:(u_int64_t)timestamp WithFormat:(NSString *)format {
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:timestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSString *timeString = [formatter stringFromDate:date];
    
    return timeString;
}

@end

NS_ASSUME_NONNULL_END
