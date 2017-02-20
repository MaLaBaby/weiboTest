//
//  FutureWeatherTableViewCell.m
//  新闻
//
//  Created by 薛海涛 on 16/4/12.
//  Copyright © 2016年 薛海涛. All rights reserved.
//

#import "FutureWeatherTableViewCell.h"

@implementation FutureWeatherTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.weekdayLabel.textColor = [UIColor whiteColor];
    self.weatherLabel.textColor = [UIColor whiteColor];
    self.tempRangeLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
