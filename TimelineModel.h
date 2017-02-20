//
//  TimelineModel.h
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Statuses;

@interface TimelineModel : NSObject

@property (nonatomic, assign) int64_t since_id; // 保存微博 ID，若指定此参数，则返回比since_id大的微博（即比 since_id 时间晚的微博），默认为0
@property (nonatomic, assign) int64_t max_id; // 保存微博 ID，若指定此参数，则返回 ID 小于或等于 max_id 的微博，默认为0
@property (nonatomic, copy) NSArray *statuses; // 保存获取到的多条微博信息

+ (NSString *)transformSource:(NSString *)source; // 提取微博来源，例如 来自weibo.com
+ (NSString *)transformDate:(NSString *)createAt; // 转换日期格式 例如 刚刚，5分钟前
+ (NSString *)shortedNumberDesc:(NSUInteger)number; // 缩短数量描述，例如 51234 -> 5万

@end

@interface Statuses : NSObject

@property (nonatomic, assign) int64_t id; // 保存微博 ID
@property (nonatomic, copy) NSString *idstr; // 保存字符串型的微博 ID
@property (nonatomic, assign) int64_t mid; // 保存微博 MID
@property (nonatomic, copy) NSString *created_at; // 保存微博创建时间
@property (nonatomic, copy) NSString *source; // 保存微博来源
@property (nonatomic, copy) NSString *text; // 保存微博信息内容
@property (nonatomic, copy) NSString *reposts_count; // 保存转发数
@property (nonatomic, copy) NSString *comments_count; // 保存评论数
@property (nonatomic, copy) NSString *attitudes_count; // 保存表态数
@property (nonatomic, copy) NSString *bmiddle_pic; // 保存中等尺寸图片地址，没有时不返回此字段
@property (nonatomic, copy) NSArray *pic_urls; // 保存多张微博配图，缩略图
@property (nonatomic, copy) NSDictionary *wbuser; // 保存微博作者的用户信息字段
@property (nonatomic, copy) NSDictionary *retweeted_status; // 保存被转发的原微博信息字段，当该微博为转发微博时返回

@property (nonatomic, copy) NSArray *large_pic_urls; // 保存只要一张微博配图时的大图
@property (nonatomic, copy) NSArray *retweetLarge_pic_urls; // 保存被转发的原微博只有一张配图时的大图


@end
