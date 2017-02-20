//
//  FindViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface FindViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic, strong) AppDelegate *myDelegate; // 保存应用委托
@property (nonatomic, strong) NSMutableArray *tableArray; // 保存“微博状态”信息
@property (nonatomic) CGFloat rowHeight; // 保存 cell 行度
@property (nonatomic) NSInteger row; // 保存当前点击的 cell 行数

@property (copy, nonatomic) NSString *sinceID; // 保存微博 ID，若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博)
@property (copy, nonatomic) NSString *maxID; // 保存微博 ID，若指定此参数，则返回ID小于或等于max_id的微博

@property (strong, nonatomic) UIScrollView *checkView; // 显示“查看大图” scroll view
@property (strong, nonatomic) UIImageView *bigImageView; // 显示图片 image view
@property (assign, nonatomic) NSInteger viewTag; // 保存被点击的图片的 tag 值
@property (assign, nonatomic) CGFloat currentScale; // 保存当前图片缩放比例

- (void)checkProfile:(NSInteger)row; // 查看关注用户资料
- (void)repostAction:(int64_t)idstr; // 转发微博
- (void)commentActionWithRow:(NSInteger)row weiboid:(int64_t)weiboid; // 评论微博

- (void)checkImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag; // 查看原创微博大图
- (void)checkRetweetImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag; // 查看转发微博大图
@end
