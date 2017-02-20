//
//  AppDelegate.h
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, copy) NSString *wbtoken; // 微博认证口令
@property (nonatomic, copy) NSString *wbCurrentUserID; // 当前用户ID
@property (nonatomic, copy) NSString *wbRefreshToken; // 当认证口令过期时用于换取认证口令的更新口令
@property (nonatomic, retain) NSMutableArray *selectedCities;
@property (nonatomic, retain) NSMutableDictionary *selectedCityDic;
@property (nonatomic, retain) NSString *selectedCity;
@property (nonatomic, retain) NSString *selectedCityNum;

@end

