//
//  CurrentUserModel.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUserModel : NSObject

@property (nonatomic, assign) int64_t id; // 保存微博 ID
@property (nonatomic, copy) NSString *idstr; // 保存字符串型的微博 ID
@property (nonatomic, copy) NSString *name; // 保存友好显示名称
@property (nonatomic, copy) NSString *screen_name; // 保存用户昵称
@property (nonatomic, assign) int province; // 保存所在省份的省份代码
@property (nonatomic, assign) int city; // 保存所在城市的城市代码
@property (nonatomic, copy) NSString *location; // 保存用户所在地
@property (nonatomic, copy) NSString *desc; // 保存用户个人描述
@property (nonatomic, copy) NSString *profile_image_url; // 保存保护用户头像地址（中图），50x50像素
@property (nonatomic, copy) NSString *avatar_large; // 保存用户头像地址（大图），180x180像素
@property (nonatomic, copy) NSString *avatar_hd	; // 保存用户头像地址（高清），高清头像原图
@property (nonatomic, copy) NSString *gender; // 保存性别
@property (nonatomic, assign) int followers_count; // 保存粉丝数
@property (nonatomic, assign) int friends_count; // 保存粉丝数
@property (nonatomic, assign) int statuses_count; // 保存微博数
@property (nonatomic, assign) BOOL allow_all_act_msg; // 保存是否允许所有人给我发私信，true：是，false：否
@property (nonatomic, assign) BOOL verified; // 保存是否是微博认证用户，即加 V 用户，true：是，false：否
@property (nonatomic, copy) NSString *verified_reason; // 保存认证原因
@property (nonatomic, assign) BOOL allow_all_comment; // 保存是否允许所有人评论
@property (nonatomic, assign) BOOL follow_me; //保存是否关注我
@property (nonatomic, assign) int online_status; // 保存用户的在线状态，0：不在线、1：在线
@property (nonatomic, assign) int bi_followers_count; // 保存用户的粉丝数


@end
