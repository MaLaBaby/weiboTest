//
//  LoginedSetViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WeiboSDK.h"

@interface LoginedSetViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,WBHttpRequestDelegate>

@property (nonatomic, strong) UITableView *setTableView;

@property (nonatomic, strong) NSMutableArray *titleAry;//存储标题的数组

@property (nonatomic, strong) NSMutableArray *otherAry;//存储缓存大小的数组

@property (strong, nonatomic) AppDelegate *myDelegate; // 应用委托


@end
