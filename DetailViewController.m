//
//  DetailViewController.m
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "DetailViewController.h"
#import "WeiboSDK.h"
#import "MJRefresh.h"
#import "EditWeiboController.h"
#import "WeiboAPIMacro.h"
#import "FindTableViewCell.h"
#import "MaLaMacro.h"
#import "CommentsCell.h"
#import "CommentsModel.h"
#import "CommentsCell+ConfigureForComments.h"
#import "FindTableViewCell+ConfigureForStatusesInDetail.h"
#import "YYKit.h"
#import "MRProgress.h"

static NSString *identifier = @"CellID";

@interface DetailViewController ()<WBHttpRequestDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation DetailViewController

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

- (void)checkImageWithRow:(NSInteger)row viewTag:(NSInteger)aTag {
    self.checkView = [UIScrollView new];
    [self.myDelegate.window addSubview:self.checkView];
    self.bigImageView = [UIImageView new];
    NSString *imageURL = [self.statusModel large_pic_urls][aTag];
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
    NSString *imageURL = [self.statusModel retweetLarge_pic_urls][aTag];
    
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

- (void)setCommentView:(UITableView *)commentView {
    commentView.showsVerticalScrollIndicator = NO;
    commentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self _requestForCommentInfoWithSinceID:self.sinceID maxID:@"0"];
    }];
    commentView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self _requestForCommentInfoWithSinceID:@"0" maxID:self.maxID];
    }];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 35, 0);
    commentView.contentInset = edgeInsets;
    _commentView = commentView;
}

#pragma mark - Action

- (void)_repostActionInDetail {
    EditWeiboController *editWeiboController = [EditWeiboController new];
    editWeiboController.title = @"转发微博";
    editWeiboController.placeholderText = @"说说分享心得...";
    editWeiboController.urlString = STATUSES_REPOST;
    editWeiboController.requestTag = @"statuses_repost";
    editWeiboController.id = self.weiboid;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editWeiboController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

- (void)_commentActionInDetial {
    EditWeiboController *editWeiboController = [EditWeiboController new];
    editWeiboController.title = @"发评论";
    editWeiboController.placeholderText = @"写评论...";
    editWeiboController.urlString = COMMENTS_CREATE;
    editWeiboController.requestTag = @"comments_create";
    editWeiboController.id = self.weiboid;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editWeiboController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableArray = [NSMutableArray new];
    self.myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.navigationItem.title = @"微博正文";
    self.commentView.tableHeaderView = [self _setTableHeaderView];
    self.commentView.tableFooterView = [UIView new];
    self.sinceID = @"0";
    self.maxID = @"0";
    [self.commentView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (UIView *)_setTableHeaderView {
    FindTableViewCell *cell = [FindTableViewCell new];
    cell.detailViewController = self;
    self.homeCell = cell;
    self.rowHeight = [cell configureForStatuses:self.statusModel];
    cell.contentView.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, self.rowHeight);
    [self _setBottomViewOfCell:cell];
    return cell.contentView;
}

- (void)_setBottomViewOfCell:(FindTableViewCell *)cell {
    cell.repostView = [UIView new];
    UITapGestureRecognizer *repostTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_repostActionInDetail)];
    [cell.repostView addGestureRecognizer:repostTapGestureRecognizer];
    cell.commentView = [UIView new];
    UITapGestureRecognizer *commentTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_commentActionInDetial)];
    [cell.commentView addGestureRecognizer:commentTapGestureRecognizer];
    cell.attitudeView = [UIView new];
    UITapGestureRecognizer *attitudeTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(attitudeAction1)];
    [cell.attitudeView addGestureRecognizer:attitudeTapGestureRecognizer];
    
    cell.bottomView = [UIView new];
    cell.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 35, cell.bottomView.frame.size.width, cell.bottomView.frame.size.height);
    cell.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:cell.bottomView];
    cell.repostLabel.text = @"转发";
    cell.commentLabel.text = @"评论";
    cell.attitudeLabel.text = @"赞";
}

- (void)_requestForCommentInfoWithSinceID:(NSString *)sinceID maxID:(NSString *)maxID {
    NSMutableDictionary *paramsDictionary = [NSMutableDictionary new];
    [paramsDictionary setObject:self.statusModel.idstr forKey:@"id"];
    [paramsDictionary setObject:sinceID forKey:@"since_id"];
    [paramsDictionary setObject:maxID forKey:@"max_id"];
    [paramsDictionary setObject:@"10" forKey:@"count"];
    [self requestForOpenAPIWithURL:COMMENTS_SHOW params:paramsDictionary withTag:@"comments_show"];
}
-(void)attitudeAction1{
    NSLog(@"hahaha");
    UIImage *attitudeImage_0 = [UIImage imageNamed:@"icon_zan_0"];
    if ([self.homeCell.attitudeImageView.image isEqual:attitudeImage_0]) {
        self.homeCell.attitudeImageView.image = [UIImage imageNamed:@"icon_zan_1"];
    }else {
        self.homeCell.attitudeImageView.image = [UIImage imageNamed:@"icon_zan_0"];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UINib *nib = [UINib nibWithNibName:@"CommentsCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    CommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[CommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }else {
        while ((UIView *)[cell.contentView.subviews lastObject]) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    Comments *comments = self.tableArray[indexPath.row];
    NSLog(@"aaaaa====%@",self.tableArray[indexPath.row]);
    self.rowHeight_2 = [cell configureForCommentsInDetailController:comments];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeight_2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return DETAIL_SECTION_HEADER_HEIGHT;
}

#pragma mark - Http request

- (void)requestForOpenAPIWithURL:(NSString *)url params:(NSDictionary *)extraParams withTag:(NSString *)tag {
    [WBHttpRequest requestWithAccessToken:self.myDelegate.wbtoken url:url httpMethod:@"GET" params:extraParams delegate:self withTag:tag];
}

#pragma mark - WBHttpRequestDelegate

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"user_timeline请求失败：%@", error.userInfo);
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"user_timeline收到微博请求响应");
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data {
    if ([request.tag isEqualToString:@"comments_show"]) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        CommentsModel *commentsModel = [CommentsModel modelWithJSON:data];
        if ([self.commentView.mj_header isRefreshing]) {
            [self.tableArray insertObjects:commentsModel.comments atIndex:0];
        }
        if ([self.commentView.mj_footer isRefreshing]) {
            [self.tableArray addObjectsFromArray:commentsModel.comments];
        }
        self.sinceID = [[self.tableArray firstObject] idstr];
        if (self.sinceID == nil) {
            self.sinceID = @"0";
        }
        self.maxID = [[NSNumber numberWithLongLong:([[self.tableArray lastObject] id] - 1)] stringValue];
        if (self.maxID == nil) {
            self.maxID = @"0";
        }
        NSString *str = @"评论 ";
        NSString *total_number = [[NSNumber numberWithLongLong:commentsModel.total_number] stringValue];
        NSInteger totals = total_number.integerValue;
        self.Commentscount.text = [str stringByAppendingString:[TimelineModel shortedNumberDesc:totals]];
        
        if (commentsModel.total_number == self.tableArray.count) {
            [self.commentView.mj_footer endRefreshingWithNoMoreData];
            self.commentView.mj_footer.hidden = YES;
        }else {
            [self.commentView.mj_footer endRefreshing];
            self.commentView.mj_footer.hidden = NO;
        }
    }
    [self.commentView reloadData];
    [self.commentView.mj_header endRefreshing];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.bigImageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    self.currentScale = scale;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
