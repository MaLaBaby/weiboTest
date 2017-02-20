//
//  AtMeCell+ConfigureForAtMe.h
//  weiboTest
//
//  Created by haitao on 17/2/7.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "AtMeCell.h"
@class Statuses_two,AtMeViewController;

@interface AtMeCell (ConfigureForAtMe)

- (CGFloat)configureForAtMe:(Statuses_two *)statusesModel indexPath:(NSIndexPath *)indexPath viewController:(AtMeViewController *)aViewController; // 配置 cell
@end
