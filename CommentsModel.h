//
//  CommentsModel.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentsModel : NSObject

@property (copy, nonatomic) NSArray *comments; // 保存多条评论信息
@property (assign, nonatomic) int64_t total_number; // 保存获取到的评论条数

+ (NSString *)convertDateformat:(NSString *)dateStr; // 转换日期显示格式

@end

@interface Comments : NSObject // 评论字段

@property (nonatomic) int64_t id; // 保存评论的 ID
@property (nonatomic, copy) NSString *idstr; // 保存字符串型的评论 ID
@property (nonatomic, copy) NSString *created_at; // 保存评论创建时间
@property (nonatomic, copy) NSString *text; // 保存评论的内容
@property (nonatomic, copy) NSDictionary *wbuser; // 保存评论作者的用户信息字段

@end
