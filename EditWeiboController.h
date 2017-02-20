//
//  EditWeiboController.h
//  weiboTest
//
//  Created by haitao on 17/1/18.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"

@class AppDelegate;

@interface EditWeiboController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;// 显示滚动视图
@property (nonatomic, strong) YYTextView *theTextView; // 显示文本输入框
@property (nonatomic, strong) AppDelegate *myDelegate; // 保存应用委托
@property (nonatomic, strong) NSString *placeholderText; // 保存输入框占位文本

@property (nonatomic, copy) NSString *urlString; // 保存微博 API 字符串
@property (nonatomic, copy) NSDictionary *paramsDictionary; // 保存请求所需的参数
@property (nonatomic, copy) NSString *requestTag; // 保存请求 tag
@property (nonatomic) int64_t id; // 保存微博 ID

@end
