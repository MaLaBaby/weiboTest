//
//  DetailViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TimelineModel.h"

#define DETAIL_SECTION_HEADER_HEIGHT 30.0 // 设置节头高度

@class FindTableViewCell, Statuses;
@interface DetailViewController : UIViewController

@property (nonatomic, strong) Statuses *statusModel; // 保存微博信息
@property (nonatomic) CGFloat rowHeight; // 保存表头高度 tableHeaderHeight
@property (nonatomic, strong) AppDelegate *myDelegate; // 保存应用委托
@property (nonatomic, strong) NSMutableArray *tableArray; // 保存全部评论信息 commentsArray
@property (strong, nonatomic) IBOutlet UITableView *commentView;
@property (nonatomic, strong) FindTableViewCell *homeCell; // 显示 home table view cell
@property (nonatomic) CGFloat rowHeight_2; // 保存 cell 高度 rowHeight
@property (assign, nonatomic) int64_t weiboid; // 保存微博 ID
@property (strong, nonatomic) UIScrollView *checkView; // 显示“查看大图” scroll view
@property (strong, nonatomic) UIImageView *bigImageView; // 显示图片 image view
@property (copy, nonatomic) NSString *sinceID; // 保存微博 ID，若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博)
@property (copy, nonatomic) NSString *maxID; // 保存微博 ID，若指定此参数，则返回ID小于或等于max_id的微博
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UILabel *Commentscount;
@property (assign, nonatomic) CGFloat currentScale; // 保存当前图片缩放比例
- (void)checkRetweetImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag;
- (void)checkImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag;
@end
