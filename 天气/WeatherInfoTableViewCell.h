//
//  WeatherInfoTableViewCell.h
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *weatherImage;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UIImageView *Pm25Image;
@property (strong, nonatomic) IBOutlet UILabel *Pm25Label;
@property (strong, nonatomic) IBOutlet UILabel *tempRangeLabel;
@property (strong, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) IBOutlet UILabel *updataDateLabel;

@end
