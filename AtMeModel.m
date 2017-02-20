//
//  AtMeModel.m
//  weiboTest
//
//  Created by haitao on 17/2/7.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AtMeModel.h"
#import "NSDate+Extension.h"

@implementation AtMeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"statuses_two" : [Statuses_two class]};
}

+ (NSString *)transformSource:(NSString *)source {
    if (source != nil && [source hasPrefix:@"<"]) {
        NSRange range;
        range.location = [source rangeOfString:@">"].location + 1;
        range.length = [source rangeOfString:@"</"].location - range.location;
        NSString *sourceTitle = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
        return sourceTitle;
    }else {
        return @"来自其他";
    }
}

+ (NSString *)transformDate:(NSString *)createdAt {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // NSLocale
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_us"];
    // E: 星期
    // M: 月份
    // d: 日期
    // H: 24小时制的小时
    // m: 分钟
    // s: 秒
    // y: 年
    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDate *createdDate = [dateFormatter dateFromString:createdAt];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:createdDate toDate:now options:0];
    if ([createdDate isThisYear])
    {
        if ([createdDate isYestoday])
        {
            dateFormatter.dateFormat = @"昨天HH:mm";
            return [dateFormatter stringFromDate:createdDate];
        }else if ([createdDate isToday])
        {
            if (dateComponents.hour >= 1)
            {
                return [NSString stringWithFormat:@"%ld小时前", (long)dateComponents.hour];
            }else if (dateComponents.minute >= 1)
            {
                return [NSString stringWithFormat:@"%ld分钟前", (long)dateComponents.minute];
            }else
            {
                return @"刚刚";
            }
        }else
        {
            dateFormatter.dateFormat = @"MM-dd";
            return [dateFormatter stringFromDate:createdDate];
        }
    }
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:createdDate];
}

+ (NSString *)shortedNumberDesc:(NSUInteger)number {
    // should be localized
    if (number <= 9999) return [NSString stringWithFormat:@"%d", (int)number];
    if (number <= 9999999) return [NSString stringWithFormat:@"%d万", (int)(number / 10000)];
    return [NSString stringWithFormat:@"%d千万", (int)(number / 10000000)];
}


@end

@implementation Statuses_two

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"wbuser" : @"user"};
}

@end
