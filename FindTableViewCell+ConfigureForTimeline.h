//
//  FindTableViewCell+ConfigureForTimeline.h
//  weiboTest
//
//  Created by haitao on 17/1/17.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindTableViewCell.h"

@class Statuses, FindViewController;

@interface FindTableViewCell (ConfigureForTimeline)

- (CGFloat)configureForHomeTimeLine:(Statuses *)statusesModel indexPath:(NSIndexPath *)indexPath viewController:(FindViewController *)aViewController; // 配置 cell

@end
