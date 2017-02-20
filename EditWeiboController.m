//
//  EditWeiboController.m
//  weiboTest
//
//  Created by haitao on 17/1/18.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "EditWeiboController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "MaLaMacro.h"

@interface EditWeiboController ()<WBHttpRequestDelegate, UIScrollViewDelegate>

- (void)_cancelAction; // 取消编辑操作
- (void)_sendAction; // 发微博

@end

@implementation EditWeiboController

#pragma mark - Accessor

- (void)setTheTextView:(YYTextView *)theTextView {
    theTextView.frame = CGRectMake(8, 0, 304, SCREEN_HEIGHT);
    theTextView.placeholderTextColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1.0];
    theTextView.placeholderFont = [UIFont systemFontOfSize:15.0];
    theTextView.font = [UIFont systemFontOfSize:15.0];
    theTextView.placeholderText = self.placeholderText;
    _theTextView = theTextView;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    scrollView.showsVerticalScrollIndicator = NO;
    _scrollView = scrollView;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theTextView = [YYTextView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.theTextView];
    [self.theTextView becomeFirstResponder];
    self.myDelegate = [UIApplication sharedApplication].delegate;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(_cancelAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(_sendAction)];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0/255.0 green:180/255.0 blue:31/255.0 alpha:1.0];
}

#pragma mark - Action

- (void)_cancelAction {
    [self.theTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)_sendAction {
    [self.theTextView resignFirstResponder];
    NSString *status = self.theTextView.text;
    if (status) {
        if ([self.requestTag isEqualToString:@"statuses_update"]) {
            NSMutableDictionary *updateDictionary = [NSMutableDictionary new];
            [updateDictionary setObject:status forKey:@"status"];
            self.paramsDictionary = updateDictionary;
        }
        if ([self.requestTag isEqualToString:@"statuses_repost"]) {
            NSMutableDictionary *repostDicionary = [NSMutableDictionary new];
            [repostDicionary setObject:status forKey:@"status"];
            NSString *idstr = [[NSNumber numberWithLongLong:self.id] stringValue];
            [repostDicionary setObject:idstr forKey:@"id"];
            self.paramsDictionary = repostDicionary;
        }
        if ([self.requestTag isEqualToString:@"comments_create"]) {
            NSMutableDictionary *commentsRequestParamsDictionary = [NSMutableDictionary new];
            [commentsRequestParamsDictionary setObject:status forKey:@"comment"];
            NSString *idstr = [[NSNumber numberWithLongLong:self.id] stringValue];
            [commentsRequestParamsDictionary setObject:idstr forKey:@"id"];
            self.paramsDictionary = commentsRequestParamsDictionary;
        }
        [self requestForOpenAPIWithURL:self.urlString params:self.paramsDictionary withTag:self.requestTag];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Http request

- (void)requestForOpenAPIWithURL:(NSString *)url params:(NSDictionary *)extraParams withTag:(NSString *)tag {
    [WBHttpRequest requestWithAccessToken:self.myDelegate.wbtoken url:url httpMethod:@"POST" params:extraParams delegate:self withTag:tag];
}

#pragma mark - WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"user_timeline请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"user_timeline收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    if ([request.tag isEqualToString:@"statuses_update"]) {
        __unused NSDictionary *resultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    if ([request.tag isEqualToString:@"statuses_repost"]) {
        __unused NSDictionary *repostDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    if ([request.tag isEqualToString:@"comments_create"]) {
        __unused NSDictionary *commentsResultDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.theTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
