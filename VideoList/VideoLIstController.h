//
//  VideoLIstController.h
//  VIdeoTest
//
//  Created by haitao on 17/2/13.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLVideoPlayer.h"

@interface VideoLIstController : UIViewController

@property (nonatomic, strong) UITableView *VideoListTableView;//存放视频列表

@property (nonatomic, strong) NSMutableArray *VideoListArray;

@property (nonatomic, strong) XLVideoPlayer *player;

@property (nonatomic, assign) NSIndexPath *indexPath;

@end
