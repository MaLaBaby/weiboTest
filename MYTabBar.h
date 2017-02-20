//
//  MYTabBar.h
//  weiboTest
//
//  Created by yaopeng on 16/12/26.
//  Copyright © 2016年 Haitao.xue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTabBar;

@protocol MYTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(MYTabBar *)tarBar;

@end

@interface MYTabBar : UITabBar

@property(strong,nonatomic) UIButton *plusBtn;
@property(nonatomic,weak) id<MYTabBarDelegate> tabBarDelegate;

@end
