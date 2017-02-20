//
//  VideoLIstController.m
//  VIdeoTest
//
//  Created by haitao on 17/2/13.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "VideoLIstController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Model.h"
#import "VideoInformationCell.h"
#import "XLVideoPlayer.h"




#define videoURL @"http://c.3g.163.com/nc/video/list/VAP4BFR16/y/0-10.html"
@interface VideoLIstController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@end

@implementation VideoLIstController

- (void)viewDidLoad {
    [super viewDidLoad];
    _VideoListArray = [[NSMutableArray alloc]init];
    [self GetVideoList];
    self.navigationItem.title = @"视频列表";
    _VideoListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_VideoListTableView];
    _VideoListTableView.tableFooterView = [[UIView alloc]init];
    self.VideoListTableView.delegate = self;
    self.VideoListTableView.dataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_player destroyPlayer];
    _player = nil;
}

- (void)GetVideoList{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:videoURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             //NSLog(@"Data = %@",responseObject);
             NSArray *dataArray = responseObject[@"VAP4BFR16"];
             for (NSDictionary *dict in dataArray) {
                 [_VideoListArray addObject:[Model mj_objectWithKeyValues:dict]];
             }
             //NSLog(@"data = %@",_VideoListArray);
             [self.VideoListTableView reloadData];
         }
     
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.VideoListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 238.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VideoInformationCell *cell = [VideoInformationCell videoCellWithTableView:tableView];
    Model *item = self.VideoListArray[indexPath.row];
    cell.videoItem = item;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showVideoPlayer:)];
    [cell.CoverImageView addGestureRecognizer:tap];
    cell.CoverImageView.tag = indexPath.row + 100;
    return cell;
}

- (void)showVideoPlayer:(UIGestureRecognizer *)tapGesture{
    
    [_player destroyPlayer];
    _player = nil;
    
    UIView *view = tapGesture.view;
    Model *item = _VideoListArray[view.tag - 100];
    
    _indexPath = [NSIndexPath indexPathForRow:view.tag - 100 inSection:0];
    VideoInformationCell *cell = [self.VideoListTableView cellForRowAtIndexPath:_indexPath];
    
    _player = [[XLVideoPlayer alloc]init];
    _player.videoUrl = item.mp4_url;
    [_player playerBindTableView:self.VideoListTableView currentIndexPath:_indexPath];
    _player.frame = view.bounds;
    
    [cell.contentView addSubview:_player];
    _player.completedPlayingBlock = ^(XLVideoPlayer *player) {
        [player destroyPlayer];
        _player = nil;
    };
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:self.VideoListTableView]) {
        
        [_player playerScrollIsSupportSmallWindowPlay:YES];
    }
}


@end

