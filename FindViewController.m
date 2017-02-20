//
//  FindViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindViewController.h"
#import "MJRefresh.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"
#import "TimelineModel.h"
#import "FindTableViewCell.h"
#import "YYKit.h"
#import "MRProgress.h"
#import "FindTableViewCell+ConfigureForTimeline.h"
#import "WeiboAPIMacro.h"
#import "MaLaMacro.h"
#import "DetailViewController.h"
#import "EditWeiboController.h"
#import "CurrentUserModel.h"
#import "MyViewController.h"

static NSString *identifier = @"Cell";

@interface FindViewController ()<UITableViewDelegate, UITableViewDataSource, WBHttpRequestDelegate, UIScrollViewDelegate>

- (void)_removeCheckView; // 取消大图显示
- (void)_requestForHomeTimelineInfoWithSinceID:(NSString *)sinceID maxID:(NSString *)maxID; // 请求获取当前登录用户及其所关注（授权）用户的最新微博
- (void)_requestForCurrentUserInfo; // 根据用户ID获取用户信息
- (void)_handleDoubleTap; // 处理双击手势事件
- (void)_dealWithHomeTimelineRequestData:(NSData *)data; // 处理 home_timeline 请求获取的数据
- (void)_dealWithUserInfoRequestData:(NSData *)data; // 处理 userInfo 请求获取的数据

@end

@implementation FindViewController

#pragma mark - Accessor



- (void)setCheckView:(UIScrollView *)checkView {
    checkView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    checkView.backgroundColor = [UIColor blackColor];
    checkView.userInteractionEnabled = YES;
    checkView.maximumZoomScale = MAXIMUM_ZOOM_SCALE;
    checkView.minimumZoomScale = MINIMUM_ZOOM_SCALE;
    checkView.delegate = self;
    checkView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    checkView.bounces = NO;
    
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_removeCheckView)];
    [checkView addGestureRecognizer:singleTapGestureRecognizer];
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleDoubleTap)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    doubleTapGestureRecognizer.numberOfTouchesRequired = 1;
    [checkView addGestureRecognizer:doubleTapGestureRecognizer];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    
    _checkView = checkView;
}

- (void)setBigImageView:(UIImageView *)bigImageView {
    bigImageView.frame = CGRectMake(0, 30, SCREEN_WIDTH, SCREEN_HEIGHT - 60);
    bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    bigImageView.userInteractionEnabled = YES;
    bigImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;
    _bigImageView = bigImageView;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, TABBAR_HEIGHT, 0);
    _myTableView.contentInset = edgeInsets;
    _myTableView.tableFooterView = [[UIView alloc] init];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self _requestForHomeTimelineInfoWithSinceID:self.sinceID maxID:@"0"];
    }];
    _myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self _requestForHomeTimelineInfoWithSinceID:@"0" maxID:self.maxID];
    }];

    self.tableArray = [NSMutableArray new];
    self.myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.sinceID = @"0";
    self.maxID = @"0";
//    [self.myTableView.mj_header beginRefreshing];
//    [self _requestForCurrentUserInfo];
    
    [self.myTableView registerClass:[FindTableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.myDelegate.wbCurrentUserID) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"未登录，无法查看微博消息"] message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert
                                animated:YES
                              completion:nil];
    }else{
    [self.myTableView.mj_header beginRefreshing];
        [self _requestForCurrentUserInfo];}
}

- (void)_requestForHomeTimelineInfoWithSinceID:(NSString *)sinceID maxID:(NSString *)maxID{
    NSMutableDictionary *paramsDictionary = [NSMutableDictionary new];
    [paramsDictionary setObject:sinceID forKey:@"since_id"];
    [paramsDictionary setObject:maxID forKey:@"max_id"];
    [paramsDictionary setObject:@"10" forKey:@"count"];
    [paramsDictionary setObject:@"0" forKey:@"feature"];
    [self requestForOpenAPIWithURL:kHOME_TIMELINE params:paramsDictionary withTag:@"home_timeline"];
}

- (void)_requestForCurrentUserInfo {
    NSMutableDictionary *requestUserInfoParams = [NSMutableDictionary new];
    [requestUserInfoParams setObject:self.myDelegate.wbCurrentUserID forKey:@"uid"];
    [self requestForOpenAPIWithURL:kUSER_SHOW params:requestUserInfoParams withTag:@"userInfo"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[FindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while ([cell.contentView.subviews lastObject]) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    Statuses *statusesModel = self.tableArray[indexPath.row];
    self.rowHeight = [cell configureForHomeTimeLine:statusesModel indexPath:indexPath viewController:self];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewController *detailController = [DetailViewController new];
    detailController.statusModel = self.tableArray[indexPath.row];
    detailController.weiboid = [self.tableArray[indexPath.row] id];
    [self.navigationController pushViewController:detailController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action

- (void)checkProfile:(NSInteger)row {
    //    WPProfileController *profileController = [WPProfileController new];
    //    profileController.userDictionary = [self.tableArray[row] wbuser];
    //    [self.navigationController pushViewController:profileController animated:YES];
}



- (void)repostAction:(int64_t)idstr {
        EditWeiboController *editWeiboController = [EditWeiboController new];
        editWeiboController.title = @"转发微博";
        editWeiboController.placeholderText = @"说说分享心得...";
        editWeiboController.urlString = STATUSES_REPOST;
        editWeiboController.requestTag = @"statuses_repost";
        editWeiboController.id = idstr;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editWeiboController];
        [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)commentActionWithRow:(NSInteger)row weiboid:(int64_t)weiboid {
        EditWeiboController *editWeiboController = [EditWeiboController new];
        editWeiboController.title = @"发评论";
        editWeiboController.placeholderText = @"写评论...";
        editWeiboController.urlString = COMMENTS_CREATE;
        editWeiboController.requestTag = @"comments_create";
        editWeiboController.id = [self.tableArray[row] id];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editWeiboController];
        [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)checkImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag {
    self.checkView = [UIScrollView new];
    [self.myDelegate.window addSubview:self.checkView];
    self.bigImageView = [UIImageView new];
    NSString *imageURL = [self.tableArray[row] large_pic_urls][aTag];
    [self.checkView addSubview:self.bigImageView];
    MRProgressOverlayView *progressView = [MRProgressOverlayView showOverlayAddedTo:self.bigImageView
                                                                              title:@"Loading"
                                                                               mode:MRProgressOverlayViewModeIndeterminateSmallDefault
                                                                           animated:YES
                                                                          stopBlock:nil];
    
    [self.bigImageView setImageWithURL:[NSURL URLWithString:imageURL]
                           placeholder:nil
                               options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur
                               manager:nil
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  
                                  CGFloat progress;
                                  progress = (CGFloat)receivedSize / expectedSize;
                                  if (progress >= 0.9) {
                                      [progressView removeFromSuperview];
                                  }
                              } transform:nil
                            completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                
                                [progressView removeFromSuperview];
                            }];
}

- (void)_removeCheckView {
    self.currentScale = MINIMUM_ZOOM_SCALE;
    [self.checkView removeFromSuperview];
}

- (void)checkRetweetImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag {
    self.checkView = [UIScrollView new];
    [self.myDelegate.window addSubview:self.checkView];
    self.bigImageView = [UIImageView new];
    [self.checkView addSubview:self.bigImageView];
    NSString *imageURL = [self.tableArray[row] retweetLarge_pic_urls][aTag];
    
    MRProgressOverlayView *progressView = [MRProgressOverlayView showOverlayAddedTo:self.bigImageView
                                                                              title:@"Loading"
                                                                               mode:MRProgressOverlayViewModeIndeterminateSmallDefault
                                                                           animated:YES
                                                                          stopBlock:nil];
    [self.bigImageView setImageWithURL:[NSURL URLWithString:imageURL]
                           placeholder:nil
                               options:YYWebImageOptionSetImageWithFadeAnimation | YYWebImageOptionProgressiveBlur
                               manager:nil
                              progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                  
                                  CGFloat progress;
                                  progress = (CGFloat)receivedSize / expectedSize;
                                  if (progress >= 0.9) {
                                      [progressView removeFromSuperview];
                                  }
                              } transform:nil
                            completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                                
                                [progressView removeFromSuperview];
                            }];
}

- (void)_handleDoubleTap {
    if (self.currentScale == MAXIMUM_ZOOM_SCALE) {
        self.currentScale = MINIMUM_ZOOM_SCALE;
        [self.checkView setZoomScale:self.currentScale animated:YES];
        return;
    }else {
        self.currentScale = MAXIMUM_ZOOM_SCALE;
        [self.checkView setZoomScale:self.currentScale animated:YES];
    }
}

#pragma mark - Http request

- (void)requestForOpenAPIWithURL:(NSString *)url params:(NSDictionary *)extraParams withTag:(NSString *)tag {
    [WBHttpRequest requestWithAccessToken:self.myDelegate.wbtoken url:url httpMethod:@"GET" params:extraParams delegate:self withTag:tag];
}

#pragma mark - WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    if ([request.tag isEqualToString:@"home_timeline"]) {
        [self _dealWithHomeTimelineRequestData:data];
        
        [self.myTableView reloadData];
        [self.myTableView.mj_header endRefreshing];
        [self.myTableView.mj_footer endRefreshing];
        return;
    }
    if ([request.tag isEqualToString:@"userInfo"]) {
        [self _dealWithUserInfoRequestData:data];
    }
}

- (void)_dealWithHomeTimelineRequestData:(NSData *)data {
    TimelineModel *homeTimeline = [TimelineModel modelWithJSON:data];
    if ([self.myTableView.mj_header isRefreshing]) {
        [self.tableArray insertObjects:homeTimeline.statuses atIndex:0];
    }
    if ([self.myTableView.mj_footer isRefreshing]) {
        [self.tableArray addObjectsFromArray:homeTimeline.statuses];
    }
    
    for (Statuses *status in self.tableArray) {
        NSMutableArray *largeImageURLArray = [NSMutableArray new];
        for (NSDictionary *thumbDict in status.pic_urls) {
            NSString *thumbURL = thumbDict[@"thumbnail_pic"];
            NSString *largeURL = [thumbURL stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
            [largeImageURLArray addObject:largeURL];
        }
        status.large_pic_urls = largeImageURLArray;
        
        if (status.retweeted_status) {
            NSMutableArray *retweetLargeImageURLArray = [NSMutableArray new];
            NSArray *retweetPicURLs = status.retweeted_status[@"pic_urls"];
            for (NSDictionary *thumbURLDict in retweetPicURLs) {
                NSString *thumbURL = thumbURLDict[@"thumbnail_pic"];
                NSString *largeURL = [thumbURL stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"large"];
                [retweetLargeImageURLArray addObject:largeURL];
            }
            status.retweetLarge_pic_urls = retweetLargeImageURLArray;
        }
    }
    self.sinceID = [[self.tableArray firstObject] idstr];
    if (self.sinceID == nil) {
        self.sinceID = @"0";
    }
    self.maxID = [[NSNumber numberWithLongLong:([[self.tableArray lastObject] id] - 1)] stringValue];
}

- (void)_dealWithUserInfoRequestData:(NSData *)data {
        CurrentUserModel *currentUser = [CurrentUserModel modelWithJSON:data];
        self.tabBarController.navigationItem.title = @"首页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.currentScale = scale;
}

@end
