//
//  WeiboAPIMacro.h
//  weiboTest
//
//  Created by haitao on 17/1/6.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#ifndef WeiboAPIMacro_h
#define WeiboAPIMacro_h

#define kAppKey               @"826107665"      // 第三方应用申请的 appkey，用来身份验证，显示来源等
#define kRedirectURI          @"http://www.sina.com"       // 应用回调页，在进行Oauth2.0登录认证时使用
#define kHOME_TIMELINE @"https://api.weibo.com/2/statuses/home_timeline.json" // 获取当前登录用户及其所关注（授权）用户的最新微博
#define kPUBLIC_TIMELINE @"https://api.weibo.com/2/statuses/public_timeline.json"//	获取最新的公共微博
#define kUSER_SHOW @"https://api.weibo.com/2/users/show.json" // 根据用户ID获取用户信息
#define STATUSES_MENTIONS @"https://api.weibo.com/2/statuses/mentions.json" // 获取@当前用户的微博
#define STATUSES_UPDATE @"https://api.weibo.com/2/statuses/update.json" // 发一条新微博
#define STATUSES_REPOST @"https://api.weibo.com/2/statuses/repost.json" // 转发一条微博
#define COMMENTS_CREATE @"https://api.weibo.com/2/comments/create.json" // 评论一条微博

#define COMMENTS_SHOW @"https://api.weibo.com/2/comments/show.json" // 获取评论

#define kUSER_TIMELINE @"https://api.weibo.com/2/statuses/user_timeline.json" // 获取某个用户最新发表的微博列表

#define COMMENTS_MENTIONS @"https://api.weibo.com/2/comments/mentions.json" // 获取最新的提到当前登录用户的评论，即@我的评论
#define COMMENTS_TIMELINE @"https://api.weibo.com/2/comments/timeline.json" // 获取当前登录用户的最新评论包括接收到的与发出的

#define SUGGESTIONS_USERS @"https://api.weibo.com/2/search/suggestions/users.json" // 搜索用户时的联想搜索建议
#define kTRANDS_HOURLY @"https://api.weibo.com/2/trends/hourly.json" // 返回最近一小时内的热门话题
#define USERS_HOT @"https://api.weibo.com/2/suggestions/users/hot.json" // 返回系统推荐的热门用户列表
#define USERS_COUNT @"https://api.weibo.com/2/users/counts.json" // 批量获取用户的粉丝数，微博数，关注数
#endif /* WeiboAPIMacro_h */
