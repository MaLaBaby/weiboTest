//
//  MainViewController.m
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import "MainViewController.h"
#import "MYTabBar.h"
#import "FindViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"
#import "BHBPopView.h"
#import "EditWeiboController.h"
#import "WeiboAPIMacro.h"
#import "VideoLIstController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "WeatherViewController.h"

@interface MainViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

{
    UIImagePickerController *_imagePickerController;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
    
    MYTabBar *tabBar = [[MYTabBar alloc]init];
    tabBar.tabBarDelegate = self;
    
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    FindViewController *findView = [[FindViewController alloc] init];
    findView.title = @"发现";
    findView.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
//    findView.tabBarItem.selectedImage= [UIImage imageNamed:@"tabbar_discover_selected"];
    UINavigationController *findNav = [[UINavigationController alloc]initWithRootViewController:findView];
    
    WeatherViewController *homeView = [[WeatherViewController alloc] init];
    homeView.title = @"天气";
    homeView.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
//    homeView.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    
//    MessageViewController *messageView = [[MessageViewController alloc] init];
//    messageView.title = @"消息";
    VideoLIstController *videoView = [[VideoLIstController alloc]init];
    videoView.title = @"视频";
    videoView.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
//    messageView.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    UINavigationController *messageNav = [[UINavigationController alloc]initWithRootViewController:videoView];
    
    
    MyViewController *myView = [[MyViewController alloc] init];
    myView.title = @"我";
    myView.tabBarItem.image= [UIImage imageNamed:@"tabbar_profile"];
//    myView.tabBarItem.selectedImage= [UIImage imageNamed:@"tabbar_profile_selected"];
    UINavigationController *myNav = [[UINavigationController alloc]initWithRootViewController:myView];
    
    self.viewControllers = @[homeView,messageNav,findNav,myNav];
}

#pragma mark - MYTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(MYTabBar *)tarBar
{
//    AddViewController *addViewController = [[AddViewController alloc] init];
//    
//    [self presentViewController:addViewController animated:NO completion:nil];
    BHBItem * item0 = [[BHBItem alloc]initWithTitle:@"文本" Icon:@"images.bundle/tabbar_compose_idea"];
    BHBItem * item1 = [[BHBItem alloc]initWithTitle:@"相册" Icon:@"images.bundle/tabbar_compose_photo"];
    BHBItem * item2 = [[BHBItem alloc]initWithTitle:@"相机" Icon:@"images.bundle/tabbar_compose_camera"];
    //第4个按钮内部有一组
    BHBGroup * item3 = [[BHBGroup alloc]initWithTitle:@"记录" Icon:@"images.bundle/tabbar_compose_lbs"];
    BHBItem * item31 = [[BHBItem alloc]initWithTitle:@"朋友圈" Icon:@"images.bundle/tabbar_compose_friend"];
    BHBItem * item32 = [[BHBItem alloc]initWithTitle:@"秒拍" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    BHBItem * item33 = [[BHBItem alloc]initWithTitle:@"音乐" Icon:@"images.bundle/tabbar_compose_music"];
    item3.items = @[item31,item32,item33];
    
    BHBItem * item4 = [[BHBItem alloc]initWithTitle:@"点评" Icon:@"images.bundle/tabbar_compose_review"];
    
    //第六个按钮内部有一组
    BHBGroup * item5 = [[BHBGroup alloc]initWithTitle:@"更多" Icon:@"images.bundle/tabbar_compose_more"];
    BHBItem * item51 = [[BHBItem alloc]initWithTitle:@"朋友圈" Icon:@"images.bundle/tabbar_compose_friend"];
    BHBItem * item52 = [[BHBItem alloc]initWithTitle:@"秒拍" Icon:@"images.bundle/tabbar_compose_wbcamera"];
    BHBItem * item53 = [[BHBItem alloc]initWithTitle:@"音乐" Icon:@"images.bundle/tabbar_compose_music"];
    BHBItem * item54 = [[BHBItem alloc]initWithTitle:@"博客" Icon:@"images.bundle/tabbar_compose_weibo"];
    BHBItem * item55 = [[BHBItem alloc]initWithTitle:@"众筹" Icon:@"images.bundle/tabbar_compose_transfer"];
    BHBItem * item56 = [[BHBItem alloc]initWithTitle:@"声音" Icon:@"images.bundle/tabbar_compose_voice"];
    item5.items = @[item51,item52,item53,item54,item55,item56];
    
    
    //添加popview
    [BHBPopView showToView:self.view.window withItems:@[item0,item1,item2,item3,item4,item5]andSelectBlock:^(BHBItem *item) {
        if ([item isKindOfClass:[BHBGroup class]]) {
            NSLog(@"选中%@分组",item.title);
        }else{
            NSLog(@"选中%@项",item.title);
            if ([item.title isEqualToString:item0.title]) {
                EditWeiboController *editWeiboController = [EditWeiboController new];
                editWeiboController.title = @"发微博";
                editWeiboController.placeholderText = @"分享新鲜事...";
                editWeiboController.urlString = STATUSES_UPDATE;
                editWeiboController.requestTag = @"statuses_update";
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editWeiboController];
                [self presentViewController:navigationController animated:YES completion:nil];
            }else if ([item.title isEqualToString:item1.title]){
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                [self presentViewController:_imagePickerController animated:YES completion:nil];
            }else if ([item.title isEqualToString:item2.title]){
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                //录制视频时长，默认10s
                _imagePickerController.videoMaximumDuration = 15;
                
                //相机类型（拍照、录像...）字符串需要做相应的类型转换
                _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
                
                //视频上传质量
                //UIImagePickerControllerQualityTypeHigh高清
                //UIImagePickerControllerQualityTypeMedium中等质量
                //UIImagePickerControllerQualityTypeLow低质量
                //UIImagePickerControllerQualityType640x480
                _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
                
                //设置摄像头模式（拍照，录制视频）为录像模式
                _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
                [self presentViewController:_imagePickerController animated:YES completion:nil];
            }
        }
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
