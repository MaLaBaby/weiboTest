//
//  FindTableViewCell+ConfigureForStatusesInDetail.h
//  weiboTest
//
//  Created by haitao on 17/1/19.
//  Copyright © 2017年 Haitao.xue. All rights reserved.
//

#import "FindTableViewCell.h"
#import "TimelineModel.h"
@interface FindTableViewCell (ConfigureForStatusesInDetail)
- (CGFloat)configureForStatuses:(Statuses *)statuses; // 配置 statuses
@end
