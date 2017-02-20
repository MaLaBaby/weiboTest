//
//  CommentsModel.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "CommentsModel.h"

@implementation CommentsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"comments" : [Comments class]};
}

+ (NSString *)convertDateformat:(NSString *)dateStr {
//    NSDateFormatter *dateFormatter = [NSDateFormatter new];
//    dateFormatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//    NSDate *date = [dateFormatter dateFromString:dateStr];
//    NSLog(@"date ====== %@",date);
//    dateFormatter.dateFormat = @"MM-dd HH:mm";
//    NSString *newString = [dateFormatter stringFromDate:date];
//    return newString;
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
    NSDate *createdDate = [dateFormatter dateFromString:dateStr];
    dateFormatter.dateFormat = @"MM-dd HH:mm";
    NSString *newString = [dateFormatter stringFromDate:createdDate];
    return newString;
}

@end

@implementation Comments

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"wbuser" : @"user"};
}


@end
