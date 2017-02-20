//
//  FutureWeatherTableViewCell.h
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FutureWeatherTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageview;
@property (strong, nonatomic) IBOutlet UILabel *tempRangeLabel;

@end
