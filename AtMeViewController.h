//
//  AtMeViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/22.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface AtMeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mytableView;

@property (nonatomic, strong) NSMutableArray *atInfoArray;

@property (nonatomic, strong) AppDelegate *myDelegate; // 保存应用委托


@end
