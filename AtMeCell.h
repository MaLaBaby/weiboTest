//
//  AtMeCell.h
//  weiboTest
//
//  Created by haitao on 17/2/6.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AtMeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *atMePersonImage;//at我的人的头像
@property (strong, nonatomic) IBOutlet UILabel *atMePersonName;//at我的人的名字
@property (strong, nonatomic) IBOutlet UILabel *atMeTime;//at我的时间
@property (strong, nonatomic) IBOutlet UILabel *myName;//我的昵称
@property (strong, nonatomic) IBOutlet UIView *topicView;//存储主题的视图
@property (strong, nonatomic) IBOutlet UIImageView *topicPersonImage;//主题人的头像
@property (strong, nonatomic) IBOutlet UILabel *topicPersonName;//主题人的昵称
@property (strong, nonatomic) IBOutlet UILabel *topicContent;//主题内容
@property (strong, nonatomic) IBOutlet UIView *bottomView;//底部视图
@property (strong, nonatomic) IBOutlet UIView *replaceView;//转发视图
@property (strong, nonatomic) IBOutlet UIView *commentView;//评论视图
@property (strong, nonatomic) IBOutlet UIView *attitudeView;//点赞视图
@property (nonatomic) int64_t id; // 保存微博 ID
@end
