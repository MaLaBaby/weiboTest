//
//  UnloginSetViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/10.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnloginSetViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *setTableview;

@property (nonatomic, strong) NSMutableArray *titleArray;

@end
