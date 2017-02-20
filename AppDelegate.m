//
//  AppDelegate.m
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "WeiboAPIMacro.h"
#import "WeiboSDK.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    self.selectedCities = [[NSMutableArray alloc]init];
    _selectedCityDic = [[NSMutableDictionary alloc]init];
    [_selectedCityDic setObject:@"101190401" forKey:@"苏州市"];
    [_selectedCityDic setObject:@"101010100" forKey:@"北京市"];
    [_selectedCityDic setObject:@"101030100" forKey:@"天津市"];
    [_selectedCities addObject:@"苏州市"];
    [_selectedCities addObject:@"北京市"];
    [_selectedCities addObject:@"天津市"];
    // Override point for customization after application launch.
    
    
    MainViewController *tabBarController = [[MainViewController alloc] init];
//    tabBarController.viewControllers = @[homeView,messageView,findView,myView];
    
    
    self.window.rootViewController = tabBarController;
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Override

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WeiboSDK handleOpenURL:url delegate:self];
}
#pragma mark - WeiboSDKDelegate
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        self.wbRefreshToken = [(WBAuthorizeResponse *)response refreshToken];}
    if (self.wbtoken) {
        // 成功授权
        [[NSNotificationCenter defaultCenter]postNotificationName:@"已登录" object:nil];
    }else if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        NSLog(@"WBSendMessageToWeiboResponse");
    }else if ([response isKindOfClass:WBPaymentResponse.class]) {
        NSLog(@"WBPaymentResponse");
    }else if ([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSLog(@"第三方应用私信好友推荐app的响应");
    }else if ([response isKindOfClass:WBShareMessageToContactResponse.class]) {
        NSLog(@"WBShareMessageToContactResponse");
    }
}

@end
