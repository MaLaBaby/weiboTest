//
//  FindTableViewCell.h
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "FindViewController.h"
#import "DetailViewController.h"

// 颜色
#define kWBCellTextNormalColor UIColorHex(333333) // 一般文本色
#define kWBCellTextSubTitleColor UIColorHex(5d5d5d) // 次要文本色
#define kWBCellTextHighlightColor UIColorHex(527ead) // Link 文本色
#define kWBCellTextHighlightBackgroundColor UIColorHex(bfdffe) // Link 点击背景色
#define kWBCellToolbarTitleColor UIColorHex(929292) // 工具栏文本色
#define kWBCellToolbarTitleHighlightColor UIColorHex(df422d) // 工具栏文本高亮色

#define kWBLinkHrefName @"href" //NSString
#define kWBLinkURLName @"url" //WBURL
#define kWBLinkTagName @"tag" //WBTag
#define kWBLinkTopicName @"topic" //WBTopic
#define kWBLinkAtName @"at" //NSString

@interface FindTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel; // 显示昵称
@property (nonatomic, strong) UILabel *timeLabel; // 显示创建时间
@property (nonatomic, strong) UILabel *sourceLabel; // 显示来源
@property (nonatomic, strong) UIImageView *avatarView; // 显示头像
@property (nonatomic, strong) YYLabel *wbtextLabel; // 显示微博文本内容
@property (nonatomic, strong) UIImageView *thumbnailView; // 显示微博配图
@property (nonatomic, strong) UIImageView *lastImageView;

@property (nonatomic, strong) UIView *retweetView; // 显示转发微博视图
@property (nonatomic, strong) YYLabel *retweetLabel; // 显示转发微博文本内容 + 昵称
@property (nonatomic, strong) UIImageView *retweetThumbnailView; // 显示转发微博配图
@property (nonatomic, strong) UIImageView *lastRetweetImageView;
@property (nonatomic, strong) UIView *bottomView; // 显示底部状态视图
@property (nonatomic, strong) UIView *grayBarView; // 显示底部灰色视图
@property (nonatomic) NSInteger row; // 保存微博所在行
@property (nonatomic) int64_t id; // 保存微博 ID
@property (nonatomic, strong) FindViewController *homeController;
@property (strong, nonatomic) DetailViewController *detailViewController;
//@property (strong, nonatomic) WPProfileController *profileController;
//@property (strong, nonatomic) WPMeViewController *meViewController;

@property (nonatomic, strong) UIView *repostView; // 显示转发微博视图
@property (nonatomic, strong) UIView *commentView; // 显示评论微博视图
@property (nonatomic, strong) UIView *attitudeView; // 显示点赞视图

@property (strong, nonatomic) UIImageView *attitudeImageView; // 显示点赞图片视图

@property (nonatomic, strong) UILabel *repostLabel; // 显示转发微博文本
@property (nonatomic, strong) UILabel *commentLabel; // 显示评论微博文本
@property (nonatomic, strong) UILabel *attitudeLabel; //显示点赞文本

@property (assign, nonatomic) int imageTag; // 保存微博配图 tag

- (void)adjustHeightForLabel:(YYLabel *)label; // 调节微博文本高度
- (void)setBmiddleViewWithUrl:(NSString *)picUrl withLabel:(YYLabel *)wbLabel; // 只有一张配图时，大图显示
- (void)setThumbnailViewWithUrlArray:(NSArray *)picArray withLabel:(YYLabel *)wbLabel; // 多张配图时，设置配图
- (void)setRetweetBmiddleViewWithUrl:(NSString *)picUrl withLabel:(YYLabel *)retweetLabel; // 转发微博只有一张配图时，大图显示
- (void)setRetweetThumbnailViewWithUrlArray:(NSArray *)retweetPicArray withLabel:(YYLabel *)retweetLabel; // 转发微博多张配图时，设置图片显示
- (void)adjustHeightForRetweetView:(UIView *)retweetView; // 设置 retweetView frame
- (void)adjustHeightForBottomView:(UIView *)bottomView withView:(UIView *)lastView; // 设置 bottomVew frame
- (void)sizeFrameOfRetweetView:(UIView *)retweetView withLastRetweetImageOrLabelView:(UIView *)theView;
- (void)sizeFrameOfView:(UIView *)theView;

- (void)checkProfileAction; // 点击头像或昵称时，传递 row
- (void)cellRepostAction;
- (void)CellCommentAction;
- (void)attitudeAction; // 改变“点赞”图片显示

- (void)repostActionInProfile;
- (void)commentActionInPfofile;

- (void)repostActionInMe;
- (void)commentActionInMe;

@end
