//
//  MyViewController.h
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,WBHttpRequestDelegate>

@property (nonatomic, strong) UITableView *mytableview;

@property (nonatomic, strong) UITableView *loginTableView;

@property (strong, nonatomic) AppDelegate *myDelegate; // 应用委托

@property (strong, nonatomic) NSMutableDictionary *infoDic;// 保存用户信息

@property (strong, nonatomic) NSMutableArray *titleArray;//保存分栏标题

@property (strong, nonatomic) NSMutableArray *titleImgArray;//保存分栏标题图片

@property (copy, nonatomic) NSString *sinceID; // 微博 ID，若指定此参数，则返回 ID 比 since_id 大的微博（即比 since_id 时间晚的微博)

@end
