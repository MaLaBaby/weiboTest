//
//  MessageViewController.h
//  weiboTest
//
//  Created by haitao on 17/1/18.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *myTableview;

@property (strong, nonatomic) NSMutableArray *infoArray;
@property (strong, nonatomic) NSMutableArray *detailArray;

@end
